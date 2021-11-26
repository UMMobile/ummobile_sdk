import 'package:ummobile_sdk/src/models/auth/token.dart';
import 'package:ummobile_sdk/src/statics.dart';
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
  ///
  /// If [sandbox] is set to `true` then returns credentials for sandbox services (if availables).
  Future<Token> getToken({
    required int username,
    required String password,
    bool sandbox: false,
  }) {
    return this._http.customPost<Token>(
      queries: {
        'sandbox': sandbox,
      },
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
