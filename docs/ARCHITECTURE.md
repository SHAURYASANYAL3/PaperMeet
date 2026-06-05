# PaperMeet Architecture

## High-Level Architecture
PaperMeet uses a microservices-inspired modular monolith approach.

### 1. Frontend (Flutter)
- **Framework**: Flutter 3.x (Dart 3.x)
- **Platforms**: iOS, Android, Web, Desktop (macOS/Windows)
- **State Management**: Riverpod
- **Real-time**: Socket.IO client, WebRTC (flutter_webrtc)
- **Theme**: "Notebook" style aesthetic

### 2. Backend (Node.js)
- **Runtime**: Node.js + TypeScript
- **Framework**: Express
- **Real-time**: Socket.IO, Mediasoup (WebRTC SFU)
- **Database ORM**: Prisma
- **Caching/Queues**: Redis + BullMQ
- **Authentication**: JWT, custom OTP, OAuth

### 3. Database Layer
- **Primary**: PostgreSQL (Users, Meetings, Notes, Reports)
- **Key-Value/PubSub**: Redis (Session management, signaling, real-time presence)

### 4. AI Services (Python/Node)
- **Transcription**: Local/Server-side Whisper (OpenAI Whisper)
- **Attention Tracking**: MediaPipe/TensorFlow Lite (Face detection, Head pose, Eye tracking) runs on client-side for privacy and performance. The backend aggregates scores.
- **Meeting Assistant**: LLM integration (OpenAI/Anthropic) for summarization, action items, spam filtering.

### 5. Deployment & Infrastructure
- **Containerization**: Docker
- **Orchestration**: Kubernetes
- **CI/CD**: GitHub Actions
- **Storage**: S3-compatible Object Storage for recordings, transcripts, and avatars

## Data Flow
1. **Signaling**: Client -> Socket.IO -> Backend -> Redis Pub/Sub
2. **Video/Audio**: Client -> WebRTC -> Mediasoup SFU -> Client
3. **AI Attention**: Client (Camera -> TFLite) -> Calculates Score -> Sends score to Backend via WebSockets periodically -> Stored in Postgres.
4. **Transcription**: Mediasoup -> Audio stream -> Whisper Service -> Transcripts -> LLM -> Summaries & Action Items.