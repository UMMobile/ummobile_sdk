import 'package:ummobile_sdk/src/types/types.dart';

class Rule {
  List<Roles> roles;
  String keyName;
  Uri pdfUrl;

  Rule({
    required this.roles,
    required this.keyName,
    required this.pdfUrl,
  });
}
