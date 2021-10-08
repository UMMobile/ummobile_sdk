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
The `getInformation()` function returns a `User` class that contains the information of the user.
```dart
User user = await sdk.user.getInformation();
```

### `getProfilePicture()`
The `getProfilePicture()` function returns the profile picture of the user as a base64 string.
```dart
String base64Image = await sdk.user.getProfilePicture();
```
