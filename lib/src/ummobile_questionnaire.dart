import 'package:ummobile_sdk/src/statics.dart';
import 'package:ummobile_custom_http/ummobile_custom_http.dart';
import 'package:ummobile_sdk/ummobile_sdk.dart';

/// A client for the UMMobile API questionnaire section requests.
class UMMobileQuestionnaire {
  /// The API client.
  UMMobileCustomHttp _http;

  /// The path of the requests group.
  static final String path = 'questionnaire';

  /// The COVID questionnaire section of the API.
  UMMobileCovid covid;

  /// Main UMMobile questionnaire client constructor.
  ///
  /// Require the [auth] token to authenticate the requests, and the API [version] where to make the calls, which is the latests by default (v1).
  UMMobileQuestionnaire({
    required String auth,
    String version: latestVersion,
  })  : this._http = UMMobileCustomHttp(
          baseUrl: '$host/$version/$path',
          auth: Auth(
            token: () => auth,
            tokenType: 'Bearer',
            headerName: 'Authorization',
          ),
        ),
        this.covid = UMMobileCovid(auth: auth, version: version);
}
