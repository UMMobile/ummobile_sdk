import 'package:ummobile_sdk/src/models/user/employee.dart';
import 'package:ummobile_sdk/src/models/user/student.dart';
import 'package:ummobile_sdk/src/types/role.dart';

/// The user mode.
class User {
  /// The id user.
  int id;

  /// The name of the user.
  String name;

  /// The surnames of the user.
  String surnames;

  /// The extra information about the user.
  UserExtras extras;

  /// The profile picture.
  String? image;

  /// The extra student information about the user. This field whill be `null` if the user is not a student.
  StudentExtras? student;

  /// The extra employee information about the user. This field whill be `null` if the user is not a employee.
  EmployeeExtras? employee;

  /// The user role.
  Roles role;

  /// Returns `true` if the user is a student.
  bool get isStudent => this.role == Roles.Student;

  /// Returns `true` if the user is a employee.
  bool get isEmployee => this.role == Roles.Employee;

  /// The User constructor.
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

/// The user extra information model.
class UserExtras {
  /// The user email.
  String email;

  /// The user phone number.
  String phone;

  /// The user CURP.
  String curp;

  /// The marital status of the user.
  String maritalStatus;

  /// The user birthday.
  DateTime birthday;

  /// The UserExtras constructor.
  UserExtras({
    required this.email,
    required this.phone,
    required this.curp,
    required this.maritalStatus,
    required this.birthday,
  });
}
