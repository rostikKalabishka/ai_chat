# AI Chat App

A Flutter-based conversational AI assistant powered by Google Generative AI. This application allows users to communicate with an intelligent chatbot using text or voice, view their query history, and benefit from prompt tuning to generate more accurate responses. Firebase is used for Google sign-in and secure user authentication.

## Features

**AI-Powered Chat**: Smart responses using Google Generative AI with support for follow-up questions through prompt tuning.
**Speech-to-Text**: Voice input powered by speech_to_text for hands-free interaction.
**Multilingual Support**: App interface available in Ukrainian, English, and German.
**Search History**: Previous queries are saved locally for easy access.
**Prompt Tuning**: Enhances conversations by making AI ask clarifying questions when needed.
**User Authentication**: Google sign-in with Firebase for secure access.
**Avatar Customization**: Upload and crop profile pictures using image picker and cropper.
**Persistent Storage**: User settings and history are stored locally using Shared Preferences.

## Tech Stack

**Firebase Auth**: Google Sign-In and user authentication
**Firebase Core**: Core Firebase services integration
**Google Generative AI**: Generates smart and natural responses
**Bloc / flutter_bloc**: State management using the BLoC pattern
**AutoRoute**: Declarative route navigation
**GetIt**: Dependency injection
**Shared Preferences**: Local storage for user settings
**Speech to Text**: Converts user voice into text
**Image Picker & Cropper**: Avatar selection and cropping
**Flutter Dotenv**: Securely manage API keys via environment variables
**UUID**: Unique ID generation for sessions and queries
