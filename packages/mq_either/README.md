# MyQuran Dart Either

## Either Class Implementation

This Dart code provides an implementation of the `Either` type, a common functional programming pattern. The `Either` type represents a value that can be one of two types: `Right` or `Left`. This is useful for handling operations that can return two types of results, such as a successful value or an error.

### Either<R, L>

An abstract class for values that can be either `Right` or `Left`.

- `fold<B>(B Function(L l) ifLeft, B Function(R r) ifRight)`: Executes one of the given functions based on the type of value.

### Right<R, L>

Represents a `Right` value.

- `Right(this.value)`: Holds the `Right` value.
- `fold<B>(B Function(L l) ifLeft, B Function(R r) ifRight)`: Executes the `ifRight` function with the `Right` value.

### Left<R, L>

Represents a `Left` value.

- `Left(this.value)`: Holds the Left value.
- `fold<B>(B Function(L l) ifLeft, B Function(R r) ifRight)`: Executes the `ifLeft` function with the `Left` value.

### Usage

Example usage of `Either`, `Right`, and `Left` classes:

```dart
void main() {
  final rightValue = Right<int, String>(42);
  final leftValue = Left<int, String>('Error');

  final rightResult = rightValue.fold(
    (error) => 'Left: $error',
    (value) => 'Right: $value',
  );
  print(rightResult); // Output: "Right: 42"

  final leftResult = leftValue.fold(
    (error) => 'Left: $error',
    (value) => 'Right: $value',
  );
  print(leftResult); // Output: "Left: Error"
}
```
