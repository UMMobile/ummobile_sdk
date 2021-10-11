library ummobile_sdk;

import 'package:ummobile_sdk/src/statics.dart';
import 'package:ummobile_sdk/src/ummobile_catalogue.dart';
import 'package:ummobile_sdk/src/ummobile_user.dart';
import 'package:ummobile_sdk/src/ummobile_auth.dart';
import 'package:ummobile_sdk/src/ummobile_academic.dart';
import 'package:ummobile_sdk/src/ummobile_financial.dart';

// Export individual clients.
export 'src/ummobile_auth.dart';
export 'src/ummobile_user.dart';
export 'src/ummobile_academic.dart';
export 'src/ummobile_financial.dart';
export 'src/ummobile_catalogue.dart';
// Export components
export 'src/models/models.dart';
export 'src/types/types.dart';
export 'src/statics.dart';

/// The entry point of the UMMobile SDK
class UMMobileSDK {
  /// The auth section of the API.
  ///
  /// Can receive an API [version] (default `latestVersion`).
  static UMMobileAuth auth({String version: latestVersion}) =>
      UMMobileAuth(version: version);

  /// The user section of the API.
  UMMobileUser user;

  /// The academic section of the API.
  UMMobileAcademic academic;

  /// The financial section of the API.
  UMMobileFinancial financial;

  /// The catalogue section of the API.
  UMMobileCatalogue catalogue;

  /// The entry point of the UMMobile SDK.
  ///
  /// Require the [token] token to authenticate the requests, and the API [version] where to make the calls, which is the latests by default (v1).
  ///
  /// **IMPORTANT:**
  /// The information will be of the user whose [token] is sent as authentication.
  /// You can get a new token from the `this.auth().getToken` function.
  UMMobileSDK({
    required String token,
    String version: latestVersion,
  })  : this.user = UMMobileUser(auth: token, version: latestVersion),
        this.academic = UMMobileAcademic(auth: token, version: latestVersion),
        this.financial = UMMobileFinancial(auth: token, version: latestVersion),
        this.catalogue = UMMobileCatalogue(auth: token, version: latestVersion);
}
