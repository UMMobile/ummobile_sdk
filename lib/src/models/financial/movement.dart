import 'package:ummobile_sdk/src/types/types.dart';

/// The movements model.
class Movements {
  /// The balance ID for the movements.
  String balanceId;

  /// The movements from current year.
  List<Movement> current;

  /// The movements from last year.
  List<Movement>? lastYear;

  /// The Movements constructor.
  Movements({
    required this.balanceId,
    required this.current,
    this.lastYear,
  });
}

/// The movement model.
class Movement {
  /// The id movement.
  int id;

  /// The amount of the movement.
  double amount;

  /// The balance amount afther this movement.
  double balanceAfterThis;

  /// The movement type.
  MovementTypes type;

  /// The movement description.
  String description;

  /// The movement date.
  ///
  /// If date is null then is possible that this movement is the balance before current year movements.
  DateTime? date;

  /// Returns `true` if the movement is credit type.
  bool get isCredit => this.type == MovementTypes.Credit;

  /// Returns `true` if the movement is debit type.
  bool get isDebit => this.type == MovementTypes.Debit;

  /// The Movement contructor.
  Movement({
    required this.id,
    required this.amount,
    required this.balanceAfterThis,
    required this.type,
    required this.description,
    this.date,
  });
}
