/// The event types.
enum EventType { DEFAULT }

/// The event types enum values.
final eventTypeValues = EnumValues({"default": EventType.DEFAULT});

/// The kind types.
enum Kind { CALENDAR_EVENT }

/// The kind types enum values.
final kindValues = EnumValues({"calendar#event": Kind.CALENDAR_EVENT});

/// The status types.
enum Status { CONFIRMED }

/// The status types enum values.
final statusValues = EnumValues({"confirmed": Status.CONFIRMED});

/// The transparency types.
enum Transparency { TRANSPARENT }

/// The transparency types enum values.
final transparencyValues =
    EnumValues({"transparent": Transparency.TRANSPARENT});

/// The enum organizer.
class EnumValues<T> {
  /// The map
  Map<String, T> map;

  /// The same [map] but reversed.
  Map<T, String>? reverseMap;

  /// The EnumValues constructor.
  EnumValues(this.map)
      : this.reverseMap = map.map((k, v) => new MapEntry(v, k));
}
