import 'package:ummobile_sdk/src/types/contract_types.dart';

class Position {
  String id;
  String department;
  String? name;

  Position({
    required this.id,
    required this.department,
    this.name,
  });
}

class EmployeeExtras {
  String imss;
  String rfc;
  ContractTypes contract;
  List<Position> positions;

  EmployeeExtras({
    required this.imss,
    required this.rfc,
    required this.contract,
    required this.positions,
  });
}
