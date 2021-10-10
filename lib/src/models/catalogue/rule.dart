import 'package:ummobile_sdk/src/types/types.dart';

/// The rules document model.
class Rule {
  /// The list of roles to which that rules apply.
  ///
  /// Can contains none, one, or more of any of the user `Roles`.
  List<Roles> roles;

  /// the key name of the rules document.
  ///
  /// This is a key of how the rules document is named. Is used for translations purpose.
  String keyName;

  /// The URL where the PDF is located.
  Uri pdfUrl;

  /// The Rule constructor.
  Rule({
    required this.roles,
    required this.keyName,
    required this.pdfUrl,
  });
}
