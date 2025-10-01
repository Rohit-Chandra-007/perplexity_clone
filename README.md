# Perplexity AI Clone

A modern AI-powered search application built with Flutter and FastAPI, featuring real-time streaming responses, intelligent source aggregation, and persistent chat history.

## 📸 Screenshots

### **Home Screen - Search Interface**
![Home Screen](screenshots/home-screen.png)
*Clean, modern search interface with system font typography and status indicators*

### **Chat Interface - Real-time Streaming**
![Chat Interface](screenshots/chat-interface.png)
*Live conversation with streaming AI responses and source attribution*

### **Search Results - Source Cards**
![Search Results](screenshots/search-results.png)
*Intelligent source aggregation with clickable reference cards*

### **Chat History - Persistent Storage**
![Chat History](screenshots/history-screen.png)
*Complete conversation history with Firebase cloud sync*

### **Mobile Responsive Design**
<div align="center">
<img src="screenshots/mobile-view.png" alt="Mobile View" width="300"/>
</div>

*Fully responsive design optimized for mobile devices*

### **Status Indicators - Connection Feedback**
![Status Indicators](screenshots/status-indicators.png)
*Real-time WebSocket and Firebase connection status with color-coded feedback*

> **📸 Note**: To add actual screenshots, follow the [Screenshot Guide](SCREENSHOT_GUIDE.md) and replace the placeholder references above with real images of your running application.

## ✨ Features

### 🎯 **Core Functionality**
- **Real-time AI Chat**: Stream responses from Google Gemini AI
- **Intelligent Search**: Web search with relevance ranking using Tavily API
- **Source Attribution**: Automatic source linking and citation
- **Chat History**: Persistent conversation history with Firebase/Local storage
- **Cross-platform**: Works on web and desktop

### 🎨 **User Experience**
- **Modern UI**: Clean, responsive design with Material Design
- **Loading States**: Skeleton loading and real-time status indicators
- **Error Handling**: Graceful fallbacks and user-friendly error messages
- **Responsive Design**: Optimized for all screen sizes
- **Web-safe Fonts**: System fonts with intelligent fallbacks

### ⚡ **Performance**
- **WebSocket Communication**: Real-time bidirectional communication
- **State Management**: Efficient Riverpod with code generation
- **Automatic Cleanup**: Memory management and resource optimization
- **Firebase Integration**: Cloud sync with local storage fallback

## 🚀 Quick Start

### **Option 1: Automated Setup (Recommended)**
```bash
# Windows: Double-click or run
start_dev.bat

# Or PowerShell
powershell -ExecutionPolicy Bypass -File start_dev.ps1
```

### **Option 2: Manual Setup**
```bash
# Terminal 1: Backend
cd server
uv run python main.py

# Terminal 2: Frontend
flutter run -d chrome
```

## 🏗️ Architecture

### **System Flow**
```
User Query → Flutter UI → Riverpod State → WebSocket → FastAPI Backend
    ↓
Tavily Search → Similarity Ranking → Gemini AI → Streaming Response
    ↓
WebSocket → Riverpod State → UI Update → Firebase/Local Storage
```

### **Technology Stack**

#### **Frontend (Flutter)**
- **Framework**: Flutter 3.8.0+ with Material Design
- **State Management**: Riverpod with code generation (@riverpod)
- **Architecture**: MVVM (Model-View-ViewModel)
- **Communication**: WebSocket client for real-time updates
- **Storage**: Firebase Firestore with local storage fallback
- **UI**: Custom widgets with skeleton loading states

#### **Backend (Python)**
- **Framework**: FastAPI with WebSocket support
- **AI Integration**: Google Generative AI SDK (Gemini)
- **Search**: Tavily API for web search
- **Ranking**: sentence-transformers for similarity calculation
- **Validation**: Pydantic for data models
- **Runtime**: Python 3.12+ with uv package manager

## 📁 Project Structure

```
perplexity_clone/
├── 📱 Frontend (Flutter)
│   ├── lib/
│   │   ├── models/
│   │   │   └── chat_models.dart          # Freezed data models
│   │   ├── providers/
│   │   │   ├── chat_provider.dart        # Chat state management
│   │   │   └── history_provider.dart     # History management
│   │   ├── services/
│   │   │   ├── websocket_service.dart    # WebSocket communication
│   │   │   ├── firebase_service.dart     # Firebase initialization
│   │   │   └── chat_history_service.dart # History persistence
│   │   ├── screens/
│   │   │   ├── home_screen.dart          # Landing page
│   │   │   ├── chat_screen.dart          # Chat interface
│   │   │   └── history_screen.dart       # Chat history
│   │   ├── widgets/
│   │   │   ├── search_section.dart       # Search input
│   │   │   ├── answer_section.dart       # AI responses
│   │   │   ├── sources_section.dart      # Source cards
│   │   │   ├── connection_status.dart    # Connection indicator
│   │   │   └── firebase_status.dart      # Storage status
│   │   ├── theme/
│   │   │   ├── web_safe_theme.dart       # System font theme
│   │   │   └── app_colors.dart           # Color constants
│   │   └── utils/
│   │       └── font_helper.dart          # Safe font loading
│   └── web/
│       └── assets/
│           └── AssetManifest.json        # Web asset manifest
│
├── 🖥️ Backend (Python)
│   ├── server/
│   │   ├── main.py                       # FastAPI application
│   │   ├── config.py                     # Environment configuration
│   │   ├── services/
│   │   │   ├── llm_service.py           # Gemini AI integration
│   │   │   ├── search_service.py        # Tavily search
│   │   │   └── sort_search_service.py   # Result ranking
│   │   └── pydantic_models/
│   │       └── chat_body.py             # Request/response models
│
├── 📚 Documentation
│   ├── FIREBASE_SETUP.md                # Firebase configuration
│   ├── TROUBLESHOOTING.md               # Common issues
│   ├── MANUAL_START.md                  # Manual startup guide
│   └── ASSET_FIXES.md                   # Font/asset solutions
│
└── 🛠️ Scripts
    ├── start_dev.bat                     # Windows startup script
    └── start_dev.ps1                     # PowerShell startup script
```

## 🔧 Prerequisites

### **Required Software**
- **Flutter SDK**: 3.8.0+ ([Install Guide](https://docs.flutter.dev/get-started/install))
- **Python**: 3.12+ ([Download](https://www.python.org/downloads/))
- **uv**: Python package manager ([Install Guide](https://docs.astral.sh/uv/getting-started/installation/))

### **API Keys (Already Configured)**
- **Tavily API**: Web search functionality
- **Gemini API**: AI response generation

## 🚀 Detailed Setup

### **1. Clone Repository**
```bash
git clone <repository-url>
cd perplexity_clone
```

### **2. Backend Setup**
```bash
cd server
uv sync                    # Install dependencies
uv run python main.py      # Start server
```

**Expected Output:**
```
INFO: Uvicorn running on http://0.0.0.0:8000
```

### **3. Frontend Setup**
```bash
flutter pub get                           # Install dependencies
dart run build_runner build              # Generate code
flutter run -d chrome                    # Start app
```

**Expected Output:**
```
Launching lib\main.dart on Chrome in debug mode...
```

### **4. Firebase Setup (Optional)**
```bash
# Enable Firestore in Firebase Console
# Project: myreactapp-81c10
# See FIREBASE_SETUP.md for details
```

## 🎯 Usage Guide

### **Basic Usage**
1. **Start Services**: Run `start_dev.bat` or manual setup
2. **Open App**: Chrome opens automatically
3. **Ask Question**: Type in search box and press enter
4. **View Response**: Watch real-time streaming response
5. **Check Sources**: Click on source cards for references
6. **View History**: Click "History" in sidebar

### **Status Indicators**
- 🟢 **Green**: "Connected to Firebase Firestore" - Cloud sync active
- 🟠 **Orange**: "Firebase unavailable - using local storage" - Local fallback
- 🔴 **Red**: Connection errors with dismiss option

### **Chat History**
- **Automatic Save**: Completed conversations saved automatically
- **Cloud Sync**: Available across devices (with Firebase)
- **Local Backup**: Browser storage fallback
- **Management**: Delete individual chats or clear all

## 🔌 API Reference

### **WebSocket Endpoints**
```
ws://localhost:8000/ws/chat
```

**Message Format:**
```json
// Client → Server
{"query": "Your question here"}

// Server → Client (Search Results)
{"type": "search_result", "data": [{"title": "...", "url": "..."}]}

// Server → Client (Content Stream)
{"type": "content", "data": "Response chunk..."}

// Server → Client (Completion)
{"type": "complete", "data": "Response completed"}
```

### **REST API**
```
GET  /                    # Health check
POST /chat               # Single chat request (alternative to WebSocket)
```

## 🛠️ Development

### **Code Generation**
```bash
# After modifying Riverpod providers or Freezed models
dart run build_runner build --delete-conflicting-outputs
```

### **Hot Reload**
- **Frontend**: Flutter hot reload (Ctrl+S)
- **Backend**: FastAPI auto-reload on file changes

### **Debugging**
```bash
# Flutter debugging
flutter run -d chrome --debug

# Backend debugging
cd server
uv run python main.py --reload --log-level debug
```

## 🔍 Troubleshooting

### **Common Issues**

| Issue | Solution |
|-------|----------|
| `uv not found` | Install uv: https://docs.astral.sh/uv/ |
| `flutter not found` | Add Flutter to system PATH |
| Font loading errors | Fixed with system font fallbacks |
| WebSocket connection fails | Check backend is running on port 8000 |
| Firebase errors | Normal - app uses local storage fallback |

### **Quick Fixes**
```bash
# Clean rebuild
flutter clean && flutter pub get && dart run build_runner build

# Reset backend
cd server && uv sync && uv run python main.py

# Check services
curl http://localhost:8000  # Should return {"Hello": "World"}
```

## 📊 Performance & Features

### **Performance Metrics**
- **Startup Time**: < 3 seconds
- **Response Time**: Real-time streaming
- **Memory Usage**: Optimized with automatic cleanup
- **Font Loading**: Instant (system fonts)
- **Storage**: Efficient with auto-cleanup (50 recent chats)

### **Browser Compatibility**
- ✅ Chrome (Recommended)
- ✅ Edge
- ✅ Firefox
- ✅ Safari

### **Platform Support**
- ✅ Web (Primary)
- ✅ Windows Desktop
- ✅ macOS Desktop
- ✅ Android Mobile
- ✅ iOS Mobile

## 🤝 Contributing

### **Development Workflow**
1. Fork the repository
2. Create feature branch
3. Make changes with tests
4. Run `flutter analyze` and fix issues
5. Submit pull request

### **Code Standards**
- **Flutter**: Follow official Dart style guide
- **Python**: PEP 8 compliance
- **Documentation**: Update README for new features
- **Testing**: Add tests for new functionality

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🙏 Acknowledgments

- **Google Gemini AI** for intelligent responses
- **Tavily API** for web search capabilities
- **Flutter Team** for the amazing framework
- **FastAPI** for the high-performance backend
- **Firebase** for cloud storage solutions

---

**Built with ❤️ using Flutter & FastAPI**

*Ready to explore the future of AI-powered search!* 🚀
