import 'package:ummobile_sdk/src/types/types.dart';

import 'user_covid_information.dart';

/// The COVID validations model.
class CovidValidation {
  /// The marker to known if the user can or cannot enter to the campus.
  bool allowAccess;

  /// The reason for the response of the validation.
  Reasons reason;

  /// The URL to the QR code.
  Uri qrUrl;

  /// The possible validations from the used date.
  PossibleValidations validations;

  /// The used date to validate.
  UserCovidInformation usedData;

  /// The CovidValidation constructor.
  CovidValidation({
    required this.allowAccess,
    required this.reason,
    required this.qrUrl,
    required this.validations,
    required this.usedData,
  });
}

/// The possible validations from the used date model.
class PossibleValidations {
  /// If the user has recent arrival.
  bool recentArrival;

  /// If the user is suspect.
  bool isSuspect;

  /// If the user have COVID.
  bool haveCovid;

  /// If the user is in quarantine.
  bool isInQuarantine;

  /// If the user do not upload his responsive letter.
  bool noResponsiveLetter;

  /// The PossibleValidations constructor.
  PossibleValidations({
    required this.recentArrival,
    required this.isSuspect,
    required this.haveCovid,
    required this.isInQuarantine,
    required this.noResponsiveLetter,
  });
}
