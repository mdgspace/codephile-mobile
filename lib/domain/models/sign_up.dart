import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'handle.dart';

part 'sign_up.freezed.dart';
part 'sign_up.g.dart';

@freezed
class SignUp with _$SignUp {
  factory SignUp({
    required String email,
    required String username,
    required String password,
    String? fullname,
    String? institute,
    Handle? handle,
  }) = _SignUp;

  factory SignUp.fromJson(Map<String, dynamic> json) => _$SignUpFromJson(json);
}
