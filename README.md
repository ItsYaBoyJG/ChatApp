# ChatApp - Social Video Chat Mobile App

A comprehensive Flutter-based social communication app that combines video calling, messaging, camera features, and location sharing - inspired by popular social media platforms like Snapchat.

## Features

### 🎥 Video Chat
- Real-time video calling powered by Stream Video SDK
- Camera and microphone controls during calls
- Call management with hang up, mute, and camera switching
- Permission handling for camera and microphone access

### 💬 Text Messaging
- Real-time chat functionality using Firebase Chat Core
- Friends list management
- Message threads and conversations
- User authentication via Firebase Auth

### 📸 Camera & Media
- Full-featured camera interface with photo and video capture
- Advanced camera controls (flash, exposure, focus modes)
- Front/back camera switching
- Zoom and tap-to-focus functionality
- Video recording with pause/resume capabilities

### 🗺️ Location & Maps
- Google Maps integration showing user and friends' locations
- Real-time location sharing with friends
- Custom map markers for friend locations
- Location permission management

### 👤 Social Features
- User profiles with snap counts, friends, and following stats
- Stories, memories, and snaps (photo/video sharing)
- Friend discovery and management
- User authentication and account management

### 📱 App Structure
- **Home**: Main hub with bottom navigation between Chat, Map, Video, and Discover
- **Chat**: Message threads and friend conversations
- **Map**: Location-based friend finder
- **Video Chat**: One-on-one video calling
- **Discover**: Content discovery with stories and recommendations
- **Profile**: User account management and content viewing
- **Camera**: Standalone camera interface for content creation

## Technical Stack

- **Frontend**: Flutter (Dart)
- **Video Calling**: Stream Video Flutter SDK
- **Real-time Chat**: Firebase Chat Core & Flutter Chat UI
- **Authentication**: Firebase Auth
- **Database**: Cloud Firestore
- **Maps**: Google Maps Flutter
- **State Management**: Riverpod with Hooks
- **Navigation**: Go Router
- **Camera**: Flutter Camera Plugin

This project demonstrates a modern social communication app with comprehensive multimedia features and real-time connectivity.


