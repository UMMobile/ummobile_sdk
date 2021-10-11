import 'package:ummobile_sdk/src/types/types.dart';

extension IntegerConditionals on int {
  bool isValidIndexOf(List list) => this >= 0 && this < list.length;
}

/// Returns the role type of the given [role] string.
Roles getRoleFromInt(int role) {
  if (role.isValidIndexOf(Roles.values)) {
    return Roles.values[role];
  } else {
    return Roles.Unknown;
  }
}

/// Returns the contract type of the given [contract] string.
ContractTypes getContractFromInt(int contract) {
  if (contract.isValidIndexOf(ContractTypes.values)) {
    return ContractTypes.values[contract];
  } else {
    return ContractTypes.Unknown;
  }
}

/// Return the movement type of the given [movementType] string.
MovementTypes getMovementsTypeFromString(String movementType) {
  switch (movementType) {
    case 'C':
      return MovementTypes.Credit;
    case 'D':
      return MovementTypes.Debit;
    default:
      return MovementTypes.Unknown;
  }
}
