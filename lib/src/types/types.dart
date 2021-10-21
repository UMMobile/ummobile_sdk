export 'contract_types.dart';
export 'residence.dart';
export 'role.dart';
export 'movement_types.dart';
export 'notification_events.dart';
export 'languages.dart';
export 'answers.dart';
export 'reasons.dart';
export 'calendar_types.dart';
export 'media_types.dart';

extension TypesExtension on Enum {
  String get keyLabel {
    String key = this.toString().split('.').last;
    String firstLetter = key.split('').first;
    String lowerCamelCase =
        key.replaceFirst(firstLetter, firstLetter.toLowerCase());
    return lowerCamelCase;
  }
}
