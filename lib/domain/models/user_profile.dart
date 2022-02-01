import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile.freezed.dart';
part 'user_profile.g.dart';

@freezed
class UserProfile with _$UserProfile {
  factory UserProfile({
    Profile? codechefProfile,
    Profile? codeforcesProfile,
    Profile? hackerrankProfile,
    Profile? spojProfile,
  }) = _UserProfile;

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);
}

@freezed
class Profile with _$Profile {
  factory Profile({
    String? accuracy,
    String? name,
    String? rank,
    String? school,
    String? userName,
  }) = _Profile;

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);
}
