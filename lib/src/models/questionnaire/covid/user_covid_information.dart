/// The user covid information model.
class UserCovidInformation {
  /// The marker to know if user is vaccinated.
  bool isVaccinated;

  /// The marker to know if the user have COVID.
  bool haveCovid;

  /// The marker to know if the user is suspect.
  bool isSuspect;

  /// The marker to know if the user is in quarantine.
  bool isInQuarantine;

  /// The user arrival date to the campus.
  DateTime? arrivalDate;

  /// The user COVID start date.
  DateTime? covidStartDate;

  /// The user suspicion start date.
  DateTime? suspicionStartDate;

  /// The user quarantine end date.
  DateTime? quarantineEndDate;

  /// The UserCovidInformation constructor.
  UserCovidInformation({
    required this.isVaccinated,
    required this.haveCovid,
    required this.isSuspect,
    required this.isInQuarantine,
    this.arrivalDate,
    this.covidStartDate,
    this.suspicionStartDate,
    this.quarantineEndDate,
  });
}
