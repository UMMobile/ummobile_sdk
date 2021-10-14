import 'package:ummobile_sdk/src/models/catalogue/country.dart';
import 'package:ummobile_sdk/src/models/catalogue/rule.dart';
import 'package:ummobile_sdk/src/statics.dart';
import 'package:ummobile_sdk/src/utils/utils.dart';
import 'package:ummobile_custom_http/ummobile_custom_http.dart';
import 'package:ummobile_sdk/ummobile_sdk.dart';

/// A client for the UMMobile API catalogue section requests.
class UMMobileCatalogue {
  /// The API client.
  UMMobileCustomHttp _http;

  /// The path of the requests group.
  static final String path = 'catalogue';

  /// Main UMMobile catalogue client constructor.
  ///
  /// Require the [token] token to authenticate the requests, and the API [version] where to make the calls, which is the latests by default (v1).
  UMMobileCatalogue({
    required String token,
    String version: latestVersion,
  }) : this._http = UMMobileCustomHttp(
          baseUrl: '$host/$version/$path',
          auth: Auth(
            token: () => token,
            tokenType: 'Bearer',
            headerName: 'Authorization',
          ),
        );

  /// Retrieve the academic rules for the user
  Future<List<Rule>> getRules() {
    return _http.customGet<List<Rule>>(
      path: '/rules',
      mapper: (json) => List.from(json)
          .map((e) => Rule(
                roles: List.from(e['roles'])
                    .map((e) => getRoleFromInt(e))
                    .toList(),
                keyName: e['keyName'],
                pdfUrl: Uri.parse(e['pdfUrl']),
              ))
          .toList(),
    );
  }

  /// Retrieve the countries
  Future<List<Country>> getCountries() {
    return _http.customGet<List<Country>>(
      path: '/countries',
      mapper: (json) => List.from(json)
          .map((e) => Country(
                id: e['id'],
                name: e['name'],
              ))
          .toList(),
    );
  }
}
