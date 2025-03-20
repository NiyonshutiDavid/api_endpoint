from fastapi import FastAPI
from pydantic import BaseModel, Field
from fastapi.middleware.cors import CORSMiddleware
import joblib
import pandas as pd
from typing import List, Union

# --- 1. Load the Trained Model ---
try:
    model_path = "../linear_regression/economic_impact_model.pkl"
    model = joblib.load(model_path)
    print(f"Successfully loaded model from: {model_path}")
except FileNotFoundError:
    print(f"Error: Could not find the trained model at {model_path}. Please ensure it exists.")
    model = None
except Exception as e:
    print(f"An error occurred while loading the model: {e}")
    model = None

# --- 2. Define the Input Data Structure using Pydantic ---
class PredictionInput(BaseModel):
    """
    Input data for predicting Economic Impact.
    Replace the fields and descriptions with your actual dataset's features.
    """
    Average_Temperature_C: float = Field(..., description="Average Temperature in Celsius", ge=-50.0, le=50.0)
    Total_Precipitation_mm: float = Field(..., description="Total Precipitation in mm", ge=0.0, le=10000.0)
    CO2_Emissions_MT: float = Field(..., description="CO2 Emissions in Metric Tons", ge=0.0)
    Crop_Yield_MT_per_HA: float = Field(..., description="Crop Yield per Hectare", ge=0.0)
    Extreme_Weather_Events: int = Field(..., description="Number of Extreme Weather Events", ge=0)
    Irrigation_Access_Percent: float = Field(..., description="Percentage of Irrigation Access", ge=0.0, le=100.0)
    Pesticide_Use_KG_per_HA: float = Field(..., description="Pesticide Use in KG per Hectare", ge=0.0)
    Fertilizer_Use_KG_per_HA: float = Field(..., description="Fertilizer Use in KG per Hectare", ge=0.0)
    Soil_Health_Index: float = Field(..., description="Soil Health Index", ge=0.0, le=100.0)
    Year: int = Field(..., description="Year of the data", ge=1900, le=2100)
    Country: str = Field(..., description="Country Name")
    Region: str = Field(..., description="Region Name")
    Crop_Type: str = Field(..., description="Type of Crop")
    Adaptation_Strategies: str = Field(..., description="Adaptation Strategies Used")

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
    if model is None:
        return {"error": "Model not loaded. Please check the server logs."}

    try:
        # Create a DataFrame from the input data
        input_dict = input_data.model_dump()
        input_df = pd.DataFrame([input_dict])

        # --- Handle Categorical Features (Assuming your model was trained with one-hot encoding) ---
        # You'll need to ensure the categorical columns match the training data
        categorical_cols = ['Country', 'Region', 'Crop_Type', 'Adaptation_Strategies']
        input_df = pd.get_dummies(input_df, columns=categorical_cols, prefix=categorical_cols, dummy_na=False)

        # --- Ensure all expected columns are present and in the correct order ---
        # Get the columns the model was trained on
        expected_columns = list(model.feature_names_in_)

        # Align the input DataFrame columns with the expected columns
        input_df = input_df.reindex(columns=expected_columns, fill_value=0)

        # Make the prediction
        prediction = model.predict(input_df)[0]
        return {"prediction": float(prediction)} # Return as a float
    except Exception as e:
        return {"error": f"Prediction error: {str(e)}"}

# --- 5. Run the API (for local development) ---
if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)