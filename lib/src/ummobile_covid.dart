import 'dart:convert';

import 'package:ummobile_sdk/src/models/questionnaire/covid/validations.dart';
import 'package:ummobile_sdk/src/statics.dart';
import 'package:ummobile_custom_http/ummobile_custom_http.dart';
import 'package:ummobile_sdk/ummobile_sdk.dart';

/// A client for the UMMobile API COVID questionnaire section requests.
class UMMobileCovid {
  /// The API client.
  UMMobileCustomHttp _http;

  /// The path of the requests group.
  static final String path = 'questionnaire/covid';

  /// Main UMMobile COVID questionnaire client constructor.
  ///
  /// Require the [auth] token to authenticate the requests, and the API [version] where to make the calls, which is the latests by default (v1).
  UMMobileCovid({
    required String auth,
    String version: latestVersion,
  }) : this._http = UMMobileCustomHttp(
          baseUrl: '$host/$version/$path',
          auth: Auth(
            token: () => auth,
            tokenType: 'Bearer',
            headerName: 'Authorization',
          ),
        );

  /// Retrieve the user answers for the COVID questionnaire.
  ///
  /// Can [filter] between all the answers or the answers for the current day.
  Future<List<CovidQuestionnaireAnswerDatabase>> getAnswers({
    Answers filter: Answers.All,
  }) {
    String path = filter == Answers.Today ? '/today' : '';
    return this._http.customGet(
          path: path,
          mapper: (json) => List.from(json['answers'])
              .map((e) => this._mapCovidQuestionnaireAnswer(e))
              .toList(),
        );
  }

  /// Retrieve the user answers for the COVID questionnaire for the current day.
  Future<List<CovidQuestionnaireAnswerDatabase>> getTodayAnswers() {
    return this.getAnswers(filter: Answers.Today);
  }

  /// Retrieve the user COVID information.
  Future<UserCovidInformation> getExtras() {
    return this._http.customGet(
          path: '/extras',
          mapper: (json) => this._mapUserCovidInformation(json),
        );
  }

  /// Retrieve the validations for the COVID information.
  Future<CovidValidation> getValidation() {
    return this._http.customGet(
          path: '/validate',
          mapper: (json) => this._mapCovidValidation(json),
        );
  }

  /// Retrieve if the user has upload the responsive letter.
  Future<bool> haveResponsiveLetter() {
    return this._http.customGet(
          path: '/responsiveLetter',
          mapper: (json) => json['haveResponsiveLetter'],
        );
  }

  /// Update user extra information.
  ///
  /// Can update if the user [isSuspect] or not.
  ///
  /// Throws [FormatException] if none argument is given.
  Future<bool> updateExtras({
    bool? isSuspect,
  }) {
    if (isSuspect == null) {
      throw FormatException(
          "At least one property should be included to update");
    }

    return this._http.customPatch(
          path: '/extras',
          body: {
            'isSuspect': isSuspect,
          },
          mapper: (json) => json['updated'],
        );
  }

  /// Save a new COVID questionnaire [answer].
  Future<CovidValidation> saveAnswer(CovidQuestionnaireAnswer answer) {
    return this._http.customPost(
          body: json.encode(answer.toJson()),
          mapper: (json) => this._mapCovidValidation(json),
        );
  }

  UserCovidInformation _mapUserCovidInformation(dynamic json) {
    return UserCovidInformation(
      isVaccinated: json['isVaccinated'],
      haveCovid: json['haveCovid'],
      isSuspect: json['isSuspect'],
      isInQuarantine: json['isInQuarantine'],
      arrivalDate: json['arrivalDate'] != null
          ? DateTime.parse(json['arrivalDate'])
          : null,
      covidStartDate: json['startCovidDate'] != null
          ? DateTime.parse(json['startCovidDate'])
          : null,
      suspicionStartDate: json['startSuspicionDate'] != null
          ? DateTime.parse(json['startSuspicionDate'])
          : null,
      quarantineEndDate: json['quarantineEndDate'] != null
          ? DateTime.parse(json['quarantineEndDate'])
          : null,
    );
  }

  CovidQuestionnaireAnswerDatabase _mapCovidQuestionnaireAnswer(dynamic json) {
    return CovidQuestionnaireAnswerDatabase(
      canPass: json['canPass'],
      countries: List.from(json['countries'])
          .map((country) => RecentCountry(
                country: country['country'],
                city: country['city'],
              ))
          .toList(),
      recentContact: RecentContact(
        yes: json['recentContact']['yes'],
        when: json['recentContact']['when'] != null
            ? DateTime.parse(json['recentContact']['when'])
            : null,
      ),
      majorSymptoms: Map.from(json['majorSymptoms']),
      minorSymptoms: Map.from(json['minorSymptoms']),
      updatedAt: DateTime.parse(json['updatedAt']),
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  CovidValidation _mapCovidValidation(dynamic json) {
    return CovidValidation(
      allowAccess: json['allowAccess'],
      reason: getReasonFromInt(json['reason']),
      qrUrl: Uri.parse(json['qrUrl']),
      validations: PossibleValidations(
        recentArrival: json['validations']['recentArrival'],
        isSuspect: json['validations']['isSuspect'],
        haveCovid: json['validations']['haveCovid'],
        isInQuarantine: json['validations']['isInQuarantine'],
        noResponsiveLetter: json['validations']['noResponsiveLetter'],
      ),
      usedData: this._mapUserCovidInformation(json['usedData']),
    );
  }
}
