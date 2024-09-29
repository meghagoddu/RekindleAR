import json
import boto3
import os

def lambda_handler(event, context):
    s3_client = boto3.client('s3')
    rekognition_client = boto3.client('rekognition')
    
    bucket = os.environ['BUCKET_NAME']
    key = event['Records'][0]['s3']['object']['key']
    
    # Call Rekognition to detect labels (objects)
    response = rekognition_client.detect_labels(
        Image={
            'S3Object': {
                'Bucket': bucket,
                'Name': key
            }
        },
        MaxLabels=10
    )
    
    # Extract recognized labels
    labels = response['Labels']
    
    # Format labels into a readable list
    label_list = [{'Name': label['Name'], 'Confidence': label['Confidence']} for label in labels]
    
    return {
        'statusCode': 200,
        'body': json.dumps({
            'message': 'Image processed successfully',
            'labels': label_list
        })
    }
