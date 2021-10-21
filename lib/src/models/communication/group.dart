import 'package:ummobile_sdk/src/models/communication/story.dart';

/// The group model.
class Group {
  /// The group name.
  String name;

  /// The group image.
  String image;

  /// The group stories.
  List<Story> stories;

  /// The Group constructor.
  Group({
    required this.name,
    required this.image,
    this.stories: const [],
  });
}
