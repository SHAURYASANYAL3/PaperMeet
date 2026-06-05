from fastapi import FastAPI, UploadFile, File, HTTPException
import whisper
import tempfile
import os

app = FastAPI(title="PaperMeet AI Services")

# Load whisper model (using 'base' for performance in production prototype)
try:
    print("Loading Whisper model...")
    model = whisper.load_model("base")
    print("Whisper model loaded.")
except Exception as e:
    print(f"Error loading whisper model: {e}")
    model = None

@app.get("/health")
def health_check():
    return {"status": "OK", "services": ["transcription", "attention"]}

@app.post("/transcribe")
async def transcribe_audio(file: UploadFile = File(...)):
    if not model:
        raise HTTPException(status_code=503, detail="Transcription model not available")
        
    try:
        # Save temporary file
        fd, temp_path = tempfile.mkstemp(suffix=".wav")
        with os.fdopen(fd, 'wb') as f:
            content = await file.read()
            f.write(content)
            
        # Transcribe
        result = model.transcribe(temp_path)
        
        # Cleanup
        os.remove(temp_path)
        
        return {"text": result["text"]}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

@app.post("/analyze-attention")
async def analyze_attention(data: dict):
    # In a full production implementation, client sends face metrics or frames.
    # We aggregate and score them here.
    # 0-100 score logic implementation
    
    face_score = data.get("face_score", 0)
    screen_score = data.get("screen_score", 0)
    participation_score = data.get("participation_score", 0)
    
    total_score = (face_score * 0.5) + (screen_score * 0.3) + (participation_score * 0.2)
    
    status = "attentive"
    if total_score < 50:
        status = "alert"
    elif total_score < 70:
        status = "warning"
        
    return {
        "focus_score": total_score,
        "status": status
    }

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)
