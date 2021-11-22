import 'dart:io' show Platform;

import 'package:dotenv/dotenv.dart' show load, env, clean;
import 'package:flutter_test/flutter_test.dart';
import 'package:ummobile_sdk/ummobile_sdk.dart';

void main() {
  late UMMobileSDK employee;
  late UMMobileSDK student;
  int userStudent = 1130745;
  int userEmployee = 9830438;
  String passStudent = Platform.environment['PASSWORD_STUDENT'] ?? '';
  String passEmployee = Platform.environment['PASSWORD_EMPLOYEE'] ?? '';
  String execEnv = env['EXEC_ENV'] ?? Platform.environment['EXEC_ENV'] ?? '';

  if (execEnv != 'github_actions') {
    setUpAll(() async {
      load();
      passStudent = env['PASSWORD_STUDENT'] ?? passStudent;
      passEmployee = env['PASSWORD_EMPLOYEE'] ?? passEmployee;
    });

    tearDownAll(() {
      clean();
    });
  }

  setUpAll(() async {
    UMMobileAuth auth = UMMobileSDK.auth();
    Token studentToken = await auth.getToken(
      username: userStudent,
      password: passStudent,
    );
    Token employeeToken = await auth.getToken(
      username: userEmployee,
      password: passEmployee,
    );

    student = UMMobileSDK(token: studentToken.accessToken);
    employee = UMMobileSDK(token: employeeToken.accessToken);
  });

  group('[Auth]', () {
    test('Get token', () async {
      final Token token = await UMMobileSDK.auth()
          .getToken(username: userStudent, password: passStudent);
      expect(token, isNotNull);
      expect(token.accessToken, isNotNull);
    });
  });

  group('[Academic]', () {
    test('Get documents', () async {
      List<Document> documents = await student.academic.getDocuments();

      expect(documents, isNotEmpty);
      expect(documents.first.pages, isNotEmpty);
    });

    test('Get document page', () async {
      DocumentPage page = await student.academic.getImagePage(1, 1);

      expect(page.base64Image, isNotEmpty);
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
      expect(movements.lastYear!.first.isCredit, isFalse);
    });

    test('Generate payment URL: without invoice', () async {
      Payment payment = Payment(
        reference: '1130745-SFORMA01-123098123098123',
        amount: 10,
        clientMail: '1130745@alumno.um.edu.mx',
        additionalData: [
          PaymentAdditionalData(
            id: 1,
            label: 'UMMobile',
            value: 'true',
          ),
        ],
      );

      String url = await student.financial.generatePaymentUrl(payment);

      expect(url.startsWith('https'), isTrue);
    });

    test('Generate payment URL: with invoice', () async {
      Payment payment = Payment(
        reference: '1130745-SFORMA01-123098123098123',
        amount: 10,
        clientMail: '1130745@alumno.um.edu.mx',
        additionalData: [
          PaymentAdditionalData(
            id: 1,
            label: 'UMMobile',
            value: 'true',
          ),
        ],
      );

      String url = await student.financial.generatePaymentUrl(
        payment,
        requestInvoice: true,
      );

      expect(url.startsWith('https'), isTrue);
    });
  });

  group('[Notifications]', () {
    test('Get all: languages', () async {
      List<Notification> english =
          await student.notifications.getAll(languageCode: 'en');

      expect(english, isNotEmpty);
      expect(english.first.heading, english.first.headingTr('en'));
      expect(english.first.content, english.first.contentTr('en'));

      List<Notification> spanish =
          await student.notifications.getAll(languageCode: 'es');

      expect(spanish, isNotEmpty);
      expect(spanish.first.heading, spanish.first.headingTr('es'));
      expect(spanish.first.content, spanish.first.contentTr('es'));
    });

    test('Get all: include deleted', () async {
      List<Notification> notifications = await student.notifications.getAll();

      List<Notification> notificationsWithDeletedOnes =
          await student.notifications.getAll(ignoreDeleted: false);

      expect(notifications, isNotEmpty);
      expect(notificationsWithDeletedOnes, isNotEmpty);
      expect(notificationsWithDeletedOnes.length,
          greaterThan(notifications.length));
    });

    test('Get one: languages', () async {
      List<Notification> notifications =
          await student.notifications.getAll(languageCode: 'en');
      expect(notifications, isNotEmpty);

      Notification notification = await student.notifications
          .getOne(notifications.first.id, languageCode: 'en');

      expect(notifications.first.id, notification.id);
      expect(notification.heading, notification.headingTr('en'));
      expect(notification.content, notification.contentTr('en'));
    });

    test('Get one: deleted', () async {
      List<Notification> notifications =
          await student.notifications.getAll(ignoreDeleted: false);
      expect(notifications, isNotEmpty);
      expect(notifications.any((element) => element.isDeleted), isTrue);

      Notification notification = await student.notifications.getOne(
          notifications.firstWhere((element) => element.isDeleted).id,
          ignoreDeleted: false);

      expect(notification.id, notifications.first.id);
      expect(notification.isDeleted, isTrue);
    });

    test('Mark notification as seen', () async {
      List<Notification> notifications = await student.notifications.getAll();
      expect(notifications, isNotEmpty);

      Notification notification =
          await student.notifications.markAsSeen(notifications.first.id);

      expect(notification.isSeen, isTrue);
      expect(notification.seen!.day, DateTime.now().day);
      expect(notification.seen!.month, DateTime.now().month);
      expect(notification.seen!.year, DateTime.now().year);
    });

    test('Mark notification as received', () async {
      List<Notification> notifications = await student.notifications.getAll();
      expect(notifications, isNotEmpty);

      Notification notification =
          await student.notifications.markAsReceived(notifications.first.id);

      expect(notification.isReceived, isTrue);
      expect(notification.received!.day, DateTime.now().day);
      expect(notification.received!.month, DateTime.now().month);
      expect(notification.received!.year, DateTime.now().year);
    });

    test('Delete notification', () async {
      List<Notification> notifications =
          await student.notifications.getAll(languageCode: 'en');
      expect(notifications, isNotEmpty);
      expect(notifications.first.isDeleted, isFalse);

      Notification notification =
          await student.notifications.delete(notifications.first.id);

      expect(notification.isDeleted, isTrue);
      expect(notification.deleted!.day, DateTime.now().day);
      expect(notification.deleted!.month, DateTime.now().month);
      expect(notification.deleted!.year, DateTime.now().year);
    });
  });

  group('[Questionnaire]', () {
    test('Get all answers', () async {
      List<CovidQuestionnaireAnswerDatabase> answers =
          await student.questionnaire.covid.getAnswers();

      expect(answers, isList);
    });

    test('Get today answers', () async {
      List<CovidQuestionnaireAnswerDatabase> answers =
          await student.questionnaire.covid.getAnswers(filter: Answers.Today);

      List<CovidQuestionnaireAnswerDatabase> todayAnswers =
          await student.questionnaire.covid.getTodayAnswers();

      expect(answers.length, todayAnswers.length);
    });

    test('Get user COVID information', () async {
      UserCovidInformation extras =
          await student.questionnaire.covid.getExtras();

      expect(extras.isVaccinated, isFalse);
      expect(extras.haveCovid, isTrue);
      expect(extras.isSuspect, isFalse);
      expect(extras.isInQuarantine, isTrue);
    });

    test('Get COVID validation', () async {
      CovidValidation validation =
          await student.questionnaire.covid.getValidation();

      expect(validation.allowAccess, isTrue);
      expect(validation.validations.recentArrival, isFalse);
      expect(validation.validations.isSuspect, isFalse);
      expect(validation.validations.haveCovid, isFalse);
      expect(validation.validations.isInQuarantine, isFalse);
      expect(validation.validations.noResponsiveLetter, isFalse);
      expect(validation.reason, Reasons.None);
    });

    test('Get responsive letter', () async {
      bool haveResponsiveLetter =
          await student.questionnaire.covid.haveResponsiveLetter();

      expect(haveResponsiveLetter, isTrue);
    });

    test('Update extra information', () async {
      bool updated =
          await student.questionnaire.covid.updateExtras(isSuspect: false);

      expect(updated, isTrue);
    });

    group('Save a new answer', () {
      CovidQuestionnaireAnswer answer = CovidQuestionnaireAnswer(
        countries: [
          RecentCountry(
            country: 'Mexico',
            city: 'Montemorelos',
            date: DateTime.now(),
          ),
        ],
        recentContact: RecentContact(
          yes: false,
          when: DateTime.now(),
        ),
        majorSymptoms: {
          'tos': false,
        },
        minorSymptoms: {
          'dolorDePancita': false,
        },
      );

      test('Student', () async {
        List<CovidQuestionnaireAnswerDatabase> before =
            await student.questionnaire.covid.getTodayAnswers();

        CovidValidation validation =
            await student.questionnaire.covid.saveAnswer(answer);

        List<CovidQuestionnaireAnswerDatabase> after =
            await student.questionnaire.covid.getTodayAnswers();

        expect(after.length, greaterThan(before.length));
        expect(validation.qrUrl.toString().contains(userStudent.toString()),
            isTrue);
        expect(validation.qrUrl.toString().contains('3bbeff'), isTrue);
        expect(validation.reason, Reasons.None);
      });

      test('Employee', () async {
        List<CovidQuestionnaireAnswerDatabase> before =
            await employee.questionnaire.covid.getTodayAnswers();

        CovidValidation validation =
            await employee.questionnaire.covid.saveAnswer(answer);

        List<CovidQuestionnaireAnswerDatabase> after =
            await employee.questionnaire.covid.getTodayAnswers();

        expect(after.length, greaterThan(before.length));
        expect(validation.qrUrl.toString().contains(userEmployee.toString()),
            isTrue);
        expect(validation.qrUrl.toString().contains('3bbe3f'), isTrue);
        expect(validation.reason, Reasons.None);
      });
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

    test('Get calendar', () async {
      Calendar calendar = await student.catalogue.getCalendar();

      expect(calendar.events, isList);
    });

    test('Get calendar: different roles', () async {
      Calendar calendarStudent = await student.catalogue.getCalendar();
      Calendar calendarEmployee = await employee.catalogue.getCalendar();

      expect(calendarStudent.etag, isNot(calendarEmployee.etag));
      expect(calendarStudent.summary, isNot(calendarEmployee.summary));
    });
  });

  group('[Communication]', () {
    test('Get news', () async {
      List<Post> posts = await student.communication.getNews(quantity: 3);

      expect(posts.length, lessThanOrEqualTo(3));
    });

    test('Get events', () async {
      List<Post> posts = await student.communication.getEvents(quantity: 3);

      expect(posts.length, lessThanOrEqualTo(3));
    });

    test('Get blog', () async {
      List<Post> posts = await student.communication.getBlog(quantity: 3);

      expect(posts.length, lessThanOrEqualTo(3));
    });

    test('Get stories', () async {
      List<Group> stories = await student.communication.getStories();

      expect(stories, isList);
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

      expect(user.id, userStudent);
      expect(user.isStudent, isTrue);
      expect(user.image, isNull);

      expect(user.employee, isNull);
      expect(user.student, isNotNull);

      expect(user.student!.academic, isNotNull);
      expect(user.student!.isInternal, isTrue);
      expect(user.student!.isExternal, isFalse);
      expect(user.student!.residenceIsUnknown, isFalse);
      expect(user.student!.isSignedUp, isFalse);
      expect(user.student!.isScholarshipStudent, isFalse);
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

      expect(user.id, userEmployee);
      expect(user.role, Roles.Employee);
      expect(user.employee!.contract, ContractTypes.Contract);
      expect(user.student, isNull);
    });
  });

  group('[Utils]', () {
    test('getRoleFromInt', () {
      Roles unknown = getRoleFromInt(0);
      Roles student = getRoleFromInt(1);
      Roles employee = getRoleFromInt(2);
      Roles outOfBoundA = getRoleFromInt(3);
      Roles outOfBoundB = getRoleFromInt(18);

      expect(unknown, Roles.Unknown);
      expect(student, Roles.Student);
      expect(employee, Roles.Employee);
      expect(outOfBoundA, Roles.Unknown);
      expect(outOfBoundB, Roles.Unknown);
    });

    test('getContractFromInt', () {
      ContractTypes denominational = getContractFromInt(0);
      ContractTypes interDivision = getContractFromInt(1);
      ContractTypes interUnion = getContractFromInt(2);
      ContractTypes missionaryService = getContractFromInt(3);
      ContractTypes retiredWorkerService = getContractFromInt(4);
      ContractTypes contract = getContractFromInt(5);
      ContractTypes voluntaryAdventistService = getContractFromInt(6);
      ContractTypes hourlyTeacher = getContractFromInt(7);
      ContractTypes socialService = getContractFromInt(8);
      ContractTypes hospitalLaCarlota = getContractFromInt(9);
      ContractTypes others = getContractFromInt(10);
      ContractTypes daycareMisAmiguitos = getContractFromInt(11);
      ContractTypes unknown = getContractFromInt(12);

      ContractTypes outOfBoundA = getContractFromInt(17);
      ContractTypes outOfBoundB = getContractFromInt(18);

      expect(unknown, ContractTypes.Unknown);
      expect(denominational, ContractTypes.Denominational);
      expect(interDivision, ContractTypes.InterDivision);
      expect(interUnion, ContractTypes.InterUnion);
      expect(missionaryService, ContractTypes.MissionaryService);
      expect(retiredWorkerService, ContractTypes.RetiredWorkerService);
      expect(contract, ContractTypes.Contract);
      expect(
          voluntaryAdventistService, ContractTypes.VoluntaryAdventistService);
      expect(hourlyTeacher, ContractTypes.HourlyTeacher);
      expect(socialService, ContractTypes.SocialService);
      expect(hospitalLaCarlota, ContractTypes.HospitalLaCarlota);
      expect(others, ContractTypes.Others);
      expect(daycareMisAmiguitos, ContractTypes.DaycareMisAmiguitos);

      expect(outOfBoundA, ContractTypes.Unknown);
      expect(outOfBoundB, ContractTypes.Unknown);
    });

    test('getMovementsTypeFromString', () {
      MovementTypes credit = getMovementsTypeFromString('C');
      MovementTypes debit = getMovementsTypeFromString('D');
      MovementTypes unknown = getMovementsTypeFromString('');
      MovementTypes unknownA = getMovementsTypeFromString('ASD');
      MovementTypes unknownB = getMovementsTypeFromString('This is unknown');

      expect(credit, MovementTypes.Credit);
      expect(debit, MovementTypes.Debit);
      expect(unknown, MovementTypes.Unknown);
      expect(unknownA, MovementTypes.Unknown);
      expect(unknownB, MovementTypes.Unknown);
    });

    test('getLanguageFromString', () {
      Languages spanish = getLanguageFromString('es');
      Languages english = getLanguageFromString('en');
      Languages unknown = getLanguageFromString('');
      Languages unknownA = getLanguageFromString('ASD');
      Languages unknownB = getLanguageFromString('This is unknown');

      expect(spanish, Languages.Es);
      expect(english, Languages.En);
      expect(unknown, Languages.Es);
      expect(unknownA, Languages.Es);
      expect(unknownB, Languages.Es);
    });

    test('getResidenceFromInt', () {
      Residence unknown = getResidenceFromInt(0);
      Residence internalType = getResidenceFromInt(1);
      Residence externalType = getResidenceFromInt(2);
      Residence unknownA = getResidenceFromInt(8);
      Residence unknownB = getResidenceFromInt(12);

      expect(internalType, Residence.Internal);
      expect(externalType, Residence.External);
      expect(unknown, Residence.Unknown);
      expect(unknownA, Residence.Unknown);
      expect(unknownB, Residence.Unknown);
    });

    test('TypesExtension', () {
      String strExternal = Residence.External.keyLabel;
      String strStudent = Roles.Student.keyLabel;
      String strHaveCovid = Reasons.HaveCovid.keyLabel;
      String strDaycareMisAmiguitos =
          ContractTypes.DaycareMisAmiguitos.keyLabel;

      expect(strExternal, 'external');
      expect(strStudent, 'student');
      expect(strHaveCovid, 'haveCovid');
      expect(strDaycareMisAmiguitos, 'daycareMisAmiguitos');
    });
  });
}
