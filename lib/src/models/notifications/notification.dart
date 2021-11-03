import 'package:ummobile_sdk/src/types/types.dart';
import 'package:ummobile_sdk/src/utils/utils.dart';

/// The notification model.
class Notification {
  /// The notification id.
  String id;

  /// The notification content.
  NotificationContent _content;

  /// The time when the notification was created.
  ///
  /// **Note:**
  /// This date and time are from the server side.
  DateTime createAt;

  /// The notification language to use by default.
  Languages language;

  /// The time when the notification was received.
  ///
  /// If null then it hasn't been received.
  DateTime? received;

  /// The time when the notification was seen.
  ///
  /// If null then it hasn't been seen.
  DateTime? seen;

  /// The time where the notification was created.
  ///
  /// If null then it hasn't been deleted.
  DateTime? deleted;

  /// Returns `true` if the notification was received.
  bool get isReceived => this.received != null;

  /// Returns `true` if the notification was seen.
  bool get isSeen => this.seen != null;

  /// Returns `true` if the notification is deleted.
  ///
  /// Never will be deleted because never returns the deleted notifications.
  bool get isDeleted => this.deleted != null;

  /// The content of the notification for the specified [this.language].
  String get content => this._content.getContent(this.language);

  /// The heading of the notification for specified [this.language].
  String get heading => this._content.getHeading(this.language);

  /// Get the content for the [languageCode].
  ///
  /// If the [languageCode] can not be recognized then the Spanish translation is returned.
  String contentTr(String languageCode) =>
      this._content.getContent(getLanguageFromString(languageCode));

  /// Get the heading for the [languageCode].
  ///
  /// If the [languageCode] can not be recognized then the Spanish translation is returned.
  String headingTr(String languageCode) =>
      this._content.getHeading(getLanguageFromString(languageCode));

  /// The Notification constructor.
  Notification({
    required this.id,
    required this.createAt,
    required this.language,
    required NotificationContent content,
    this.received,
    this.seen,
    this.deleted,
  }) : this._content = content;
}

/// The notification content model.
class NotificationContent {
  /// The notification heading.
  Translations heading;

  /// The notification content.
  Translations content;

  /// The push notification content.
  Translations? pushHeading;

  /// The push notification content.
  Translations? pushContent;

  /// Get the content for the [languageCode].
  ///
  /// If the [languageCode] can not be recognized then the Spanish translation is returned.
  String getContent(Languages language) {
    switch (language) {
      case Languages.En:
        return this.content.en;
      case Languages.Es:
      default:
        return this.content.es;
    }
  }

  /// Get the heading for the [languageCode].
  ///
  /// If the [languageCode] can not be recognized then the Spanish translation is returned.
  String getHeading(Languages language) {
    switch (language) {
      case Languages.En:
        return this.heading.en;
      case Languages.Es:
      default:
        return this.heading.es;
    }
  }

  /// The NotificationContent constructor.
  ///
  /// The [pushHeading] & [pushContent] are the one that goes to the status bar while the [heading] & [content] are the ones that are displayed inside the app.
  NotificationContent({
    required this.heading,
    required this.content,
    this.pushHeading,
    this.pushContent,
  });
}

/// The translations model.
class Translations {
  /// The text in English.
  String en;

  /// The text in Español.
  String es;

  /// The Translations constructor.
  Translations({
    required this.en,
    required this.es,
  });
}
