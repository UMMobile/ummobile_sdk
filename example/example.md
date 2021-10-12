- [Initialization](#initialization)
  - [Auth](#auth)
- [Usage](#usage)
  - [Individual vs Main class](#individual-vs-main-class)
  - [Sections](#sections)
    - [User](#user)
      - [`getInformation()`](#getinformation)
      - [`getProfilePicture()`](#getprofilepicture)
    - [Catalogue](#catalogue)
      - [`getRules()`](#getrules)
      - [`getCountries()`](#getcountries)
    - [Academic](#academic)
      - [`getArchives()`](#getarchives)
      - [`getAllSemesters()`](#getallsemesters)
      - [`getCurrentSemester()`](#getcurrentsemester)
      - [`getPlan()`](#getplan)
      - [`getGlobalAverage()`](#getglobalaverage)
    - [Financial](#financial)
      - [`getBalances()`](#getbalances)
      - [`getMovements(String balance)`](#getmovementsstring-balance)
    - [Notifications](#notifications)
      - [`getAll()`](#getall)
      - [`getOne(String notificationId)`](#getonestring-notificationid)
      - [`markAsSeen(String notificationId)`](#markasseenstring-notificationid)
      - [`delete(String notificationId)`](#deletestring-notificationid)
      - [`sendAnalytics()`](#sendanalytics)

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

### Academic
The academic information can be found in the `academic` attribute on the `UMMobileSDK` class or using the `UMMobileAcademic` class.

**WARNING:**
Some information may vary in certain periods such as vacations because if the student works at the university they will put a different plan while he works to give him the basic rights such as residence or student insurance. _To see the current plan see the `getPlan()` function_.

#### `getArchives()`
Returns the list of the user archives.
```dart
List<Archive> archives = await sdk.academic.getArchives();
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
Return a single notification. The usage of this function is similar to `getAll()` but with one positional argument (`notificationId`).
```dart
Notification notification =
          await sdk.notifications.getOne('NOTIFICATION_ID');

// Also can receive a languageCode or if should ignoreDeleted notifications.
Notification notification =
      await sdk.notifications.getOne(
          'NOTIFICATION_ID',
          languageCode: 'es', // Use Spanish
          ignoreDelete: false, // Allow search for a delete notification.
      );
```

#### `markAsSeen(String notificationId)`
Mark a notification as seen.
```dart
Notification notification =
          await sdk.notifications.getOne('NOTIFICATION_ID');

print(notification.isSeen); // false

Notification seenNotification =
          await sdk.notifications.markAsSeen(notification.id);

print(seenNotification.isSeen); // true
```

#### `delete(String notificationId)`
Delete a notification.
```dart
Notification notification =
          await sdk.notifications.getOne('NOTIFICATION_ID');

print(notification.isDeleted); // false

Notification deletedNotification =
          await sdk.notifications.delete(notification.id);

print(deletedNotification.isDeleted); // true
```

#### `sendAnalytics()`
Send a new user event for a notification.

Some events are "clicked" that is equivalent to read or see the notification, and "received" that means that the notification was received by the user cellphone.
```dart
Notification notification =
          await sdk.notifications.getOne('NOTIFICATION_ID');

// Send a received event.
await sdk.notifications.sendAnalitycs(
  notificationId: notification.id,
  event: NotificationEvents.Received,
);

// Send a clicked event.
await sdk.notifications.sendAnalitycs(
  notificationId: notification.id,
  event: NotificationEvents.Clicked,
);

```