import tensorflow as tf
import numpy as np
from PIL import Image

interpreter = tf.lite.Interpreter(model_path="plant_disease_model.tflite")
interpreter.allocate_tensors()

input_details = interpreter.get_input_details()
output_details = interpreter.get_output_details()

with open("class_labels.txt") as f:
    labels = [x.strip() for x in f.readlines()]

def detect_disease(image):

    img = image.resize((224,224))
    img = np.array(img)/255.0
    img = np.expand_dims(img,0).astype(np.float32)

    interpreter.set_tensor(input_details[0]['index'], img)
    interpreter.invoke()

    output = interpreter.get_tensor(output_details[0]['index'])

    index = np.argmax(output[0])

    disease = labels[index]

    confidence = float(np.max(output))

    return disease, confidence