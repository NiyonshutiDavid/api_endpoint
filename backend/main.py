from fastapi import FastAPI, File, UploadFile
import pandas as pd
import matplotlib.pyplot as plt
import io
import uvicorn

app = FastAPI()

@app.post("/upload/")
async def upload_file(file: UploadFile = File(...)):
    df = pd.read_csv(file.file)
    return {"columns": df.columns.tolist(), "preview": df.head().to_dict()}

@app.post("/plot/")
async def plot_graph(x_column: str, y_column: str, file: UploadFile = File(...)):
    df = pd.read_csv(file.file)
    
    if x_column not in df.columns or y_column not in df.columns:
        return {"error": "Invalid columns selected"}

    plt.figure(figsize=(8, 6))
    plt.plot(df[x_column], df[y_column], marker='o')
    plt.xlabel(x_column)
    plt.ylabel(y_column)
    plt.title(f"Plot of {y_column} vs {x_column}")
    
    img_buf = io.BytesIO()
    plt.savefig(img_buf, format='png')
    img_buf.seek(0)

    return {"plot_image": img_buf.getvalue()}

if __name__ == "__main__":
    port = int(os.getenv("PORT", 8000))  # Use Render's assigned PORT
    uvicorn.run(app, host="0.0.0.0", port=port)
