/// The token schema model.
class Token {
  /// The access token.
  ///
  /// This is the field that authorize the requset to the API.
  String accessToken;

  /// The refresh token.
  ///
  /// Still is not useful.
  String refreshToken;

  /// The scope of the token. Usually "OpenId".
  String scope;

  /// The type of the token. Usually "Bearer".
  String tokenType;

  /// The milliseconds to expiration after being issued.
  int expiresIn;

  /// The Token constructor.
  Token({
    required this.accessToken,
    required this.refreshToken,
    required this.scope,
    required this.tokenType,
    required this.expiresIn,
  });
}
