# Initialization
To initialize a new instance a token is needed.
```dart
UMMobileAPI api = UMMobileAPI(token: 'YOUR_TOKEN');
```

## Auth
To get a token you can use the static function `UMMobileAPI.auth()` that returns the API section for the authentication.
```dart
// Get token
Token token = await UMMobileAPI
  .auth()
  .getToken(username: 1234567, password: 'YOUR_PASSWORD');

// Initialize using the access token
UMMobileAPI api = UMMobileAPI(token: token.accessToken);
```

# Sections
The `UMMobileAPI` contains an attribute for each API section.

## User
The user information can be found in the `user` attribute.

### `getUser()`
The `getUser()` function returns a `User` class that contains the information of the user.
```dart
User user = await api.user.getUser();
```

### `getProfilePicture()`
The `getProfilePicture()` function returns the profile picture of the user as a base64 string.
```dart
String base64Image = await api.user.getProfilePicture();
```
