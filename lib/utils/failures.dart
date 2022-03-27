import '../data/constants/strings.dart';

/// Base class for specific errors as defined below.
class Failure implements Exception {
  const Failure(this.message);

  final String message;
}

// TODO(BURG3R5): Use `Failure`s in login screen too.

/// Thrown when a user with a similar email and/or username already exists.
class AlreadyExistsFailure extends Failure {
  const AlreadyExistsFailure() : super(AppStrings.alreadyExists);
}

/// Thrown when the format of the API call is incorrect.
class FormatFailure extends Failure {
  const FormatFailure() : super(AppStrings.wrongFormValues);
}

/// Thrown in case of server error or an unknown error.
class InternalFailure extends Failure {
  const InternalFailure() : super(AppStrings.genericError);
}

/// Thrown when a user with a similar email already exists.
class EmailIsNotUniqueFailure extends Failure {
  const EmailIsNotUniqueFailure() : super(AppStrings.emailIsNotUnique);
}

/// Thrown when a user with a similar username already exists.
class UsernameIsNotUniqueFailure extends Failure {
  const UsernameIsNotUniqueFailure() : super(AppStrings.usernameIsNotUnique);
}
