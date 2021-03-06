import 'package:ummobile_sdk/src/models/academic/document.dart';
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
  /// **WARNING:**
  /// Some information may vary in certain periods such as vacations because if the student works at the university they will put a different plan while he works to give him the basic rights such as residence or student insurance. To see the current plan see [this.getPlan()] function.
  ///
  /// Require the [token] token to authenticate the requests, and the API [version] where to make the calls, which is the latests by default (v1).
  UMMobileAcademic({
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

  /// Retrieve the user documents.
  ///
  /// _**NOTE:** This function do not include the base64 images page to avoid increment the response time & size. To get the base64 image page use `getImagePage(int documentId, int page)`_.
  Future<List<Document>> getDocuments() {
    return this._http.customGet(
          path: '/documents',
          mapper: (json) => List.from(json)
              .map((e) => Document(
                    id: e['id'],
                    name: e['name'],
                    pages: List.from(e['pages'])
                        .map((e) => DocumentPage(
                              page: e['page'],
                              urlImage: e['urlImage'],
                              base64Image: e['base64'],
                            ))
                        .toList(),
                    images: List.from(e['images'])
                        .map((e) => DocumentImg(
                              page: e['page'],
                              image: e['image'],
                            ))
                        .toList(),
                  ))
              .toList(),
        );
  }

  /// Retrieve a document page with base64 image.
  Future<DocumentPage> getImagePage(int documentId, int page) {
    return this._http.customGet(
          path: '/documents/$documentId/pages/$page',
          mapper: (json) => DocumentPage(
            page: json['page'],
            urlImage: json['urlImage'],
            base64Image: json['base64'],
          ),
        );
  }

  /// Retrieve all the user semesters.
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

  /// Retrieve the current semester.
  Future<Semester> getCurrentSemester() {
    return this._http.customGet(
          path: '/semesters/current',
          mapper: (json) => _mapSemester(json),
        );
  }

  /// Retrieve the current plan.
  Future<String> getPlan() {
    return this._http.customGet(
          path: '/plan',
          mapper: (json) => json['plan'],
        );
  }

  /// Retrieve the global average.
  Future<double> getGlobalAverage() {
    return this._http.customGet(
          path: '/semesters/average',
          mapper: (json) => json['average'],
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
