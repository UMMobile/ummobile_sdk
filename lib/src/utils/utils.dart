import 'package:ummobile_sdk/src/types/types.dart';

extension IntegerConditionals on int {
  bool isValidIndexOf(List list) => this >= 0 && this < list.length;
}

/// Returns the role type of the given [role] int.
Roles getRoleFromInt(int role) => getFromEnum(
      value: role,
      validValues: Roles.values,
      defaultValue: Roles.Unknown,
    );

/// Returns the contract type of the given [contract] int.
ContractTypes getContractFromInt(int contract) => getFromEnum(
      value: contract,
      validValues: ContractTypes.values,
      defaultValue: ContractTypes.Unknown,
    );

/// Returns the movement type of the given [movementType] string.
MovementTypes getMovementsTypeFromString(String movementType) {
  switch (movementType.toUpperCase()) {
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
  switch (languageCode.toLowerCase()) {
    case 'en':
      return Languages.En;
    case 'es':
    default:
      return Languages.Es;
  }
}

/// Returns the residence type of the given [residence] int.
Residence getResidenceFromInt(int residence) => getFromEnum(
      value: residence,
      validValues: Residence.values,
      defaultValue: Residence.Unknown,
    );

/// Returns the reason type of the given [reason] int.
Reasons getReasonFromInt(int reason) => getFromEnum(
      value: reason,
      validValues: Reasons.values,
      defaultValue: Reasons.None,
    );

/// Returns the media type of the given [media] as integer.
MediaType getMediaTypeFromInt(int media) => getFromEnum(
      value: media,
      validValues: MediaType.values,
      defaultValue: MediaType.Unknown,
    );

T getFromEnum<T>({
  required int value,
  required List<T> validValues,
  required T defaultValue,
}) {
  if (value.isValidIndexOf(validValues)) {
    return validValues[value];
  } else {
    return defaultValue;
  }
}
