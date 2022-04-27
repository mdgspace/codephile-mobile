import '../data/constants/strings.dart';

/// Base class for specific errors as defined below.
class Failure implements Exception {
  const Failure(this.message);

  final String message;
}

/// Thrown when a user with a similar email already exists.
class DuplicateEmail extends Failure {
  const DuplicateEmail() : super(AppStrings.duplicateEmail);
}

/// Thrown when a user with a similar username already exists.
class DuplicateUsername extends Failure {
  const DuplicateUsername() : super(AppStrings.duplicateUsername);
}

/// Thrown when there's no user associated with given email.
class EmailNotFound extends Failure {
  const EmailNotFound() : super(AppStrings.noUserWithEmail);
}

/// Thrown when an action requires login and user isn't logged in.
class IncorrectCredentials extends Failure {
  const IncorrectCredentials() : super(AppStrings.incorrectCredentials);
}

/// Thrown when the format of the API call is incorrect.
class IncorrectFormat extends Failure {
  const IncorrectFormat() : super(AppStrings.wrongFormValues);
}

/// Thrown in case of server error or an unknown error.
class InternalFailure extends Failure {
  const InternalFailure() : super(AppStrings.genericError);
}

/// Thrown when a user with a similar email and/or username already exists.
class SimilarUserExists extends Failure {
  const SimilarUserExists() : super(AppStrings.similarUserExists);
}

/// Thrown when user is attempting to login without verifying email.
class UnverifiedEmail extends Failure {
  const UnverifiedEmail() : super(AppStrings.verifyFirst);
}
