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

# Sections
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

## User
The user information can be found in the `user` attribute on the `UMMobileSDK` class or using the `UMMobileUser` class.

### `getInformation()`
Returns the information of the user.
```dart
User user = await sdk.user.getInformation();
```

### `getProfilePicture()`
Returns the profile picture of the user as a base64 string.
```dart
String base64Image = await sdk.user.getProfilePicture();
```

## Catalogue
The catalogue information can be found in the `catalogue` attribute on the `UMMobileSDK` class or using the `UMMobileCatalogue` class.

### `getRules()`
Returns the list of the user rules.
```dart
List<Rule> rules = await sdk.catalogue.getRules();
```

### `getCountries()`
Returns a list of countries.
```dart
List<Country> countries = await sdk.catalogue.getCountries();
```

## Academic
The academic information can be found in the `academic` attribute on the `UMMobileSDK` class or using the `UMMobileAcademic` class.

### `getArchives()`
Returns the list of the user archives.
```dart
List<Archive> archives = await sdk.academic.getArchives();
```

### `getAllSemesters()`
Returns a class that contains the `semesters`, `average` & the `planId`.
```dart
AllSemesters all = await sdk.academic.getAllSemesters();

print(all.semesters); // Example: [Instance of Semester, Instance of Semester]
print(all.average); // Example: 98.37
```
