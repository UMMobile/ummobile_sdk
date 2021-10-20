import 'package:ummobile_sdk/src/models/user/employee.dart';
import 'package:ummobile_sdk/src/models/user/student.dart';
import 'package:ummobile_sdk/src/models/user/user.dart';
import 'package:ummobile_sdk/src/statics.dart';
import 'package:ummobile_sdk/src/utils/utils.dart';
import 'package:ummobile_custom_http/ummobile_custom_http.dart';

/// A client for the UMMobile API user section requests.
class UMMobileUser {
  /// The API client.
  UMMobileCustomHttp _http;

  /// The path of the requests group.
  static final String path = 'user';

  /// Main UMMobile user client constructor.
  ///
  /// Require the [token] token to authenticate the requests, and the API [version] where to make the calls, which is the latests by default (v1).
  UMMobileUser({
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

  /// Retrieve the user information.
  ///
  /// Some fields can be null depending on the role of the user. If the user is student then will have a `student` field and the `employee` field will be `null`. If the user is employee the `student` field will be null but then the `employee` field will have information.
  ///
  /// Can receive if should [includePicture] of the user. This can increase the response size so by default is `false`.
  Future<User> getInformation({bool includePicture: false}) {
    return this._http.customGet<User>(
      queries: {
        'includePicture': includePicture,
      },
      mapper: (json) {
        User user = User(
          id: json['id'],
          name: json['name'],
          surnames: json['surnames'],
          extras: UserExtras(
            email: json['extras']['email'],
            phone: json['extras']['phone'] != null
                ? json['extras']['phone'].toString()
                : null,
            curp: json['extras']['curp'],
            maritalStatus: json['extras']['maritalStatus'],
            birthday: DateTime.parse(json['extras']['birthday']),
          ),
          image: json['image'],
          role: getRoleFromInt(json['role']),
        );

        if (user.isStudent) {
          user.student = StudentExtras(
            baptized: json['student']['baptized'],
            religion: json['student']['religion'],
            type: json['student']['type'],
            academic: json['student']['academic'] != null
                ? Academic(
                    modality: json['student']['academic']['modality'],
                    signedUp: json['student']['academic']['signedUp'],
                    residence: getResidenceFromInt(
                        json['student']['academic']['residence']),
                    dormitory: json['student']['academic']['dormitory'],
                  )
                : null,
            scholarship: json['student']['scholarship'] != null
                ? Scholarship(
                    workplace: json['student']['scholarship']['workplace'],
                    position: json['student']['scholarship']['position'],
                    startDate:
                        DateTime(json['student']['scholarship']['startDate']),
                    endDate:
                        DateTime(json['student']['scholarship']['endDate']),
                    hours: json['student']['scholarship']['hours'],
                    status: json['student']['scholarship']['status'],
                  )
                : null,
          );
        } else if (user.isEmployee) {
          user.employee = EmployeeExtras(
            imss: json['employee']['imss'],
            rfc: json['employee']['rfc'],
            contract: getContractFromInt(json['employee']['contract']),
            positions: List.from(json['employee']['positions'])
                .map((e) => Position(
                      id: e['id'],
                      department: e['department'],
                      name: e['name'],
                    ))
                .toList(),
          );
        }

        return user;
      },
    );
  }

  /// Retrieve the user profile picture
  Future<String> getProfilePicture() {
    return this._http.customGet(
          path: '/picture',
          mapper: (json) => json['base64'],
        );
  }
}
