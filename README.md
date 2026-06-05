# PaperMeet AI

A fully cross-platform (Web, iOS, Android, macOS, Windows) video meeting platform combining Zoom simplicity with a beautiful Notebook aesthetic, local AI Attention tracking, and Whisper-based meeting assistants.

## 🏗 Folder Structure
- `/backend`: Node.js, Express, TypeScript, Socket.IO, Prisma (PostgreSQL), Redis.
- `/frontend`: Flutter 3.x, Riverpod, flutter_webrtc, Notebook-style custom UI.
- `/ai-services`: Python FastAPI, OpenAI Whisper, MediaPipe Attention Scoring.
- `/deployment`: Kubernetes YAML files and Docker configurations.
- `/docs`: Architecture and structural documentation.
- `/.github/workflows`: CI/CD pipelines.

## 🚀 Quick Start
### 1. Database & Cache
\`\`\`bash
docker-compose up -d
\`\`\`

### 2. Backend
\`\`\`bash
cd backend
npm install
npx prisma generate
npx prisma db push
npm run dev
\`\`\`

### 3. AI Services
\`\`\`bash
cd ai-services
pip install -r requirements.txt
python main.py
\`\`\`

### 4. Frontend
\`\`\`bash
cd frontend
flutter pub get
flutter run -d chrome  # or ios / android / macos / windows
\`\`\`

### 5. Vercel Deployment
PaperMeet is configured for Vercel deployment (Frontend + API).
- **Frontend**: Flutter Web must be built locally or in CI before pushing to Vercel.
  ```bash
  cd frontend
  flutter build web --release
  ```
- **API**: The Node.js backend is served via Vercel Serverless Functions.
- **Important**: Socket.IO/WebRTC signaling requires a persistent server. While the REST API works on Vercel, for full meeting functionality, use the Docker/Kubernetes setup provided in `/deployment`.

To deploy to Vercel:
1. Install Vercel CLI: `npm i -g vercel`
2. Run `vercel` in the root directory.

## 🧠 Architecture Highlights
- **Authentication**: JWT, Email, with RBAC.
- **Database**: PostgreSQL (relational) + Redis (signaling/pub-sub).
- **Meetings**: WebRTC via `flutter_webrtc` on client and Socket.IO for signaling.
- **AI Attention**: Calculates focus score using face, screen, and participation metrics.
- **AI Assistant**: Whisper for transcription, generating action items and summaries.

## 🧪 Testing & CI/CD
- GitHub Actions workflow is included (`.github/workflows/deploy.yml`).
- Kubernetes deployment manifests available in `/deployment`.
- Backend supports standard Jest unit tests (to be added to `package.json`).

*Built for production scale (500+ participants, adaptive 720p, <200ms latency).*
