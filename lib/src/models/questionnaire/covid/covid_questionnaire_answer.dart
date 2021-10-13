import 'dart:convert';

/// The COVID questionnaire answer model.
class CovidQuestionnaireAnswer {
  /// The recent countries.
  List<RecentCountry> countries;

  /// The recent contacts.
  RecentContact recentContact;

  /// The major symptoms answers.
  Map<String, bool> majorSymptoms;

  /// The minor symptoms answers.
  Map<String, bool> minorSymptoms;

  /// The CovidQuestionnaireAnswer constructor.
  CovidQuestionnaireAnswer({
    required this.countries,
    required this.recentContact,
    required this.majorSymptoms,
    required this.minorSymptoms,
  });

  /// Returns this information in JSON format.
  dynamic toJson() {
    return {
      "countries": this
          .countries
          .map((e) => {
                if (e.country != null) "country": e.country,
                if (e.city != null) "city": e.city,
                if (e.date != null) "date": e.date,
              })
          .toList(),
      "recentContact": {
        "yes": this.recentContact.yes,
        if (this.recentContact.when != null) "when": this.recentContact.when,
      },
      "majorSymptoms": this.majorSymptoms,
      "minorSymptoms": this.minorSymptoms,
    };
  }
}

/// The COVID questionnaire answer from database model.
class CovidQuestionnaireAnswerDatabase extends CovidQuestionnaireAnswer {
  /// The marker to know if can or cannot enter according to the answers.
  bool canPass;

  /// The date when the answer was created.
  DateTime createdAt;

  /// The date when the answer was updated.
  DateTime updatedAt;

  /// The CovidQuestionnaireAnswer constructor.
  CovidQuestionnaireAnswerDatabase({
    required this.canPass,
    required this.createdAt,
    required this.updatedAt,
    required List<RecentCountry> countries,
    required RecentContact recentContact,
    required Map<String, bool> majorSymptoms,
    required Map<String, bool> minorSymptoms,
  }) : super(
          countries: countries,
          recentContact: recentContact,
          majorSymptoms: majorSymptoms,
          minorSymptoms: minorSymptoms,
        );
}

/// The recent country model
class RecentCountry {
  /// The visited country.
  String? country;

  /// The visited city.
  String? city;

  /// The date when that place was visited.
  DateTime? date;

  /// The RecentCountry constructor.
  RecentCountry({
    this.country,
    this.city,
    this.date,
  });
}

/// The recent contact modal.
class RecentContact {
  /// The mark to know if the user had a recent contant.
  bool yes;

  /// The date of the contact.
  DateTime? when;

  /// The RecentContact constructor.
  RecentContact({
    required this.yes,
    this.when,
  });
}
