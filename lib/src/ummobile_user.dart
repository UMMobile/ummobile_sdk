import 'package:ummobile_sdk/src/models/user/employee.dart';
import 'package:ummobile_sdk/src/models/user/student.dart';
import 'package:ummobile_sdk/src/models/user/user.dart';
import 'package:ummobile_sdk/src/statics.dart';
import 'package:ummobile_sdk/src/types/role.dart';
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
  /// Require the [auth] token to authenticate the requests, and the API [version] where to make the calls, which is the latests by default (v1).
  UMMobileUser({
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

  /// Retrieve the user information.
  ///
  /// Some fields can be null depending on the role of the user. If the user is student then will have a `student` field and the `employee` field will be `null`. If the user is employee the `student` field will be null but then the `employee` field will have information.
  Future<User> getUser() async {
    return await _http.customGet<User>(
      mapper: (json) {
        User user = User(
          id: int.parse(json['id']),
          name: json['name'],
          surnames: json['surnames'],
          extras: UserExtras(
            email: json['extras']['email'],
            phone: json['extras']['phone'].toString(),
            curp: json['extras']['curp'],
            maritalStatus: json['extras']['maritalStatus'],
            birthday: DateTime.parse(json['extras']['birthday']),
          ),
          image: json['image'],
          role: getRoleFromInt(json['role']),
        );

        if (user.role == Roles.Student) {
          user.student = StudentExtras(
            baptized: json['student']['baptized'],
            religion: json['student']['religion'],
            type: json['student']['type'],
          );
        } else if (user.role == Roles.Employee) {
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
  Future<String> getProfilePicture() async {
    return await _http.customGet(
        path: '/picture', mapper: (json) => json['base64']);
  }
}
