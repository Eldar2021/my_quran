// import 'package:mq_storage/src/interface/storage_exception.dart';

// /// A Dart StorageInterface Client Interface
// abstract class StorageInterface {
//   /// Returns the value associated with the provided [key].
//   ///
//   /// Returns `null` if no value is found for the given [key].
//   ///
//   /// Throws a [StorageException] if the read fails.
//   Future<String?> read({required String key});

//   /// Asynchronously writes the provided [key] and [value] pair.
//   ///
//   /// Throws a [StorageException] if the write fails.
//   Future<void> write({required String key, required String value});

//   /// Asynchronously removes the value associated with the provided [key].
//   ///
//   /// Throws a [StorageException] if the deletion fails.
//   Future<void> delete({required String key});

//   /// Asynchronously removes all 'key-value' pairs.
//   ///
//   /// Throws a [StorageException] if the deletion fails.
//   Future<void> clear();
// }
