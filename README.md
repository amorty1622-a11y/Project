# VCare Live - Doctor Appointment Booking App

A modern Flutter application for booking doctor appointments with a clean architecture and beautiful UI.

## Features

- **User Authentication**: Register, login, and profile management
- **Doctor Search**: Find doctors by specialization, location, and availability
- **Appointment Booking**: Schedule appointments with preferred doctors
- **Multi-language Support**: English and Arabic localization
- **Responsive Design**: Optimized for different screen sizes
- **Clean Architecture**: Modular and maintainable code structure

## Tech Stack

- **Framework**: Flutter 3.x
- **Architecture**: Clean Architecture with BLoC pattern
- **State Management**: flutter_bloc
- **Dependency Injection**: get_it
- **Networking**: Dio with Retrofit
- **Local Storage**: SharedPreferences & Flutter Secure Storage
- **Code Generation**: Freezed, JSON Serializable
- **UI/UX**: Material Design 3, Responsive layouts

## Project Structure

```
lib/
├── core/
│   ├── app.dart
│   └── di/
│       └── injection.dart
├── features/
│   ├── auth/
│   │   └── presentation/
│   │       ├── pages/
│   │       └── widgets/
│   ├── home/
│   │   └── presentation/
│   │       ├── pages/
│   │       └── widgets/
│   ├── doctor/
│   │   └── presentation/
│   │       └── pages/
│   ├── appointment/
│   │   └── presentation/
│   │       ├── pages/
│   │       └── widgets/
│   └── profile/
│       └── presentation/
│           ├── pages/
│           └── widgets/
└── shared/
    ├── models/
    └── services/
```

## Getting Started

### Prerequisites

- Flutter SDK (3.0.0 or higher)
- Dart SDK (3.0.0 or higher)
- Android Studio / VS Code
- Git

### Installation

1. Clone the repository:
```bash
git clone https://github.com/your-username/vcare-live.git
cd vcare-live
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

### Build Configuration

- **Android**: `flutter build apk`
- **iOS**: `flutter build ios`
- **Web**: `flutter build web`

## API Integration

The app integrates with the VCare Live API for:
- User authentication and management
- Doctor listings and details
- Appointment booking and management
- Location services (governorates and cities)

## Localization

The app supports multiple languages:
- English (en)
- Arabic (ar)

Translation files are located in `assets/translations/`.

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## License

This project is licensed under the MIT License.

## Support

For support and questions, please open an issue on GitHub.
