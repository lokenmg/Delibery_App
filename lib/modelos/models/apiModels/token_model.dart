class TokenModel {
  final String username;
  final String message;
  final String token;

  TokenModel({
    required this.username,
    required this.message,
    required this.token,
  });

  factory TokenModel.fromJson(Map<String, dynamic> json) => TokenModel(
        username: json["Username"],
        message: json["message"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "Username": username,
        "message": message,
        "token": token,
      };
}
