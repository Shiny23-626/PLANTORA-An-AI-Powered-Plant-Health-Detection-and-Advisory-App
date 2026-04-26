import cv2
import numpy as np
import tensorflow as tf
from tensorflow.keras.preprocessing import image

# Load model
model = tf.keras.models.load_model("plant_disease_model.h5")

# Class labels
labels = [
    "Potato_dataset",
    "Tomato_dataset",
    "maize_dataset",
    "rice_dataset",
    "sugarcane_dataset",
    "wheat_dataset"
]

# Start camera
cap = cv2.VideoCapture(1, cv2.CAP_DSHOW)

print("Press 'q' to exit")

while True:
    ret, frame = cap.read()

    if not ret:
        print("Camera error")
        break

    # Resize image
    img = cv2.resize(frame, (224,224))
    img_array = np.array(img) / 255.0
    img_array = np.expand_dims(img_array, axis=0)

    # Predict
    prediction = model.predict(img_array)
    class_index = np.argmax(prediction)
    confidence = prediction[0][class_index]

    label = labels[class_index]

    # Show result on screen
    text = f"{label} ({confidence:.2f})"
    cv2.putText(frame, text, (20,40),
                cv2.FONT_HERSHEY_SIMPLEX, 1,
                (0,255,0), 2)

    cv2.imshow("Plant Disease Detection", frame)

    if cv2.waitKey(1) & 0xFF == ord('q'):
        break

cap.release()
cv2.destroyAllWindows()