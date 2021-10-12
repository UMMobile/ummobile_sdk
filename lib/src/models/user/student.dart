import 'package:ummobile_sdk/src/types/residence.dart';

/// The extra information about the student.
class StudentExtras {
  /// If is baptized or not.
  bool baptized;

  /// The student religion.
  String religion;

  /// The type of the student.
  ///
  /// Example: "HIJO DE OBRERO".
  String type;

  /// The academic information of the student.
  Academic? academic;

  /// The scholar information of the student.
  Scholarship? scholarship;

  /// Returns `true` if the student is internal.
  bool get isInternal => this.academic != null
      ? this.academic!.residence == Residence.Internal
      : false;

  /// Returns `true` if the student is external.
  bool get isExternal => this.academic != null
      ? this.academic!.residence == Residence.External
      : false;

  /// Returns `true` if the student residence is unknown.
  bool get residenceIsUnknown => this.academic != null
      ? this.academic!.residence == Residence.Unknown
      : false;

  /// Returns `true` if the student is signed up.
  bool get isSignedUp =>
      this.academic != null ? this.academic!.signedUp : false;

  /// Returns `true` if the student have a scholarship.
  bool get isScholarshipStudent => this.scholarship != null;

  /// The StudentExtras constructor.
  StudentExtras({
    required this.baptized,
    required this.religion,
    required this.type,
    this.academic,
    this.scholarship,
  });
}

/// The academic information mdoel.
class Academic {
  /// The modality in which the student is studying.
  String modality;

  /// If the student is signed up or not.
  bool signedUp;

  /// The residence of the student. If is internal or external.
  Residence residence;

  /// The dormitory where the student live. Zero if is external.
  int dormitory;

  /// The Academic constructor.
  Academic({
    required this.modality,
    required this.signedUp,
    required this.residence,
    required this.dormitory,
  });
}

class Scholarship {
  String workplace;
  String position;
  DateTime startDate;
  DateTime endDate;
  int hours;
  String status;

  Scholarship({
    required this.workplace,
    required this.position,
    required this.startDate,
    required this.endDate,
    required this.hours,
    required this.status,
  });
}
