import 'package:ummobile_sdk/src/models/academic/archive.dart';
import 'package:ummobile_sdk/src/models/academic/semester.dart';
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
        );
  }

  /// Retrieve all the user semesters
  Future<AllSemesters> getAllSemesters() {
    return this._http.customGet<AllSemesters>(
          path: '/semesters',
          mapper: (json) => AllSemesters(
            planId: json['planId'],
            average: double.parse(json['average']),
            semesters: List.from(json['semesters'])
                .map((semester) => Semester(
                      name: semester['name'],
                      order: int.parse(semester['order']),
                      average: semester['average'] is int
                          ? semester['average'].toDouble()
                          : double.parse(semester['average']),
                      planId: semester['planId'],
                      subjects: List.from(semester['subjects'])
                          .map((subject) => Subject(
                                name: subject['name'],
                                score: double.parse(subject['score']),
                                isExtra: subject['isExtra'],
                                credits: int.parse(subject['credits']),
                                teacher: SubjectTeacher(
                                  name: subject['teacher']['name'],
                                ),
                                extras: SubjectExtras(
                                  loadId: subject['extras']['loadId'],
                                  type: subject['extras']['type'],
                                  semester:
                                      int.parse(subject['extras']['semester']),
                                ),
                              ))
                          .toList(),
                    ))
                .toList(),
          ),
        );
  }
}
