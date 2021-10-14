import 'package:ummobile_sdk/src/statics.dart';
import 'package:ummobile_sdk/ummobile_sdk.dart';

/// A client for the UMMobile API questionnaire section requests.
class UMMobileQuestionnaire {
  /// The COVID questionnaire section of the API.
  UMMobileCovid covid;

  /// Main UMMobile questionnaire client constructor.
  ///
  /// Require the [token] token to authenticate the requests, and the API [version] where to make the calls, which is the latests by default (v1).
  UMMobileQuestionnaire({
    required String token,
    String version: latestVersion,
  }) : this.covid = UMMobileCovid(token: token, version: version);
}
