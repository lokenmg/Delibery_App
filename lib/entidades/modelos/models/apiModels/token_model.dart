class TokenModel {
  final String username;
  final String id;
  final String message;
  final String token;

  TokenModel({
    required this.username,
    required this.id,
    required this.message,
    required this.token,
  });

  factory TokenModel.fromJson(Map<String, dynamic> json) => TokenModel(
        username: json["Username"],
        id: json["id"],
        message: json["message"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "Username": username,
        "id": id,
        "message": message,
        "token": token,
      };
}
