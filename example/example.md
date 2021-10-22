- [Initialization](#initialization)
  - [Auth](#auth)
- [Usage](#usage)
  - [Individual vs Main class](#individual-vs-main-class)
  - [Enum: `keyLabel`](#enum-keylabel)
  - [Sections](#sections)
    - [User](#user)
      - [`getInformation()`](#getinformation)
      - [`getProfilePicture()`](#getprofilepicture)
    - [Catalogue](#catalogue)
      - [`getRules()`](#getrules)
      - [`getCountries()`](#getcountries)
      - [`getCalendar()`](#getcalendar)
    - [Communication](#communication)
      - [`getNews()`](#getnews)
      - [`getEvents()`](#getevents)
      - [`getBlog()`](#getblog)
      - [`getStories()`](#getstories)
    - [Academic](#academic)
      - [`getDocuments()`](#getdocuments)
      - [`getAllSemesters()`](#getallsemesters)
      - [`getCurrentSemester()`](#getcurrentsemester)
      - [`getPlan()`](#getplan)
      - [`getGlobalAverage()`](#getglobalaverage)
    - [Financial](#financial)
      - [`getBalances()`](#getbalances)
      - [`getMovements(String balance)`](#getmovementsstring-balance)
      - [`generatePaymentUrl(Payment payment)`](#generatepaymenturlpayment-payment)
    - [Notifications](#notifications)
      - [`getAll()`](#getall)
      - [`getOne(String notificationId)`](#getonestring-notificationid)
      - [`markAsSeen(String notificationId)`](#markasseenstring-notificationid)
      - [`delete(String notificationId)`](#deletestring-notificationid)
      - [`sendAnalytics()`](#sendanalytics)
    - [COVID questionnaire](#covid-questionnaire)
      - [`getAnswers()`](#getanswers)
      - [`getTodayAnswers()`](#gettodayanswers)
      - [`getExtras()`](#getextras)
      - [`getValidation()`](#getvalidation)
      - [`haveResponsiveLetter()`](#haveresponsiveletter)
      - [`updateExtras()`](#updateextras)
      - [`saveAnswer(CovidQuestionnaireAnswer answer)`](#saveanswercovidquestionnaireanswer-answer)

# Initialization
To initialize a new instance a token is needed.
```dart
UMMobileSDK sdk = UMMobileSDK(token: 'YOUR_TOKEN');
```

## Auth
To get a token you can use the static function `UMMobileSDK.auth()` that returns the API section for the authentication.
```dart
// Get token
Token token = await UMMobileSDK
  .auth()
  .getToken(username: 1234567, password: 'YOUR_PASSWORD');

// Initialize using the access token
UMMobileSDK sdk = UMMobileSDK(token: token.accessToken);
```

# Usage
The `UMMobileSDK` contains an attribute for each API section.

## Individual vs Main class
Each section can be found in an attribute of the main class, but can also be used individually.
```dart
// Individual class
UMMobileUser user = UMMobileUser(token: 'YOUT_TOKEN');
await user.getInformation();

// Main class
UMMobileSDK sdk = UMMobileSDK(token: 'YOUR_TOKEN');
await sdk.user.getInformation();
```

## Enum: `keyLabel`
Each `Enum` contains a getter `keyLabel` that returns the enum label that can use for translations. The `keyLabel` is the same that the enum name but with the first letter in lower case.
```dart
print(Residence.External.keyLabel); // external
print(Roles.Student.keyLabel); // student
print(Reasons.HaveCovid.keyLabel); // haveCovid
print(ContractTypes.DaycareMisAmiguitos.keyLabel); // daycareMisAmiguitos
```

## Sections
### User
The user information can be found in the `user` attribute on the `UMMobileSDK` class or using the `UMMobileUser` class.

#### `getInformation()`
Returns the information of the user.
```dart
User user = await sdk.user.getInformation();
```

#### `getProfilePicture()`
Returns the profile picture of the user as a base64 string.
```dart
String base64Image = await sdk.user.getProfilePicture();
```

### Catalogue
The catalogue information can be found in the `catalogue` attribute on the `UMMobileSDK` class or using the `UMMobileCatalogue` class.

#### `getRules()`
Returns the list of the user rules.
```dart
List<Rule> rules = await sdk.catalogue.getRules();
```

#### `getCountries()`
Returns a list of countries.
```dart
List<Country> countries = await sdk.catalogue.getCountries();
```

#### `getCalendar()`
Returns the calendar for the user or the students calendar by default.
```dart
Calendar calendar = await sdk.catalogue.getCalendar();

print(calendar.events); // [Instance of Event, Instance of Event, Instance of Event, ...]
print(calendar.summary); // title: "Agenda institucional"
```

### Communication
The institutional communication information can be found in the `communication` attribute on the `UMMobileSDK` class or using the `UMMobileCommunication` class.

#### `getNews()`
Returns a list of the latest news (Posts) from Conéctate.
```dart
List<Post> posts = await sdk.communication.getNews(quantity: 3);
```

#### `getEvents()`
Returns a list of the latest events (Posts) from Conéctate.
```dart
List<Post> posts = await sdk.communication.getEvents(quantity: 3);
```

#### `getBlog()`
Returns a list of the latest posts from the blog (Posts) from Conéctate.
```dart
List<Post> posts = await sdk.communication.getBlog(quantity: 3);
```

#### `getStories()`
Returns a list of the latest stories from Conéctate.
```dart
List<Group> groups = await sdk.communication.getStories();

print(groups.stories); // [Instance of Story, Instance of Story, ...]
```

### Academic
The academic information can be found in the `academic` attribute on the `UMMobileSDK` class or using the `UMMobileAcademic` class.

**WARNING:**
Some information may vary in certain periods such as vacations because if the student works at the university they will put a different plan while he works to give him the basic rights such as residence or student insurance. _To see the current plan see the `getPlan()` function_.

#### `getDocuments()`
Returns the list of the user documents.
```dart
List<Document> documents = await sdk.academic.getDocuments();
```

#### `getAllSemesters()`
Returns a class that contains the `semesters`, `average` & the `planId`.
```dart
AllSemesters all = await sdk.academic.getAllSemesters();

print(all.semesters); // Example: [Instance of Semester, Instance of Semester]
print(all.average); // Example: 98.37
```

#### `getCurrentSemester()`
Returns the current semester.
```dart
Semester semester = await sdk.academic.getCurrentSemester();

print(semester.subjects); // List of current subjects
print(semester.name); // Example: "PRIMER SEMESTRE"
```

#### `getPlan()`
Returns the current plan.
```dart
String planId = await sdk.academic.getPlan();
```

#### `getGlobalAverage()`
Returns the global average for the current plan (_`getPlan()`_).
```dart
double average = await sdk.academic.getGlobalAverage();
```

### Financial
The financial information can be found in the `financial` attribute on the `UMMobileSDK` class or using the `UMMobileFinancial` class.

#### `getBalances()`
Returns the list of the user balances.
```dart
// Without movements
List<Balance> balances = await sdk.financial.getBalances();
print(balances.first.movements); // null

// With current year movements.
List<Balance> balances = await sdk.financial.getBalances(includeMovements: IncludeMovements.OnlyCurrent);
print(balances.first.movements!.current); // [Instance of Movement, Instance of Movement, ...]
print(balances.first.movements!.lastYear); // null

// With current and last year movements.
List<Balance> balances = await sdk.financial.getBalances(includeMovements: IncludeMovements.CurrentAndLastYear);
print(balances.first.movements!.current); // [Instance of Movement, Instance of Movement, ...]
print(balances.first.movements!.lastYear); // [Instance of Movement, Instance of Movement, ...]
```

#### `getMovements(String balance)`
Returns a `Movements` class with the balance movements. This class contains the `current` year movements and also can contains (but optional) the `lastYear` movements.
```dart
// Only current year movements
Movements movements = await sdk.financial.getMovements('BALANCE_ID');
print(movements.current); // [Instance of Movement, Instance of Movement, ...]
print(movements.lastYear); // null

// Current and last year movements
Movements movements = await sdk.financial.getMovements('BALANCE_ID', includeLastYear: true);
print(movements.current); // [Instance of Movement, Instance of Movement, ...]
print(movements.lastYear); // [Instance of Movement, Instance of Movement, ...]
```

#### `generatePaymentUrl(Payment payment)`
Returns the payment URL.
```dart
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

String urlA = await student.financial.generatePaymentUrl(payment);

// Generate URL and request invoice for the payment.
String urlB = await student.financial.generatePaymentUrl(
  payment,
  requestInvoice: true,
);
```

### Notifications
The notifications information can be found in the `notifications` attribute on the `UMMobileSDK` class or using the `UMMobileNotifications` class.

Can receive default values for optional named arguments for some functions like `getAll()` or `getOne()`:
```dart
UMMobileNotifications notificationsSection = UMMobileNotifications(
  // required
  auth: 'TOKEN',
  // Set "es" as default argument value for all functions that don't pass `languageCode`.
  languageCode: 'es',
  // Set false as default argument value for all functions that don't pass `ignoreDeleted`.
  ignoreDeleted: false,
);
```

#### `getAll()`
Returns the list of the notifications sent to the user.
```dart
// Will use english and will ignore deleted nofitications by default.
List<Notification> defaultValues =
          await sdk.notifications.getAll();

print(defaultValues.first.heading); // Hi
print(defaultValues.any((notification) => notification.isDeleted)); // false

// With english language.
List<Notification> english =
          await sdk.notifications.getAll(languageCode: 'en');

print(english.first.heading); // Hi

// Change to "es" to use Spanish by default.
List<Notification> spanish =
          await sdk.notifications.getAll(languageCode: 'es');

print(spanish.first.heading); // Hola

// Or get differente of default
print(spanish.first.headingTr('en')); // Hi
print(spanish.first.headingTr('es')); // Hola

// To include deleted notifications set `ignoreDeleted` to false
List<Notification> withDeletedNotifications =
          await sdk.notifications.getAll(ignoreDeleted: false);

print(withDeletedNotifications.any((notification) => notification.isDeleted)); // true if user had deleted at least one notification.
```

#### `getOne(String notificationId)`
Returns a single notification. The usage of this function is similar to `getAll()` but with one positional argument (`notificationId`).
```dart
Notification notification =
          await sdk.notifications.getOne('NOTIFICATION_ID');

// Also can receive a languageCode or if should ignoreDeleted notifications.
Notification notification =
      await sdk.notifications.getOne(
          'NOTIFICATION_ID',
          languageCode: 'es', // Use Spanish
          ignoreDelete: false, // Allow search for a deleted notification.
      );
```

#### `markAsSeen(String notificationId)`
Marks a notification as seen.
```dart
Notification notification =
          await sdk.notifications.getOne('NOTIFICATION_ID');

print(notification.isSeen); // false

Notification seenNotification =
          await sdk.notifications.markAsSeen(notification.id);

print(seenNotification.isSeen); // true
```

#### `delete(String notificationId)`
Deletes a notification.
```dart
Notification notification =
          await sdk.notifications.getOne('NOTIFICATION_ID');

print(notification.isDeleted); // false

Notification deletedNotification =
          await sdk.notifications.delete(notification.id);

print(deletedNotification.isDeleted); // true
```

#### `sendAnalytics()`
Sends a new user event for a notification.

Some events are "clicked" that is equivalent to read or see the notification, and "received" that means that the notification was received by the user cellphone.
```dart
// Send a received event.
await sdk.notifications.sendAnalitycs(
  notificationId: 'NOTIFICATION_ID',
  event: NotificationEvents.Received,
);

// Send a clicked event.
await sdk.notifications.sendAnalitycs(
  notificationId: 'NOTIFICATION_ID',
  event: NotificationEvents.Clicked,
);

```

### COVID questionnaire
The COVID questionnaire information can be found in the `questionnaire.covid` attribute on the `UMMobileSDK` class, in the `covid` attribute on the `UMMobileQuestionnaire` class, or using the `UMMobileCovid` class.

**Note:**
The class for the questionnare information (`UMMobileQuestionnaire`) is empty while there is no service to manage differente questionnaires yet so this section will be for the COVID questionnaire class.

#### `getAnswers()`
Returns all the user answers to the questionnaire.

Uses the `CovidQuestionnaireAnswerDatabase` to differentiate from the request body to save a new answer (see `saveAnswer()`) and to avoid setting some fields as optional when they are automatically configured in the database, so they will always come in the answer.
```dart
// Get all answers
List<CovidQuestionnaireAnswerDatabase> answers =
          await sdk.questionnaire.covid.getAnswers();

// Get all answers for current day
List<CovidQuestionnaireAnswerDatabase> todayAnswers =
          await sdk.questionnaire.covid.getAnswers(filter: Answers.Today);
```

#### `getTodayAnswers()`
Returns all the user answers to the questionnaire on the current day (from the server perspective).

Uses `getAnswers(filter: Answers.Today)` under the hood.
```dart
List<CovidQuestionnaireAnswerDatabase> todayAnswers =
          await sdk.questionnaire.covid.getTodayAnswers();
```

#### `getExtras()`
Returns extra critical information about COVID and the user.
```dart
UserCovidInformation extras =
          await sdk.questionnaire.covid.getExtras();

print(extras.isVaccinated); // false or true
print(extras.haveCovid); // false or true
print(extras.isSuspect); // false or true
print(extras.isInQuarantine); // false or true
```

#### `getValidation()`
Returns the validation of the user information using the extra critial information (see `getExtras()`) to know if the user can or cannot enter to the campus.

**Note:**
This function must be used before allowing the user to respond to the questionnaire to know if he can access the questionnaire or if his entrance to the campus should be rejected.
```dart
CovidValidation validation =
          await sdk.questionnaire.covid.getValidation();

print(validation.allowAccess); // if can or cannot enter
print(validation.reason); // the reason of the validations result
print(validation.qrUrl); // the URI to the QR image
```

#### `haveResponsiveLetter()`
Returns if the user has uploaded or not his responsive letter.
```dart
bool haveResponsiveLetter =
          await sdk.questionnaire.covid.haveResponsiveLetter();
```

#### `updateExtras()`
Updates fields of the extra user information about COVID.

**Note:** At this time we can only update if the user is suspicious or not. If the fields are updated, the start date of the suspicion is also updated.

Returns if the information was udpated & throws a `FormatException` if none field is set to update (at this time only `isSuspect`).
```dart
bool updated =
          await sdk.questionnaire.covid.updateExtras(isSuspect: false);
```

#### `saveAnswer(CovidQuestionnaireAnswer answer)`
Saves a new user answer to the COVID questionnaire and returns a nbew validation of the user information.

**Note:**
The answers are validated and can update additional user information to establish the user as a suspect.
```dart
CovidQuestionnaireAnswer answer = CovidQuestionnaireAnswer(
  countries: [
    RecentCountry(
      country: 'México',
      city: 'Montemorelos',
    ),
  ],
  recentContact: RecentContact(yes: false),
  majorSymptoms: {
    'tos': false,
  },
  minorSymptoms: {
    'dolorDePancita': false,
  },
);

CovidValidation validation =
          await sdk.questionnaire.covid.saveAnswer(answer);

print(validation.allowAccess); // if can or cannot enter
print(validation.reason); // the reason of the validations result
print(validation.qrUrl); // the URI to the QR image
```
