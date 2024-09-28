//@input SceneObject image1
//@input SceneObject image2
//@input Component.HandTracking handTracking

function onUpdate(eventData) {
    var hand = script.handTracking.getHand(0);
    if (hand) {
        var pinchStrength = hand.getPinchStrength();
        if (pinchStrength > 0.8) { // Adjust the threshold as needed
            script.image1.enabled = false;
            script.image2.enabled = true;
        }
    }
}

var updateEvent = script.createEvent("UpdateEvent");
updateEvent.bind(onUpdate);
