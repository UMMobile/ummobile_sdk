import 'package:ummobile_sdk/src/models/academic/archive.dart';
import 'package:ummobile_sdk/src/statics.dart';
import 'package:ummobile_custom_http/ummobile_custom_http.dart';
import 'package:ummobile_sdk/ummobile_sdk.dart';

/// A client for the UMMobile API academic section requests.
class UMMobileAcademic {
  /// The API client.
  UMMobileCustomHttp _http;

  /// The path of the requests group.
  static final String path = 'academic';

  /// Main UMMobile academic client constructor.
  ///
  /// Require the [auth] token to authenticate the requests, and the API [version] where to make the calls, which is the latests by default (v1).
  UMMobileAcademic({
    required String auth,
    String version: latestVersion,
  }) : this._http = UMMobileCustomHttp(
          baseUrl: '$host/$version/$path',
          auth: Auth(
            token: () => auth,
            tokenType: 'Bearer',
            headerName: 'Authorization',
          ),
        );

  /// Retrieve the user archives
  Future<List<Archive>> getArchives() {
    return this._http.customGet(
          path: '/archives',
          mapper: (json) => List.from(json)
              .map((e) => Archive(
                    id: int.parse(e['id']),
                    name: e['name'],
                    images: List.from(e['images'])
                        .map((e) => ArchiveImg(
                              page: int.parse(e['page']),
                              image: e['image'],
                            ))
                        .toList(),
                  ))
              .toList(),
          utf8Decode: false,
        );
  }
}
