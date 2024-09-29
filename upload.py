import cv2
import numpy as np
import face_recognition

imgAbhijay = face_recognition.load_image_file('ImagesBasic/Abhijay Salvi.jpg')
imgAbhijay = cv2.cvtColor(imgAbhijay, cv2.COLOR_BGR2RGB)
imgTest = face_recognition.load_image_file('ImagesBasic/AbhijayTest.jpeg')
imgTest = cv2.cvtColor(imgTest, cv2.COLOR_BGR2RGB)

faceLoc = face_recognition.face_locations(imgAbhijay)[0]
encodeAbhijay = face_recognition.face_encodings(imgAbhijay)[0]
cv2.rectangle(imgAbhijay, (faceLoc[3], faceLoc[0]), (faceLoc[1], faceLoc[2]), (0, 255, 0), 2)

faceLocTest = face_recognition.face_locations(imgTest)[0]
encodeTest = face_recognition.face_encodings(imgTest)[0]
cv2.rectangle(imgTest, (faceLocTest[3], faceLocTest[0]), (faceLocTest[1], faceLocTest[2]), (0, 255, 0), 2)

results = face_recognition.compare_faces([encodeAbhijay], encodeTest)
print(results, " for Abhijay")

cv2.imshow('Abhijay Tester', imgTest)

cv2.waitKey(0)