import 'package:ummobile_sdk/src/types/contract_types.dart';
import 'package:ummobile_sdk/src/types/role.dart';

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
getContractFromInt(int contract) {
  if (contract.isValidIndexOf(ContractTypes.values)) {
    return ContractTypes.values[contract];
  } else {
    return ContractTypes.Unknown;
  }
}
