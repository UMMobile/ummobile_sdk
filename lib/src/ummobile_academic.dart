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
                    id: e['id'],
                    name: e['name'],
                    images: List.from(e['images'])
                        .map((e) => ArchiveImg(
                              page: e['page'],
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
            average: json['average'],
            semesters: List.from(json['semesters'])
                .map((semester) => _mapSemester(semester))
                .toList(),
          ),
        );
  }

  Future<Semester> getCurrentSemester() {
    return this._http.customGet(
          path: '/semesters/current',
          mapper: (json) => _mapSemester(json),
        );
  }

  Semester _mapSemester(dynamic json) => Semester(
        name: json['name'],
        order: json['order'],
        average: json['average'] is int
            ? json['average'].toDouble()
            : json['average'],
        planId: json['planId'],
        subjects: List.from(json['subjects'])
            .map((subject) => Subject(
                  name: subject['name'],
                  score: subject['score'] is int
                      ? subject['score'].toDouble()
                      : subject['score'],
                  isExtra: subject['isExtra'],
                  credits: subject['credits'],
                  teacher: SubjectTeacher(
                    name: subject['teacher']['name'],
                  ),
                  extras: SubjectExtras(
                    loadId: subject['extras']['loadId'],
                    type: subject['extras']['type'],
                    semester: subject['extras']['semester'],
                  ),
                ))
            .toList(),
      );
}
