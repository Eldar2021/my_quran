# hatim

A Quran Hatim Aplication.

### Getting Started

## Requirements
- Dart sdk: ">=2.18.5 <3.0.0"
- Flutter: "3.3.10"
- Android: minSdkVersion 17
- iOS: --ios-language swift, Xcode version >= 14.0.0

## Run App
* If you have an AVD or real device attached, you can do
```
flutter run
```

## Run tests
* run all tests from the command line:
```
flutter test
```

## Integration tests
* run integration tests in `test_driver` directory:
```
flutter drive --target=test_driver/app.dart
```

## Fmt
`dartfmt` lacks config file support, which implies that customizations need to be done by users individually. The default 
limit of 80 characters line length conflicts with the deeply nested structure of flutter's declarative code for designing 
widgets. This causes many unwanted linebreaks that reduce the readability of flutter code. Hence, we increase the line
length of the code to 120.

* Settings > Dart > Line length 120.
* Autoformat on save: Settings > Languages and Frameworks > then tick: `Format code on save`, `Organize imports on save`.
* Format the whole codebase with:
```
flutter format . --line-length 120
```
## Generate
* Re generate .g files run:
```
flutter pub run build_runner build --delete-conflicting-outputs
```