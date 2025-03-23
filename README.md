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

### **📌 Source**: The dataset is derived from **kaggle**, data repositories, and research publications on climate change and food security.

---

## **🌍 Publicly Available API Endpoint**  
📌 **Base URL**: [https://your-api-url.onrender.com](https://your-api-url.onrender.com)  

📌 **Swagger UI (Test API Here)**: [https://your-api-url.onrender.com/docs](https://your-api-url.onrender.com/docs)  

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
🔗 **Watch the demo (max 2 minutes)**: [YouTube Link](https://youtube.com/your-demo-link)  

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

## **🛠️ Tech Stack**  
- **Machine Learning Model**: `Linear Regression`  
- **Backend API**: `FastAPI`, `Pydantic`, `CORS`  
- **Frontend**: `Flutter`, `Dart`, `Google Fonts (Inter)`  
- **Hosting**: `Render` (for API)  

---

### ✒️ **Author**  
- David Niyonshuti