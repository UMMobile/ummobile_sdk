import 'package:ummobile_sdk/src/models/user/employee.dart';
import 'package:ummobile_sdk/src/models/user/student.dart';
import 'package:ummobile_sdk/src/types/role.dart';

class User {
  int id;
  String name;
  String surnames;
  UserExtras extras;
  String? image;
  StudentExtras? student;
  EmployeeExtras? employee;
  Roles role;

  /// Returns `true` if the user is a student.
  bool get isStudent => this.role == Roles.Student;

  /// Returns `true` if the user is a employee.
  bool get isEmployee => this.role == Roles.Employee;

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
