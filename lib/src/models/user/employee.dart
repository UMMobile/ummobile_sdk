import 'package:ummobile_sdk/src/types/contract_types.dart';

/// The employment position model
class Position {
  /// The id of the position.
  String id;

  /// The deparment of the position.
  String department;

  /// The name of the position.
  String? name;

  /// The Position constructor.
  Position({
    required this.id,
    required this.department,
    this.name,
  });
}

/// The extra information about the employee.
class EmployeeExtras {
  /// The IMSS registration number of the employee.
  String imss;

  /// The RFC of the employee.
  String rfc;

  /// The type of the employee contract.
  ContractTypes contract;

  /// The positions of the employee.
  List<Position> positions;

  /// The EmployeeExtras constructor.
  EmployeeExtras({
    required this.imss,
    required this.rfc,
    required this.contract,
    required this.positions,
  });
}
