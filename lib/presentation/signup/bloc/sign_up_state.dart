part of 'sign_up_bloc.dart';

/// State class for [SignUpBloc].
@freezed
class SignUpState with _$SignUpState {
  /// State class for [SignUpBloc].
  const factory SignUpState({
    /// Whether the email entered is unique.
    @Default(true) bool isEmailUnique,

    /// Whether the institute field is in focus.
    @Default(false) bool isInstituteFocused,

    /// Whether the name field is in focus.
    @Default(false) bool isNameFocused,

    /// Whether the password field is in focus.
    @Default(false) bool isPasswordFocused,

    /// Whether the username field is in focus.
    @Default(false) bool isUsernameFocused,

    /// Whether the username entered is unique.
    @Default(true) bool isUsernameUnique,

    /// Whether the password field should be obscured.
    @Default(true) bool obscurePassword,

    /// Number of institute names suggested by the dropdown field.
    /// Never used directly, just here to force rebuilds when institutes list is fetched.
    @Default(5) int numberOfInstitutes,

    /// Index of the current screen.
    @Default(0) int pageIndex,

    /// Controller for the email field.
    @Default(null) TextEditingController? emailController,

    /// The profile image selected.
    @Default(null) File? image,

    /// Controller for the institute field.
    @Default(null) TextEditingController? instituteController,

    /// Controller for the name field.
    @Default(null) TextEditingController? nameController,

    /// Controller for the password field.
    @Default(null) TextEditingController? passwordController,

    /// Controller for the username field.
    @Default(null) TextEditingController? usernameController,

    /// Controller for the handle fields.
    @Default({}) Map<String, TextEditingController?> handleControllers,

    /// State of the screen.
    @Default(Status()) Status status,
  }) = _SignUpState;

  const SignUpState._();

  /// Type of primary button to show below the forms.
  PrimaryButtonStatus primaryButtonStatus() {
    bool isPageOneFilled() {
      if (nameController == null || emailController == null) {
        return false;
      } else {
        return nameController!.text.isNotEmpty &&
            emailController!.text.isNotEmpty &&
            RegExp(AppStrings.emailValidationRegex)
                .hasMatch(emailController!.text);
      }
    }

    bool isPageTwoFilled() {
      return handleControllers.values.fold<bool>(
        false,
        (previousValue, element) =>
            previousValue || (element?.text.isNotEmpty ?? false),
      );
    }

    bool isPageFourFilled() {
      if (usernameController == null || passwordController == null) {
        return false;
      } else {
        return usernameController!.text.isNotEmpty &&
            passwordController!.text.length >= 8;
      }
    }

    switch (pageIndex) {
      case 0:
        if (isPageOneFilled()) {
          return PrimaryButtonStatus.next;
        } else {
          return PrimaryButtonStatus.disabled;
        }
      case 1:
        if (isPageTwoFilled()) {
          return PrimaryButtonStatus.next;
        } else {
          return PrimaryButtonStatus.skip;
        }
      case 2:
        if (image != null) {
          return PrimaryButtonStatus.next;
        } else {
          return PrimaryButtonStatus.skip;
        }
      case 3:
        if (isPageFourFilled()) {
          return PrimaryButtonStatus.next;
        } else {
          return PrimaryButtonStatus.disabled;
        }
    }
    return PrimaryButtonStatus.next;
  }
}

/// Enum of the types of primary button that can be displayed.
enum PrimaryButtonStatus { next, skip, disabled }
