/// The model containing all semesters information.
class AllSemesters {
  /// The plan ID of all the semesters.
  String planId;

  /// The global average.
  double average;

  /// The semesters.
  List<Semester> semesters;

  /// The AllSemesters constructor.
  AllSemesters({
    required this.planId,
    required this.average,
    required this.semesters,
  });
}

/// The semester model.
class Semester {
  /// The semester name.
  String name;

  /// The order of the semester.
  int order;

  /// The average of the semester.
  double average;

  /// The plan ID of the semester.
  String planId;

  /// The semeter subjects.
  List<Subject> subjects;

  /// The Semester constructor.
  Semester({
    required this.name,
    required this.order,
    required this.average,
    required this.planId,
    required this.subjects,
  });
}

/// The subject model.
class Subject {
  /// The subject name.
  String name;

  /// The subject score.
  double score;

  /// If the score of the subject is from extraordinary exam.
  bool isExtra;

  /// The subject credits.
  int credits;

  /// The teacher of the subject.
  SubjectTeacher teacher;

  /// The extra information of the subject.
  SubjectExtras extras;

  /// The Subject constructor.
  Subject({
    required this.name,
    required this.score,
    required this.isExtra,
    required this.credits,
    required this.teacher,
    required this.extras,
  });
}

/// The subject teacher model.
class SubjectTeacher {
  /// The teacher name.
  String name;

  /// The SubjectTeacher constructor.
  SubjectTeacher({required this.name});
}

/// The subject extras model.
class SubjectExtras {
  /// The load ID of the subject.
  String loadId;

  /// The subject type... idk.
  String type;

  /// The semester of the subject.
  int semester;

  /// The SubjectExtras constructor.
  SubjectExtras({
    required this.loadId,
    required this.type,
    required this.semester,
  });
}
