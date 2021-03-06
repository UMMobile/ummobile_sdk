SDK to connect to the UMMobile API

![Test](https://github.com/UMMobile/ummobile_sdk/actions/workflows/main.yml/badge.svg)
[![codecov](https://codecov.io/gh/UMMobile/ummobile_sdk/branch/main/graph/badge.svg?token=9464C1EVLS)](https://codecov.io/gh/UMMobile/ummobile_sdk)

# Getting Started
This package was made for the UMMobile app.

## Initialization
To initialize a new instance a token is needed.
```dart
UMMobileSDK sdk = UMMobileSDK(token: 'YOUR_TOKEN');
```

### Auth
To get a token you can use the static function `UMMobileSDK.auth()` that returns the API section for the authentication.
```dart
// Get token
Token token = await UMMobileSDK
  .auth()
  .getToken(username: 1234567, password: 'YOUR_PASSWORD');

// Get token for testing with sandbox services
Token sandboxToken = await UMMobileSDK
  .auth()
  .getToken(
    username: 1234567,
    password: 'YOUR_PASSWORD',
    sandbox: true,
  );

// Initialize using the access token
UMMobileSDK sdk = UMMobileSDK(token: token.accessToken);
```

# Sections
The `UMMobileSDK` contains an attribute for each API section.

- `user`: contains the functions to get the user information.
- `academic`: contains the functions to get the academic information.
- `financial`: contains the functions to get the financial information.
- `notifications`: contains the functions to get the notifications information.
- `questionnaire`: contains the functions to get the questionnaire information.
  - `covid`: contains the functions to get the COVID questionnaire information.
- `catalogue`: contains the functions to get the general information.
- `communication`: contains the functions to get the information from Conéctate.

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