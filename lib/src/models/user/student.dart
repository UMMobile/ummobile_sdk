import 'package:ummobile_api/src/types/residence.dart';

class StudentExtras {
  bool baptized;
  String religion;
  String type;
  Academic? academic;
  Scholarship? scholarship;

  StudentExtras({
    required this.baptized,
    required this.religion,
    required this.type,
    this.academic,
    this.scholarship,
  });
}

class Academic {
  String modality;
  bool signedUp;
  Residence residence;
  int dormitory;

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
