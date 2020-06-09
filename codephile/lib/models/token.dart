import 'dart:convert';

Token tokenFromJson(String str, int statusCode) =>
    Token.fromJson(json.decode(str));

String tokenToJson(Token data) => json.encode(data.toJson());

class Token {
  String token;

  Token({
    this.token,
  });

  factory Token.fromJson(Map<String, dynamic> json) => Token(
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
      };
}
