# **Climate & Agriculture Impact Prediction API & App** 🌱📊  

## **🚀 Mission**  
This project aims to leverage **Machine Learning** to predict the **economic impact** of climate change on agriculture. Using **FastAPI** and a **Flutter app**, users can input relevant climate and agricultural data to estimate potential economic outcomes in Millions USD. 

---

## **📊 Data Source**  
The dataset used in this project is **climate_change_impact_on_agriculture_2024.csv**. It includes features such as:  
- **Average Temperature (°C)**  
- **Total Precipitation (mm)**  
- **CO₂ Emissions (MT)**  
- **Irrigation Access (%)**  
- **Extreme Weather Events**  
- **Pesticide & Fertilizer Usage**  
- **Soil Health Index**  
- **Crop Yield (MT/HA)**  
- **Economic Impact (Million USD) (Target Variable)**  

### **📌 Source**: The dataset is derived from **kaggle**, dataset link: [https://www.kaggle.com/datasets/waqi786/climate-change-impact-on-agriculture]

---

## **🌍 Publicly Available API Endpoint**  
📌 **Base URL**: [https://api-endpoint-dtym.onrender.com/.](https://api-endpoint-dtym.onrender.com/)  

📌 **Swagger UI (Test API Here)**: [https://api-endpoint-dtym.onrender.com/docs](https://api-endpoint-dtym.onrender.com/docs)  

### **🔹 API Usage (POST Request)**
📌 **Endpoint:** `/predict`  
📌 **Request Format (JSON)**:
```json
{
  "Average_Temperature_C": 25.3,
  "Total_Precipitation_mm": 100.2,
  "CO2_Emissions_MT": 15.5,
  "Irrigation_Access_Percent": 45.0,
  "Extreme_Weather_Events": 3,
  "Pesticide_Use_KG_per_HA": 20.5,
  "Fertilizer_Use_KG_per_HA": 35.0,
  "Soil_Health_Index": 7.2,
  "Crop_Yield_MT_per_HA": 3.8
}
```

📌 **Response Example**:
```json
{
  "prediction": 152.75
}
```

---

## **🎥 Video Demo**  
🔗 **Watch the demo**: [YouTube Link](https://youtu.be/G6NmjqP_Xrw)  

---

## **📱 How to Run the Mobile App (Flutter)**  

### **1️⃣ Prerequisites**  
✅ Install **Flutter**: [Flutter Installation Guide](https://flutter.dev/docs/get-started/install)  
✅ Install **Dart SDK** (comes with Flutter)  
✅ Install **VS Code / Android Studio**  

### **2️⃣ Clone the Repository**  
```bash
git clone https://github.com/NiyonshutiDavid/api_endpoint.git
cd api_endpoint/flutter_app
```

### **3️⃣ Install Dependencies**  
```bash
flutter pub get
```

### **4️⃣ Run the App**  
```bash
flutter run
```

---

## **📲 Mobile App Features**  
✔ **TextFields**: Input climate & agricultural variables.  
✔ **"Predict" Button**: Calls the API and displays results.  
✔ **Result Display**: Shows predicted economic impact.  
✔ **User-friendly UI**: Themed around **agriculture, climate change, and economy**.  

---

## **📱 App UI **
![welcome](https://github.com/user-attachments/assets/cb0d022a-2638-4261-843c-fedc7c75f7c9)
![input](https://github.com/user-attachments/assets/6c719fbd-ea71-4b91-a11c-e842742b639b)
![output](https://github.com/user-attachments/assets/905fe367-753a-4f4f-8d8a-9afe54fc9c66)


## **🛠️ Tech Stack**  
- **Machine Learning Model**: `Linear Regression`  
- **Backend API**: `FastAPI`, `Pydantic`, `CORS`  
- **Frontend**: `Flutter`, `Dart`, `Google Fonts (Inter)`  
- **Hosting**: `Render` (for API)  

---

### ✒️ **Author**  
- David Niyonshuti
