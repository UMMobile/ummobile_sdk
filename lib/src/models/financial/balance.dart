import 'package:ummobile_sdk/src/models/financial/movement.dart';

/// The balance model.
class Balance {
  /// The balance id.
  String id;

  /// The balance name.
  String name;

  /// The current balance amount.
  double current;

  /// The current balance debt.
  double currentDebt;

  /// The balance type.
  String type;

  /// The amount of the promissory note that is not due yet.
  double? promissoryNoteNotDue;

  /// I don't know what this is hehe.
  String? nextPromissoryNote;

  /// The amount of the next promissory note.
  double? nextPromissoryNoteAmount;

  /// The balance movements.
  Movements? movements;

  /// The Balance constructor.
  Balance({
    required this.id,
    required this.name,
    required this.current,
    required this.currentDebt,
    required this.type,
    this.promissoryNoteNotDue,
    this.nextPromissoryNote,
    this.nextPromissoryNoteAmount,
    this.movements,
  });
}
