import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  Profile codechefProfile;
  Profile codeforcesProfile;
  Profile hackerrankProfile;
  Profile spojProfile;

  User({
    this.codechefProfile,
    this.codeforcesProfile,
    this.hackerrankProfile,
    this.spojProfile,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
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
  String name;
  String rank;
  String school;
  String userName;

  ProfileClass({
    this.name,
    this.rank,
    this.school,
    this.userName,
  });

  factory ProfileClass.fromJson(Map<String, dynamic> json) => ProfileClass(
    name: json["name"],
    rank: json["rank"],
    school: json["school"],
    userName: json["userName"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "rank": rank,
    "school": school,
    "userName": userName,
  };
}
