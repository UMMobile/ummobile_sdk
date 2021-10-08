class Token {
  String accessToken;
  String refreshToken;
  String scope;
  String tokenType;
  int expiresIn;

  Token({
    required this.accessToken,
    required this.refreshToken,
    required this.scope,
    required this.tokenType,
    required this.expiresIn,
  });
}
