import '../data/constants/strings.dart';
import '../data/services/local/storage_service.dart';
import '../domain/repositories/user_repository.dart';

/// Returns the auth token stored in persistent storage, or, failing that,
/// the temporary auth token.
///
/// The user can choose whether to remained signed in for multiple sessions
/// or for the current session only. We use this getter to handle both cases
/// with minimum repetition of code.
String? get authToken => StorageService.authToken ?? UserRepository.authToken;

/// Stores the auth token stored in persistent storage, if [shouldPersist] is
/// true. Otherwise sets the temporary auth token.
///
/// The user can choose whether to remained signed in for multiple sessions
/// or for the current session only. We use this setter to handle both cases
/// with minimum repetition of code.
void setAuthToken(String? token, {required bool shouldPersist}) {
  if (shouldPersist) {
    StorageService.authToken = token;
  } else {
    UserRepository.authToken = token;
  }
}

/// Clears both the auth token stored in persistent storage and the temporary auth token.
///
/// The user can choose whether to remained signed in for multiple sessions
/// or for the current session only. We use this method to handle both cases
/// with minimum repetition of code.
void clearAuthToken() {
  UserRepository.authToken = null;
  StorageService.delete(AppStrings.authTokenKey);
}
