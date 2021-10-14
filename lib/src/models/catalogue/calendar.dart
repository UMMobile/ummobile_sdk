import 'package:ummobile_sdk/src/types/types.dart';

/// The calendar model.
class Calendar {
  /// The kind of the resource.
  final String? kind;

  /// The etag of the resource.
  final String? etag;

  /// The title of the calendar.
  final String? summary;

  /// The description of the calendar.
  final String? description;

  /// The time zone of the calendar.
  final String? timeZone;

  /// The effective access role that the authenticated user has on the calendar. Read-only. Possible values are:
  /// - "freeBusyReader" - Provides read access to free/busy information.
  /// - "reader" - Provides read access to the calendar. Private events will appear to users with reader access, but event details will be hidden.
  /// - "writer" - Provides read and write access to the calendar. Private events will appear to users with writer access, and event details will be visible.
  /// - "owner" - Provides ownership of the calendar. This role has all of the permissions of the writer role with the additional ability to see and manipulate ACLs.
  final String? accessRole;

  /// The default reminders that the authenticated user has for this calendar.
  final List<dynamic>? defaultReminders;

  /// The token to search for the next events list.
  final String? nextPageToken;

  /// The list of the events of the calendar.
  final List<Event> events;

  /// The Calendar constructor.
  Calendar({
    required this.events,
    this.kind,
    this.etag,
    this.summary,
    this.description,
    this.timeZone,
    this.accessRole,
    this.defaultReminders,
    this.nextPageToken,
  });

  /// Refactor a new instance for this from a JSON.
  factory Calendar.fromMap(Map<String, dynamic> json) {
    return Calendar(
      kind: json["kind"],
      etag: json["etag"],
      summary: json["summary"],
      description: json["description"],
      timeZone: json["timeZone"],
      accessRole: json["accessRole"],
      defaultReminders:
          List<dynamic>.from(json["defaultReminders"].map((x) => x)),
      nextPageToken: json["nextPageToken"],
      events: List<Event>.from(json["items"].map((x) => Event.fromMap(x))),
    );
  }
}

/// The event model.
class Event {
  /// The kind of the resource.
  final Kind? kind;

  /// The etag of the resource.
  final String? etag;

  /// The id of the event.
  final String? id;

  /// The status of the event.
  final Status? status;

  /// The link to the event page.
  final String? htmlLink;

  /// The creation date.
  final DateTime? created;

  /// The date of the last update.
  final DateTime? updated;

  /// The event title.
  final String? summary;

  /// The creator of the event.
  final EventCreator? creator;

  /// The organizer of the event.
  final Organizer? organizer;

  /// The start date of the event.
  final EventDate? start;

  /// The end date of the event.
  final EventDate? end;

  /// The number of the sequence event.
  final int? sequence;

  /// The event type.
  final EventType? eventType;

  /// The description event.
  final String? description;

  /// The Event constructor.
  Event({
    this.kind,
    this.etag,
    this.id,
    this.status,
    this.htmlLink,
    this.created,
    this.updated,
    this.summary,
    this.creator,
    this.organizer,
    this.start,
    this.end,
    this.sequence,
    this.eventType,
    this.description,
  });

  /// Refactor a new instance for this from a JSON.
  factory Event.fromMap(Map<String, dynamic> json) => Event(
        kind: kindValues.map[json["kind"]],
        etag: json["etag"],
        id: json["id"],
        status: statusValues.map[json["status"]],
        htmlLink: json["htmlLink"],
        created: DateTime.parse(json["created"]),
        updated: DateTime.parse(json["updated"]),
        summary: json["summary"],
        creator: EventCreator.fromMap(json["creator"]),
        organizer: Organizer.fromMap(json["organizer"]),
        start: EventDate.fromMap(json["start"]),
        end: EventDate.fromMap(json["end"]),
        sequence: json["sequence"],
        eventType: eventTypeValues.map[json["eventType"]],
        description: json["description"] == null ? null : json["description"],
      );
}

/// The event creator model.
class EventCreator {
  /// The email the of the creator.
  final String? email;

  /// The name of the creator.
  final String? displayName;

  /// The EventCreator constructor.
  EventCreator({
    this.email,
    this.displayName,
  });

  /// Refactor a new instance for this from a JSON.
  factory EventCreator.fromMap(Map<String, dynamic> json) => EventCreator(
        email: json["email"],
        displayName: json["displayName"],
      );
}

/// The event date model.
class EventDate {
  /// The date of the event only using the yyyy-mm-dd.
  final DateTime? date;

  /// The date in ISO 8601 format.
  final DateTime? dateTime;

  /// The EventDate constructor.
  EventDate({
    this.date,
    this.dateTime,
  });

  /// Refactor a new instance for this from a JSON.
  factory EventDate.fromMap(Map<String, dynamic> json) => EventDate(
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        dateTime:
            json["dateTime"] == null ? null : DateTime.parse(json["dateTime"]),
      );
}

/// The organizer model.
class Organizer {
  /// The email of the organizer.
  final String? email;

  /// The organizer constructor.
  Organizer({this.email});

  /// Refactor a new instance for this from a JSON.
  factory Organizer.fromMap(Map<String, dynamic> json) =>
      Organizer(email: json["email"]);
}
