import 'package:ummobile_sdk/src/types/media_types.dart';

/// The story model
class Story {
  /// The start date of the story.
  DateTime startDate;

  /// The end date of the story.
  DateTime endDate;

  /// The seconds duration of the story.
  int duration;

  /// The story content type.
  MediaType type;

  /// The story content.
  String content;

  /// The Story constructor.
  Story({
    required this.startDate,
    required this.endDate,
    required this.duration,
    required this.type,
    required this.content,
  });
}
