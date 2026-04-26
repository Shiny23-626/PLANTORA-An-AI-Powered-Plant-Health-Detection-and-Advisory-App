# 🌿 Plantora AI — Smart Crop Disease Detection & Treatment System

<p align="center">
  <img src="assets/logo.jpeg" alt="Plantora AI Logo" width="120"/>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-3.x-blue?logo=flutter" />
  <img src="https://img.shields.io/badge/Python-3.10+-green?logo=python" />
  <img src="https://img.shields.io/badge/TensorFlow-Lite-orange?logo=tensorflow" />
  <img src="https://img.shields.io/badge/Streamlit-Web%20App-red?logo=streamlit" />
  <img src="https://img.shields.io/badge/Platform-Android%20%7C%20iOS%20%7C%20Web-lightgrey" />
  <img src="https://img.shields.io/badge/AI%20Accuracy-94.7%25-brightgreen" />
</p>

---

## 📖 About

**Plantora AI** is an end-to-end intelligent plant disease detection system built to empower farmers and agriculturalists. Using a deep learning model trained on thousands of crop leaf images, Plantora AI instantly identifies plant diseases from a photo, recommends medicines and treatments, provides real-time weather-based farming advice, and answers farming questions through an AI assistant — all in one platform.

> 🏆 Built for **TNWISE 2026** — Tamil Nadu Hackathon for Women in Science & Engineering.

---

## 🖥️ App Screenshots

### 🏠 Home — Smart Crop Disease Detection & Treatment System
![Home Screen](<app image1-1.jpeg>)!<img width="1544" height="726" alt="app homescreen" src="https://github.com/user-attachments/assets/33be3e06-75d8-4b1d-8ae8-65bcbdb98533" />


> Stats at a glance: **12,450+ Total Scans · 38 Diseases Detected · 6 Crops Monitored · 94.7% AI Accuracy**

---

### 📊 Dashboard — Crop Health Analytics
![Dashboard](<app image2-1.jpeg>)!<img width="1539" height="733" alt="app image2" src="https://github.com/user-attachments/assets/e8a30dd4-8866-4813-b5eb-8ce98a4f8fd0" />

![Dashboard Charts](<app image3-1.jpeg>)!(<app image4-2.jpeg>)!

> Interactive charts showing **Disease Frequency**, **Crop Health Analytics** (Tomato, Rice, Potato, Wheat), and **Detection History** with confidence scores over time.

---

### 🔍 Disease Detection — Upload & Detect
![Disease Detection](<app image5-1.jpeg>)!

> Select your crop (Rice, Maize, Tomato, Potato, Wheat, Sugarcane), upload a leaf image, and get an **instant AI-powered disease diagnosis**.

---

### 🤖 AI Assistant — Farming Chatbot
![AI Assistant]!(<app image6-1.jpeg>)!

> Ask anything about **crop diseases, fertilizers, irrigation, pest control, and organic farming** — powered by an intelligent AI chatbot.

---

### 🌤️ Weather — Farming-Aware Forecast
![Weather Screen](<app image7-1.jpeg>)!
![Farming Advice](<app image8-1.jpeg>)!S

> Live weather with **5-day forecast** and smart **Farming Advice** cards — High Humidity alerts, Rain warnings, Temperature tips — all tailored for field decisions.

---

## ✨ Features

| Feature | Description |
|---|---|
| 🔍 **Disease Detection** | Upload a leaf photo → instant AI diagnosis with 94.7%+ accuracy |
| 🌾 **6 Crops Supported** | Rice, Maize, Tomato, Potato, Wheat, Sugarcane |
| 💊 **Treatment Plans** | Medicine recommendations, treatment steps & environmental advice |
| 📊 **Smart Analytics** | Disease frequency charts, crop health donut chart, detection history |
| 🤖 **AI Assistant** | Chat about diseases, fertilizers, irrigation, pest control |
| 🌤️ **Weather + Farming Advice** | Live forecast + context-aware farm recommendations |
| 🌐 **Multilingual** | Language support for regional accessibility |
| 📱 **Cross-Platform** | Android, iOS and Web (Streamlit dashboard) |

---

## 🗂️ Project Structure

```
PLANTORA_AI/
│
├── lib/                            # Flutter Mobile App
│   ├── main.dart                   # App entry point
│   ├── splash_screen.dart          # Splash screen
│   ├── home_screen.dart            # Main home screen
│   ├── detection_service.dart      # Disease detection logic
│   ├── result_screen.dart          # Detection results display
│   ├── medicine_service.dart       # Medicine recommendations
│   ├── chatbot_screen.dart         # AI Chatbot UI
│   ├── weather_screen.dart         # Weather screen
│   └── weather_service.dart        # Weather API integration
│
├── planrora_train_model/           # Model Training (Python)
│   ├── train_model.py              # CNN model training
│   ├── train_transfer_model.py     # Transfer learning training
│   ├── test_model.py               # Model evaluation
│   ├── test_tflite.py              # TFLite model testing
│   └── plant_disease_transfer_model.h5
│
├── plantora_streamlit/             # Streamlit Web Dashboard
│   ├── app.py                      # Main web app
│   ├── chatbot.py                  # Chatbot module
│   ├── detection.py                # Detection module
│   ├── weather.py                  # Weather module
│   ├── translation.py              # Translation module
│   ├── medicines.json              # Treatment data
│   ├── class_labels.txt            # Disease class labels
│   └── plant_disease_model.tflite  # Deployed model
│
├── screenshots/                    # App Screenshots
├── plant_disease_model.tflite      # TFLite model (app)
├── class_labels.txt
├── medicines.json
├── pubspec.yaml                    # Flutter dependencies
├── requirements.txt                # Python dependencies
└── README.md
```

---

## 🧠 ML Model Details

| Property | Detail |
|---|---|
| **Architecture** | Transfer Learning (MobileNetV2) |
| **Framework** | TensorFlow / Keras |
| **Deployment Format** | TensorFlow Lite (`.tflite`) |
| **Accuracy** | 94.7% |
| **Inference** | On-device (offline capable) |
| **Dataset** | All Crops Disease Dataset |

### Detected Diseases include:
`Leaf Mold` · `Rice Blast` · `Late Blight` · `Early Blight` · `Yellow Rust` · `Tomato Mosaic Virus` · `Apple Scab` · `Black Rot` · and many more across 6 crop types.

---

## 🚀 Getting Started

### Prerequisites
- [Flutter SDK](https://flutter.dev/docs/get-started/install) 3.x+
- Python 3.10+
- Android Studio / Xcode

---

### 📱 Run the Flutter App

```bash
# Clone the repository
git clone https://github.com/YOUR_USERNAME/Plantora_AI.git
cd Plantora_AI

# Install Flutter dependencies
flutter pub get

# Run on device or emulator
flutter run
```

---

### 🌐 Run the Streamlit Web Dashboard

```bash
cd plantora_streamlit

# Install Python dependencies
pip install -r requirements.txt

# Launch the web app
streamlit run app.py
```

Open your browser at `http://localhost:8501`

---

### 🧪 Test the ML Model

```bash
cd planrora_train_model

# Test H5 model
python test_model.py

# Test TFLite model
python test_tflite.py
```

---

## 📦 Tech Stack

| Layer | Technology |
|---|---|
| Mobile App | Flutter (Dart) |
| Web Dashboard | Streamlit (Python) |
| ML Model | TensorFlow / Keras → TFLite |
| AI Chatbot | Google Generative AI |
| Weather | Weather REST API |
| Translation | Deep Translator |
| Image Processing | OpenCV, Pillow |

---

## 📄 License

This project was independently designed and developed for academic and hackathon purposes.

---

<p align="center">
  Built solo with ❤️ for <strong>TNWISE 2026</strong> — Tamil Nadu Hackathon for Women in Science & Engineering
</p>
