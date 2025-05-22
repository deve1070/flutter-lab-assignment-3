# Flutter Album Viewer

A Flutter application that fetches and displays albums and photos from the JSONPlaceholder API. The app follows the MVVM architecture pattern and implements modern Flutter development practices.

## Features

- Display a scrollable list of albums with titles and photos
- View detailed information about each album
- Pull-to-refresh functionality
- Error handling with retry options
- Offline caching support
- Smooth navigation between screens
- Loading state indicators
- Hero animations for smooth transitions

## Technical Stack

- **UI Layer**: Flutter Widgets
- **State Management**: BLoC/Cubit
- **Networking**: httpClient
- **Navigation**: GoRouter
- **Architecture**: MVVM
- **Dependency Injection**: GetIt
- **Caching**: In-memory cache with expiration

## Project Structure

```
lib/
├── config/         # App configuration
├── core/           # Core functionality
├── data/           # Data layer
│   ├── cache/      # Caching implementation
│   ├── datasources/# Remote data sources
│   ├── models/     # Data models
│   ├── repositories/# Repository implementations
│   └── services/   # API services
├── di/             # Dependency injection
├── domain/         # Business logic layer
│   ├── models/     # Domain models
│   ├── repositories/# Repository interfaces
│   └── usecases/   # Use cases
└── presentation/   # UI layer
    ├── bloc/       # State management
    ├── screens/    # App screens
    └── widgets/    # Reusable widgets
```

## Getting Started

1. Clone the repository:
```bash
git clone https://github.com/yourusername/flutter-lab-assignment-3.git
```

2. Navigate to the project directory:
```bash
cd flutter-lab-assignment-3
```

3. Install dependencies:
```bash
flutter pub get
```

4. Run the app:
```bash
flutter run
```

## API Endpoints

The app uses the following JSONPlaceholder API endpoints:
- Albums: `https://jsonplaceholder.typicode.com/albums`
- Photos: `https://jsonplaceholder.typicode.com/photos`

## Architecture

The app follows the MVVM (Model-View-ViewModel) architecture pattern:

- **Model**: Data models and repositories
- **View**: Flutter widgets and screens
- **ViewModel**: BLoC/Cubit for state management

## State Management

The app uses BLoC/Cubit for state management, providing:
- Clear separation of concerns
- Predictable state changes
- Easy testing
- Reactive programming

## Error Handling

The app implements comprehensive error handling:
- Network error detection
- User-friendly error messages
- Retry mechanisms
- Offline support with caching

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- [JSONPlaceholder](https://jsonplaceholder.typicode.com/) for providing the API
- [Flutter](https://flutter.dev/) for the amazing framework
- [BLoC](https://bloclibrary.dev/) for state management
- [GoRouter](https://pub.dev/packages/go_router) for navigation
