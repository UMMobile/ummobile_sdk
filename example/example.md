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
