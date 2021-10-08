import 'dart:io' show Platform;

import 'package:dotenv/dotenv.dart' show load, env, clean;
import 'package:flutter_test/flutter_test.dart';
import 'package:ummobile_sdk/ummobile_sdk.dart';

void main() {
  late UMMobileSDK employee;
  late UMMobileSDK student;
  String userStudent = Platform.environment['USER_STUDENT'] ?? '';
  String passStudent = Platform.environment['PASSWORD_STUDENT'] ?? '';
  String userEmployee = Platform.environment['USER_EMPLOYEE'] ?? '';
  String passEmployee = Platform.environment['PASSWORD_EMPLOYEE'] ?? '';
  String execEnv = env['EXEC_ENV'] ?? Platform.environment['EXEC_ENV'] ?? '';
  if (execEnv != 'github_actions') {
    setUpAll(() async {
      load();
      userStudent = env['USER_STUDENT'] ?? userStudent;
      passStudent = env['PASSWORD_STUDENT'] ?? passStudent;
      userEmployee = env['USER_EMPLOYEE'] ?? userEmployee;
      passEmployee = env['PASSWORD_EMPLOYEE'] ?? passEmployee;

      UMMobileAuth auth = UMMobileSDK.auth();
      Token studentToken = await auth.getToken(
        username: int.parse(userStudent),
        password: passStudent,
      );
      Token employeeToken = await auth.getToken(
        username: int.parse(userEmployee),
        password: passEmployee,
      );

      student = UMMobileSDK(token: studentToken.accessToken);
      employee = UMMobileSDK(token: employeeToken.accessToken);
    });

    tearDownAll(() {
      clean();
    });
  }

  group('[Auth]', () {
    test('Get token', () async {
      final Token token = await UMMobileSDK.auth()
          .getToken(username: int.parse(userStudent), password: passStudent);
      expect(token, isNotNull);
      expect(token.accessToken, isNotNull);
    });
  });

  group('[Academic]', () {
    test('Get archives', () async {
      List<Archive> archives = await student.academic.getArchives();

      expect(archives, isNotEmpty);
    });
  });

  group('[Catalogue]', () {
    test('Get rules: Student', () async {
      List<Rule> rules = await student.catalogue.getRules();

      expect(rules, isNotEmpty);
      expect(rules.every((rule) => rule.roles.contains(Roles.Student)), true);
    });

    test('Get countries', () async {
      List<Country> countries = await student.catalogue.getCountries();

      expect(countries, isNotEmpty);
    });
  });

  group('[User]', () {
    test('Get picture', () async {
      String base64 = await student.user.getProfilePicture();
      RegExp regex = RegExp(
          r"^([A-Za-z0-9+/]{4})*([A-Za-z0-9+/]{3}=|[A-Za-z0-9+/]{2}==)?$");

      expect(regex.hasMatch(base64), isTrue);
    });

    test('Get user: Student', () async {
      User user = await student.user.getInformation();

      expect(user.id, 1130745);
      expect(user.role, Roles.Student);
      expect(user.employee, isNull);
      expect(user.image, isNull);
    });

    test('Get user: Student with picture', () async {
      User user = await student.user.getInformation(includePicture: true);
      String base64 = await student.user.getProfilePicture();
      RegExp regex = RegExp(
          r"^([A-Za-z0-9+/]{4})*([A-Za-z0-9+/]{3}=|[A-Za-z0-9+/]{2}==)?$");

      expect(user.image, isNotNull);
      expect(regex.hasMatch(user.image!), isTrue);
      expect(user.image, equals(base64));
    });

    test('Get user: Employee', () async {
      User user = await employee.user.getInformation();

      expect(user.id, 9830438);
      expect(user.role, Roles.Employee);
      expect(user.employee!.contract, ContractTypes.Contract);
      expect(user.student, isNull);
    });
  });
}
