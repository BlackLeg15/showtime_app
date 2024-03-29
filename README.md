# showtime_app
An app to help you plan your next musical adventure

## 1 Characteristics
### 1.1 Architecture
- Feature-based
- Function-based
- Repository pattern
- Result pattern
### 1.2 State management
- Change Notifier
### 1.3 Dependency injection
- package <i>get_it</i>
### 1.4 Tests
- Unit tests
- Widget tests
### 1.5 Http requests
- package <i>dio</i>
### 1.6 Cache
- package <i>dio_cache_interceptor</i>

## 2 Features
### 2.1 All Shows
Get all the available shows around the world.

### 2.2 5-Day Forecast Weather
Get a 5-day forecast weather for the city you selected.

## 3 Project specs
- Flutter 3.19.3

## 4 How to run the app
The app currently uses my own Open Weather's API Key.\
You can use yours instead.

### 4.1 Android/iOS
flutter run --release --dart-define appid=eb47baba76e422071de69c2341cd0048
### 4.2 Web
flutter run --release -d edge --web-renderer html --dart-define appid=eb47baba76e422071de69c2341cd0048
