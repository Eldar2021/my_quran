# MqRemoteClient

`MqRemoteClient` is a Dart package that simplifies HTTP requests using the Dio library, providing a convenient and consistent way to handle network operations with error handling and custom token management.

## Features

- HTTP GET, POST, PUT, PATCH methods
- Custom headers including token and language
- Error handling using custom exceptions
- Easily mockable for testing

## Installation

Add `mq_remote_client` to your `pubspec.yaml`:

## Usage

### Initialization

Create an instance of `MqRemoteClient` and initialize it:

```dart
import 'package:dio/dio.dart';
import 'package:mq_remote_client/mq_remote_client.dart';

final dio = Dio();
final networkClient = NetworkClient();

final mqRemoteClient = MqRemoteClient(
  dio: dio,
  network: networkClient,
  language: () => 'en',
  token: () => 'your_token',
  oldToken: () => 'your_old_token',
);

mqRemoteClient.initilize();
```

## Making Requests

### GET Request

```dart
final result = await mqRemoteClient.get<Map<String, dynamic>>(
  'https://example.com/api/resource',
);

result.fold(
  (left) => print('Error: $left'),
  (right) => print('Data: $right'),
);
```

### POST Request

```dart
final result = await mqRemoteClient.post<Map<String, dynamic>>(
  'https://example.com/api/resource',
  body: {'key': 'value'},
);

result.fold(
  (left) => print('Error: $left'),
  (right) => print('Data: $right'),
);
```
### PUT Request

```dart
final result = await mqRemoteClient.put<Map<String, dynamic>>(
  'https://example.com/api/resource',
  body: {'key': 'value'},
);

result.fold(
  (left) => print('Error: $left'),
  (right) => print('Data: $right'),
);
```

### PATCH Request

```dart
final result = await mqRemoteClient.patch<Map<String, dynamic>>(
  'https://example.com/api/resource',
  body: {'key': 'value'},
);

result.fold(
  (left) => print('Error: $left'),
  (right) => print('Data: $right'),
);
```