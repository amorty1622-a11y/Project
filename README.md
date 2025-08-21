# VCare Live - Doctor Appointment App

A comprehensive Flutter application for booking doctor appointments with a modern, user-friendly interface.

## Features

### 🔐 Authentication
- **Splash Screen**: Beautiful animated splash screen with app branding
- **Onboarding**: Interactive onboarding flow for first-time users
- **Sign Up**: User registration with validation
- **Login**: Secure user authentication
- **Logout**: Safe user logout with token cleanup

### 🏠 Home Screen
- **Welcome Section**: Personalized greeting and quick actions
- **Search Bar**: Easy doctor and specialization search
- **Specializations**: Horizontal scrollable specialization cards
- **Recommended Doctors**: Curated list of top-rated doctors
- **Quick Navigation**: Easy access to main features

### 👨‍⚕️ Doctor Management
- **Doctor List**: Comprehensive list of all available doctors
- **Doctor Search**: Advanced search with filters (specialization, city, governorate)
- **Doctor Details**: Detailed doctor profiles with:
  - Professional information
  - Specializations and education
  - Experience and ratings
  - Languages spoken
  - Consultation fees
- **Filtering**: Multiple filter options for finding the right doctor

### 📅 Appointment System
- **Book Appointment**: Easy appointment booking with:
  - Date and time selection
  - Optional notes
  - Confirmation system
- **Appointment List**: View all appointments with tabs for:
  - Upcoming appointments
  - Completed appointments
  - Cancelled appointments
- **Appointment Management**: Cancel and reschedule options

### 👤 User Profile
- **Profile View**: Display user information
- **Edit Profile**: Update personal details
- **Settings**: Various app settings and preferences
- **Medical History**: Track medical records (placeholder)
- **Favorites**: Save favorite doctors (placeholder)

## Technical Features

### 🏗️ Architecture
- **Clean Architecture**: Well-structured code organization
- **Dependency Injection**: Using GetIt for service management
- **State Management**: Flutter Bloc for state management
- **API Integration**: RESTful API integration with Dio

### 🔧 Services
- **Authentication Service**: Handle user login/logout/registration
- **API Service**: Generic HTTP client with interceptors
- **Storage Service**: Secure local storage for tokens and user data

### 📱 UI/UX
- **Responsive Design**: Adapts to different screen sizes
- **Material Design 3**: Modern Material Design implementation
- **Custom Widgets**: Reusable UI components
- **Animations**: Smooth transitions and micro-interactions
- **Dark/Light Theme Support**: Theme switching capability

### 🌐 Localization
- **Multi-language Support**: English and Arabic support
- **RTL Support**: Right-to-left language support
- **Cultural Adaptation**: Localized content and formatting

## Getting Started

### Prerequisites
- Flutter SDK (3.8.1 or higher)
- Dart SDK
- Android Studio / VS Code
- Android SDK / Xcode (for mobile development)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/your-username/vcare-live.git
   cd vcare-live
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

### Configuration

1. **API Configuration**
   - Update the base URL in `lib/core/di/injection.dart`
   - Configure your API endpoints

2. **Environment Variables**
   - Set up your environment variables for different build configurations

## Project Structure

```
lib/
├── core/
│   ├── app.dart                 # Main app configuration
│   └── di/
│       └── injection.dart       # Dependency injection
├── features/
│   ├── auth/                    # Authentication module
│   │   ├── presentation/
│   │   │   ├── pages/
│   │   │   │   ├── splash_screen.dart
│   │   │   │   ├── onboarding_screen.dart
│   │   │   │   ├── login_screen.dart
│   │   │   │   └── register_screen.dart
│   │   │   └── widgets/
│   │   │       ├── custom_text_field.dart
│   │   │       └── custom_button.dart
│   │   └── domain/
│   ├── home/                    # Home module
│   │   ├── presentation/
│   │   │   ├── pages/
│   │   │   │   └── home_screen.dart
│   │   │   └── widgets/
│   │   │       ├── doctor_card.dart
│   │   │       └── specialization_card.dart
│   ├── doctor/                  # Doctor module
│   │   ├── presentation/
│   │   │   ├── pages/
│   │   │   │   ├── doctor_list_screen.dart
│   │   │   │   ├── doctor_detail_screen.dart
│   │   │   │   └── doctor_search_screen.dart
│   │   │   └── widgets/
│   ├── appointment/             # Appointment module
│   │   ├── presentation/
│   │   │   ├── pages/
│   │   │   │   ├── book_appointment_screen.dart
│   │   │   │   └── appointment_list_screen.dart
│   │   │   └── widgets/
│   │   │       └── appointment_card.dart
│   └── profile/                 # Profile module
│       ├── presentation/
│       │   ├── pages/
│       │   │   ├── profile_screen.dart
│       │   │   └── edit_profile_screen.dart
│       │   └── widgets/
│       │       └── profile_menu_item.dart
└── shared/
    ├── models/                  # Data models
    │   ├── user_model.dart
    │   ├── doctor_model.dart
    │   ├── appointment_model.dart
    │   ├── specialization_model.dart
    │   └── location_model.dart
    ├── services/                # Business logic services
    │   ├── api_service.dart
    │   ├── auth_service.dart
    │   └── storage_service.dart
    ├── widgets/                 # Shared UI components
    └── utils/                   # Utility functions
```

## Dependencies

### Core Dependencies
- **flutter_bloc**: State management
- **get_it**: Dependency injection
- **dio**: HTTP client
- **retrofit**: API client generator
- **freezed**: Data class generation
- **json_annotation**: JSON serialization

### UI Dependencies
- **flutter_screenutil**: Responsive design
- **flutter_svg**: SVG support
- **cached_network_image**: Image caching
- **shimmer**: Loading animations

### Storage & Security
- **shared_preferences**: Local storage
- **flutter_secure_storage**: Secure storage
- **flutter_native_splash**: Splash screen

### Localization
- **easy_localization**: Multi-language support
- **intl**: Internationalization

## API Integration

The app integrates with a RESTful API that provides:

- **Authentication**: Login, register, logout
- **User Management**: Profile CRUD operations
- **Doctor Management**: List, search, filter doctors
- **Appointment Management**: Book, view, cancel appointments
- **Location Services**: Governorates and cities
- **Specializations**: Medical specializations

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support

For support, email support@vcare-live.com or create an issue in the repository.

## Acknowledgments

- Flutter team for the amazing framework
- Material Design team for design guidelines
- All contributors who helped build this app

---

**VCare Live** - Your Health, Our Priority 🏥
