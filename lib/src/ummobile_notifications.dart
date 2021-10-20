import 'package:ummobile_sdk/src/models/models.dart';
import 'package:ummobile_sdk/src/statics.dart';
import 'package:ummobile_sdk/src/types/types.dart';
import 'package:ummobile_custom_http/ummobile_custom_http.dart';
import 'package:ummobile_sdk/src/utils/utils.dart';

/// A client for the UMMobile API notifications section requests.
class UMMobileNotifications {
  /// The API client.
  UMMobileCustomHttp _http;

  /// The path of the requests group.
  static final String path = 'notifications';

  /// The default language code to use for the notifications.
  String languageCode;

  /// The default value to know if should ignore deleted notifications.
  bool ignoreDeleted;

  /// Main UMMobile user notifications constructor.
  ///
  /// Require the [token] token to authenticate the requests, and the API [version] where to make the calls, which is the latests by default (v1).
  ///
  /// Also can receive the default [languageCode] to use for the notifications (default "es"). If the [languageCode] specified cannot be located in the translations options then Spanish ("es") will be used.
  ///
  /// Deleted notifications are not actually deleted but marked as deleted to be ignored by default, but if [ignoreDeleted] is set to `true` the default functionality will be overriden and deleted notifications will be included. This value will be the default value for the functions in this class that can receive if should ignore deleted notifications like [this.getAll()] or [this.getOne()].
  UMMobileNotifications({
    required String token,
    String version: latestVersion,
    this.languageCode: 'es',
    this.ignoreDeleted: true,
  }) : this._http = UMMobileCustomHttp(
          baseUrl: '$host/$version/$path',
          auth: Auth(
            token: () => token,
            tokenType: 'Bearer',
            headerName: 'Authorization',
          ),
        );

  /// Retrieve all the user notifications.
  ///
  /// Can receive the [languageCode] (default null -[this.languageCode = "es"] is used in that case-) to use for the notifications. If the langauge cannot be located then Spanish will be used.
  ///
  /// Also can receive if should [ignoreDeleted] notifications. Deleted notifications are not actually deleted but marked as deleted to be ignored by default, but if [ignoreDeleted] is set to `true` the default functionality will be overriden and deleted notifications will be included.
  Future<List<Notification>> getAll({
    String? languageCode,
    bool? ignoreDeleted,
  }) {
    return this._http.customGet(
      queries: {
        'ignoreDeleted': ignoreDeleted ?? this.ignoreDeleted,
      },
      mapper: (json) => List.from(json['notifications'])
          .map<Notification>((e) => this._mapNotification(
                e,
                languageCode: languageCode ?? this.languageCode,
              ))
          .toList(),
    );
  }

  /// Retrieve a single notification by his [notificationId].
  ///
  /// Can receive the [languageCode] (default null -[this.languageCode = "es"] is used in that case-) to use for the notifications. If the langauge cannot be located then Spanish will be used.
  ///
  /// Also can receive if should [ignoreDeleted] notifications. Deleted notifications are not actually deleted but marked as deleted to be ignored by default, but if [ignoreDeleted] is set to `true` the default functionality will be overriden and deleted notifications will be included.
  Future<Notification> getOne(
    String notificationId, {
    String? languageCode,
    bool? ignoreDeleted,
  }) {
    return this._http.customGet(
          path: '/$notificationId',
          queries: {
            'ignoreDeleted': ignoreDeleted ?? this.ignoreDeleted,
          },
          mapper: (json) => this._mapNotification(
            json,
            languageCode: languageCode ?? this.languageCode,
          ),
        );
  }

  /// Delete the notification with the [notificationId].
  delete(String notificationId) {
    return this._update(notificationId, deleted: true);
  }

  /// Mark as seen the notification with the [notificationId].
  markAsSeen(String notificationId) {
    return this._update(notificationId, seen: true);
  }

  /// Send a new analytic [event] for the notification with the [notificationId].
  Future<void> sendAnalitycs({
    required String notificationId,
    required NotificationEvents event,
  }) {
    return this._http.customPost<void>(
      path: '/$notificationId/analytics',
      queries: {
        'event': event.keyLabel,
      },
    );
  }

  /// Update the [deleted] & [seen] properties of the notification with the [notificationId].
  ///
  /// Can receive the [languageCode] (default null -[this.languageCode = "es"] is used in that case-) to use for the notifications. If the langauge cannot be located then Spanish will be used.
  ///
  /// Throws [FormatException] if none field is marked to update.
  Future<Notification> _update(
    String notificationId, {
    bool deleted: false,
    bool seen: false,
    String? languageCode,
  }) {
    Map<String, String> body = {
      if (deleted) 'deleted': DateTime.now().toIso8601String(),
      if (seen) 'seen': DateTime.now().toIso8601String(),
    };

    if (body.isEmpty) {
      throw FormatException(
          "At least one property should be included to update");
    }

    return this._http.customPatch(
          path: '/$notificationId',
          body: body,
          mapper: (json) => this._mapNotification(json,
              languageCode: languageCode ?? this.languageCode),
        );
  }

  Notification _mapNotification(
    dynamic json, {
    String? languageCode,
  }) {
    languageCode = languageCode ?? this.languageCode;
    return Notification(
      id: json['id'],
      createAt: DateTime.parse(json['createAt']),
      language: getLanguageFromString(languageCode),
      content: NotificationContent(
        heading: Translations(
          en: json['content']['heading']['en'],
          es: json['content']['heading']['es'],
        ),
        content: Translations(
          en: json['content']['content']['en'],
          es: json['content']['content']['es'],
        ),
      ),
      seen: json['seen'] != null ? DateTime.parse(json['seen']) : null,
      deleted: json['deleted'] != null ? DateTime.parse(json['deleted']) : null,
    );
  }
}
