import tensorflow as tf

# Load trained model
model = tf.keras.models.load_model("plant_disease_model.h5")

# Convert to TFLite format
converter = tf.lite.TFLiteConverter.from_keras_model(model)
tflite_model = converter.convert()

# Save the model
with open("plant_disease_model.tflite", "wb") as f:
    f.write(tflite_model)

print("Conversion complete. plant_disease_model.tflite created.")