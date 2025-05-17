# Movie App

A Flutter application that displays movies from The Movie Database (TMDB) API, allows searching, viewing details, and managing favorites.

## Features

- Browse now playing movies with pagination
- Search for movies
- View movie details
- Add/remove movies to favorites
- Offline capability for favorite movies
- Clean architecture implementation
- GetX for state management
- Hive for local database

## Requirements

- Flutter SDK: ^3.6.0
- Dart SDK: ^3.6.0
- Android: minSdkVersion 19
- iOS: iOS 11.0+

## Installation

1. Clone the repository:
   ```
   git clone https://github.com/yourusername/movie_app_fh.git
   cd movie_app_fh
   ```

2. Get dependencies:
   ```
   flutter pub get
   ```

3. Generate required files:
   ```
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

4. Add your TMDB API key:
   - Get an API key from [The Movie Database](https://www.themoviedb.org/documentation/api)
   - Open `lib/core/constants/api_constants.dart`
   - Replace the empty string in `apiKey` with your API key

5. Run the app:
   ```
   flutter run
   ```

## Makefile Commands

For convenience, this project includes a makefile with the following commands:

- `make init`: Runs clean, get, generate, and l10n commands in sequence
- `make clean`: Cleans the project using `flutter clean`
- `make get`: Updates dependencies using `flutter pub get`
- `make generate`: Generates code using build_runner
- `make l10n`: Generates localization files
- `make translation-keys`: Generates translation keys
- `make run`: Runs the example app

Example usage:
```
make init    # Initialize the project
make clean   # Clean the project
make generate # Generate code
```

## Architecture

The app follows Clean Architecture principles with three main layers:

1. **Presentation Layer**: UI components and GetX controllers
   - Pages
   - Widgets
   - Controllers
   - Bindings

2. **Domain Layer**: Business logic and rules
   - Entities
   - Repositories (interfaces)
   - Use Cases

3. **Data Layer**: Data sources and repository implementations
   - Models
   - Repositories (implementations)
   - Data Sources (remote and local)

## Libraries Used

- **State Management**: [GetX](https://pub.dev/packages/get)
- **Local Database**: [Hive](https://pub.dev/packages/hive)
- **Network**: [Dio](https://pub.dev/packages/dio)
- **Connectivity**: [connectivity_plus](https://pub.dev/packages/connectivity_plus)
- **Image Caching**: [cached_network_image](https://pub.dev/packages/cached_network_image)
- **UI Components**: [flutter_rating_bar](https://pub.dev/packages/flutter_rating_bar), [shimmer](https://pub.dev/packages/shimmer)
- **Testing**: [mockito](https://pub.dev/packages/mockito)

## Testing

Run the tests with:
```
flutter test
```

## License

This project is licensed under the MIT License.
