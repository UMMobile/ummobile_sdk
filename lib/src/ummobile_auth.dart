import 'package:ummobile_api/src/models/auth/token.dart';
import 'package:ummobile_api/src/statics.dart';
import 'package:ummobile_custom_http/ummobile_custom_http.dart';

/// A client for the UMMobile API auth section requests.
class UMMobileAuth {
  /// The API client.
  UMMobileCustomHttp _http;

  /// The path of the requests group.
  static final String path = 'token';

  /// Main UMMobile auth client constructor.
  ///
  /// Can receive the API [version] where to make the calls, which is the latests by default (v1).
  UMMobileAuth({String version: latestVersion})
      : this._http = UMMobileCustomHttp(baseUrl: '$host/$version/$path');

  /// Retrieve a new token for the [username] if the [password] is correct.
  Future<Token> getToken({
    required int username,
    required String password,
  }) async {
    return await _http.customPost<Token>(
      body: {
        'username': username,
        'password': password,
      },
      mapper: (json) => Token(
        accessToken: json['access_token'],
        refreshToken: json['refresh_token'],
        scope: json['scope'],
        tokenType: json['token_type'],
        expiresIn: json['expires_in'],
      ),
    );
  }
}
