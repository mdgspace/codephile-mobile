import 'dart:convert';

UserDetails userDetailsFromJson(String str) => UserDetails.fromJson(json.decode(str));

String userDetailsToJson(UserDetails data) => json.encode(data.toJson());

class UserDetails {
  Profile codechefProfile;
  Profile codeforcesProfile;
  Profile hackerrankProfile;
  Profile spojProfile;

  UserDetails({
    this.codechefProfile,
    this.codeforcesProfile,
    this.hackerrankProfile,
    this.spojProfile,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
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
  ProfileClass profile;
  String website;

  Profile({
    this.profile,
    this.website,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
    profile: ProfileClass.fromJson(json["profile"]),
    website: json["website"],
  );

  Map<String, dynamic> toJson() => {
    "profile": profile.toJson(),
    "website": website,
  };
}

class ProfileClass {
  String accuracy;
  String name;
  String rank;
  String school;
  String userName;

  ProfileClass({
    this.accuracy,
    this.name,
    this.rank,
    this.school,
    this.userName,
  });

  factory ProfileClass.fromJson(Map<String, dynamic> json) => ProfileClass(
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
