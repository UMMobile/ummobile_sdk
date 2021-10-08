import 'package:ummobile_api/src/models/user/employee.dart';
import 'package:ummobile_api/src/models/user/student.dart';
import 'package:ummobile_api/src/types/role.dart';

class User {
  int id;
  String name;
  String surnames;
  UserExtras extras;
  String? image;
  StudentExtras? student;
  EmployeeExtras? employee;
  Roles role;

  User({
    required this.id,
    required this.name,
    required this.surnames,
    required this.extras,
    required this.role,
    this.image,
    this.student,
    this.employee,
  });
}

class UserExtras {
  String email;
  String phone;
  String curp;
  String maritalStatus;
  DateTime birthday;

  UserExtras({
    required this.email,
    required this.phone,
    required this.curp,
    required this.maritalStatus,
    required this.birthday,
  });
}
