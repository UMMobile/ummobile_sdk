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

    test('Get all semesters', () async {
      AllSemesters allSemesters = await student.academic.getAllSemesters();

      expect(allSemesters.planId, isNotEmpty);
      expect(allSemesters.average, isPositive);
      expect(allSemesters.semesters, isNotEmpty);
      expect(allSemesters.semesters.first.order, 1);
      expect(allSemesters.semesters.first.subjects.first.extras.semester, 1);
    });

    test('Get current semester', () async {
      Semester semester = await student.academic.getCurrentSemester();

      expect(semester.planId, 'ISC2010*');
      expect(semester.subjects, isNotEmpty);
    });

    test('Get current plan', () async {
      String planId = await student.academic.getPlan();

      expect(planId, 'ISC2010*');
    });

    test('Get global average', () async {
      double average = await student.academic.getGlobalAverage();

      expect(average, greaterThan(0));
    });
  });

  group('[Financial]', () {
    test('Get balances: without movements', () async {
      List<Balance> balances = await student.financial.getBalances();

      expect(balances, isNotEmpty);
      expect(balances.length, 1);
      expect(balances.first.id, 'SFORMA01');
      expect(balances.first.type, 'CR');
      expect(balances.first.movements, isNull);
    });

    test('Get balances: with current movements', () async {
      List<Balance> balances = await student.financial
          .getBalances(includeMovements: IncludeMovements.OnlyCurrent);

      expect(balances.first.movements, isNotNull);
      expect(balances.first.movements!.current, isNotEmpty);
      expect(balances.first.movements!.current.first.date, isNull);
      expect(balances.first.movements!.current.first.isDebit, isTrue);
      expect(balances.first.movements!.lastYear, isNull);
    });

    test('Get balances: with current & last year movements', () async {
      List<Balance> balances = await student.financial
          .getBalances(includeMovements: IncludeMovements.CurrentAndLastYear);

      expect(balances.first.movements, isNotNull);
      expect(balances.first.movements!.current, isNotEmpty);
      expect(balances.first.movements!.lastYear, isNotEmpty);
      expect(balances.first.movements!.lastYear!.first.date, isNull);
      expect(balances.first.movements!.lastYear!.first.isDebit, isTrue);
    });

    test('Get movements: only currents', () async {
      Movements movements = await student.financial.getMovements('SFORMA01');

      expect(movements.current, isNotEmpty);
      expect(movements.current.first.date, isNull);
      expect(movements.current.first.isDebit, isTrue);
      expect(movements.lastYear, isNull);
    });

    test('Get movements: currents & last year', () async {
      Movements movements = await student.financial
          .getMovements('SFORMA01', includeLastYear: true);

      expect(movements.current, isNotEmpty);
      expect(movements.lastYear, isNotEmpty);
      expect(movements.lastYear!.first.date, isNull);
      expect(movements.lastYear!.first.isDebit, isTrue);
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
