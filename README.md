# GraphQL Demo with GetX

A comprehensive Flutter demo project showcasing GraphQL API integration with GetX state management.

## Features

- **GraphQL Integration**: Uses the Countries GraphQL API to fetch country data
- **GetX State Management**: Reactive state management with GetX controllers
- **Modern UI**: Material Design 3 with responsive layouts
- **Error Handling**: Comprehensive error handling for network requests
- **Loading States**: Beautiful loading indicators during data fetching
- **Filtering**: Filter countries by continent
- **Detailed Views**: Country detail screens with comprehensive information

## Architecture

```
lib/
├── core/
│   └── graphql_client.dart     # GraphQL client configuration
├── models/
│   ├── country.dart           # Country data models
│   └── language.dart          # Language data models
├── controllers/
│   └── countries_controller.dart # GetX controller for state management
├── services/
│   └── countries_service.dart    # GraphQL service layer
├── views/
│   ├── countries_screen.dart     # Main countries list screen
│   └── country_detail_screen.dart # Country detail screen
└── main.dart                     # App entry point with GetX setup
```

## Dependencies

- **graphql_flutter**: GraphQL client for Flutter
- **get**: State management and navigation
- **http**: HTTP client for network requests
- **cached_network_image**: Image caching (for future enhancements)

## Getting Started

### Prerequisites

- Flutter SDK (3.6.0 or higher)
- FVM (Flutter Version Management) - optional but recommended

### Installation

1. Clone the repository:
```bash
git clone <repository-url>
cd graphqldemo
```

2. Install dependencies:
```bash
fvm flutter pub get
```

3. Run the app:
```bash
fvm flutter run
```

## Usage

1. **Countries List**: The main screen displays a list of countries with their flags (emojis), names, capitals, and currencies.

2. **Filtering**: Use the continent dropdown to filter countries by continent (All, Africa, Asia, Europe, etc.).

3. **Country Details**: Tap on any country to view detailed information including:
   - Basic information (capital, currency, continent)
   - Languages spoken with native and RTL information

4. **Error Handling**: If network errors occur, the app displays user-friendly error messages with retry options.

5. **Loading States**: Beautiful loading indicators show while fetching data.

## GraphQL API

This demo uses the public [Countries GraphQL API](https://countries.trevorblades.com/graphql) which provides:

- Country information (name, code, capital, currency, emoji)
- Language data (name, native, RTL support)
- Continent information

## Key Features Demonstrated

### GetX State Management
- Reactive observables (`RxList`, `RxBool`, `RxString`)
- Controller lifecycle management (`onInit`)
- Dependency injection with `Get.put()`

### GraphQL Integration
- Query building with variables
- Error handling for GraphQL operations
- Caching strategies (`FetchPolicy`)

### Flutter Best Practices
- Separation of concerns (Models, Services, Controllers, Views)
- Proper error handling and loading states
- Responsive UI design
- Clean architecture patterns

## Customization

### Changing the GraphQL Endpoint

To use a different GraphQL API:

1. Update the endpoint in `lib/core/graphql_client.dart`:
```dart
static HttpLink httpLink = HttpLink('YOUR_GRAPHQL_ENDPOINT');
```

2. Modify the queries in `lib/services/countries_service.dart` to match your schema.

3. Update the models in `lib/models/` to match your data structure.

### Adding New Features

The modular architecture makes it easy to extend:

- Add new screens in the `views/` directory
- Create new controllers for different data domains
- Extend the service layer for additional API calls
- Add new models for different data types

## Performance Considerations

- GraphQL queries use `FetchPolicy.networkOnly` for fresh data
- GetX reactive streams minimize unnecessary rebuilds
- Efficient list filtering with observable patterns
- Proper error boundaries prevent app crashes

## Troubleshooting

### Common Issues

1. **Network Errors**: Check your internet connection and GraphQL endpoint availability
2. **Build Errors**: Run `fvm flutter clean && fvm flutter pub get`
3. **GetX Issues**: Ensure controllers are properly initialized with `Get.put()`

### Debug Mode

For debugging, you can:
- Check the console for GraphQL errors
- Use Flutter DevTools for state inspection
- Enable GraphQL logging for query debugging

## Contributing

Feel free to contribute by:
- Reporting bugs
- Suggesting new features
- Improving documentation
- Adding more demo examples

## License

This project is open source and available under the [MIT License](LICENSE).
