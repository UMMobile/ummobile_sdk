library ummobile_sdk;

import 'package:ummobile_sdk/src/statics.dart';
import 'package:ummobile_sdk/src/ummobile_user.dart';
import 'package:ummobile_sdk/src/ummobile_auth.dart';

// Export components
export 'src/ummobile_auth.dart';
export 'src/ummobile_user.dart';
export 'src/models/models.dart';
export 'src/types/types.dart';
export 'src/statics.dart';

/// The entry point of the UMMobile SDK
class UMMobileAPI {
  /// The auth section of the API.
  static UMMobileAuth auth({String version: latestVersion}) =>
      UMMobileAuth(version: version);

  /// The user section of the API.
  UMMobileUser user;

  /// The entry point of the UMMobile API client.
  ///
  /// Require the [token] token to authenticate the requests, and the API [version] where to make the calls, which is the latests by default (v1).
  ///
  /// **IMPORTANT:**
  /// The information will be of the user whose [token] is sent as authentication.
  /// You can get a new token from the `this.auth().getToken` function.
  UMMobileAPI({
    required String token,
    String version: latestVersion,
  }) : this.user = UMMobileUser(auth: token, version: latestVersion);
}
