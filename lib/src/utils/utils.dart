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

/// Returns the movement type of the given [movementType] string.
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

/// Returns the language type from the [languageCode].
///
/// If any language is recognized then returns [Language.Es] by default.
Languages getLanguageFromString(String languageCode) {
  switch (languageCode) {
    case 'en':
      return Languages.En;
    case 'es':
    default:
      return Languages.Es;
  }
}
