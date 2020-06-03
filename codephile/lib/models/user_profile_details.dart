import 'dart:convert';

UserProfileDetails userProfileDetailsFromJson(String str) =>
    UserProfileDetails.fromJson(json.decode(str));

String userProfileDetailsToJson(UserProfileDetails data) =>
    json.encode(data.toJson());

class UserProfileDetails {
  Profile codechefProfile;
  Profile codeforcesProfile;
  Profile hackerrankProfile;
  Profile spojProfile;

  UserProfileDetails({
    this.codechefProfile,
    this.codeforcesProfile,
    this.hackerrankProfile,
    this.spojProfile,
  });

  factory UserProfileDetails.fromJson(Map<String, dynamic> json) =>
      UserProfileDetails(
        codechefProfile: Profile.fromJson(json["codechefProfile"]),
        codeforcesProfile: Profile.fromJson(json["codeforcesProfile"]),
        hackerrankProfile: Profile.fromJson(json["hackerrankProfile"]),
        spojProfile: Profile.fromJson(json["spojProfile"]),
      );

  Map<String, dynamic> toJson() => {
        "codechefProfile": codechefProfile.toJson(),
        "codeforcesProfile": codeforcesProfile.toJson(),
        "hackerrankProfile": hackerrankProfile.toJson(),
        "spojProfile": spojProfile.toJson(),
      };
}

class Profile {
  String accuracy;
  String name;
  String rank;
  String school;
  String userName;

  Profile({
    this.accuracy,
    this.name,
    this.rank,
    this.school,
    this.userName,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        accuracy: json["accuracy"],
        name: json["name"],
        rank: json["rank"],
        school: json["school"],
        userName: json["userName"],
      );

  Map<String, dynamic> toJson() => {
        "accuracy": accuracy,
        "name": name,
        "rank": rank,
        "school": school,
        "userName": userName,
      };
}
