import 'package:meta/meta.dart';

/// An abstract class representing a value that can be either Right or Left.
@immutable
sealed class Either<R, L> {
  const Either();

  /// Performs operations based on Right and Left values.
  B fold<B>(B Function(L l) ifLeft, B Function(R r) ifRight);
}

/// Represents the Right value of an Either.
@immutable
final class Right<R, L> extends Either<R, L> {
  const Right(this.value);

  /// Holds the Right value.
  final R value;

  /// Invokes the ifRight function using the Right value.
  @override
  B fold<B>(B Function(L l) ifLeft, B Function(R r) ifRight) => ifRight(value);

  /// Equality and hashCode overrides.
  @override
  bool operator ==(Object other) => other is Right && other.value == value;

  @override
  int get hashCode => value.hashCode;
}

/// Represents the Left value of an Either.
@immutable
final class Left<R, L> extends Either<R, L> {
  const Left(this.value);

  /// Holds the Left value.
  final L value;

  /// Invokes the ifLeft function using the Left value.
  @override
  B fold<B>(B Function(L l) ifLeft, B Function(R r) ifRight) => ifLeft(value);

  /// Equality and hashCode overrides.
  @override
  bool operator ==(Object other) => other is Left && other.value == value;

  @override
  int get hashCode => value.hashCode;
}
