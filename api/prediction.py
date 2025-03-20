from fastapi import FastAPI
from pydantic import BaseModel
from fastapi.middleware.cors import CORSMiddleware
import joblib
import pandas as pd

# --- 1. Load the Trained Model ---
model_path = "../linear_regression/economic_impact_model.pkl"
model = joblib.load(model_path)
print(f"Successfully loaded model from: {model_path}")

# --- 2. Define the Input Data Structure using Pydantic ---
class PredictionInput(BaseModel):
    """
    Input data for predicting Economic Impact.
    Replace the fields and descriptions with your actual dataset's features.
    """
    Average_Temperature_C: float
    Total_Precipitation_mm: float
    CO2_Emissions_MT: float
    Crop_Yield_MT_per_HA: float
    Extreme_Weather_Events: int
    Irrigation_Access_Percent: float
    Pesticide_Use_KG_per_HA: float
    Fertilizer_Use_KG_per_HA: float
    Soil_Health_Index: float
    Year: int
    Country: str
    Region: str
    Crop_Type: str
    Adaptation_Strategies: str

    # Add more fields based on your new dataset

# --- 3. FastAPI App Setup ---
app = FastAPI(title="Climate Impact Prediction API",
              description="API to predict the economic impact based on climate and agricultural factors.")

# Add CORS middleware
origins = ["*"]  # Allows all origins (for development)
app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# --- 4. Prediction Endpoint ---
@app.post("/predict")
def predict(input_data: PredictionInput):
    try:
        # Create a DataFrame from the input data
        input_dict = input_data.model_dump()
        input_df = pd.DataFrame([input_dict])

        # Make the prediction
        prediction = model.predict(input_df)[0]
        return {"prediction": float(prediction)} # Return as a float
    except Exception as e:
        return {"error": f"Prediction error: {str(e)}"}

# --- 5. Run the API (for local development) ---
if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)
