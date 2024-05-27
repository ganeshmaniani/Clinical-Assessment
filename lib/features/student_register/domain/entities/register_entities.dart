import 'package:equatable/equatable.dart';

class RegisterEntities extends Equatable {
  final String studentName;
  final String studentAge;
  final String studentGender;
  final String schoolName;
  const RegisterEntities(
      {required this.studentName,
      required this.studentAge,
      required this.studentGender,
      required this.schoolName});

  @override
  List<Object> get props {
    return [studentName, studentAge, studentGender, schoolName];
  }

  @override
  bool get stringify => true;

  RegisterEntities copyWith({
    final String? studentName,
    final String? studentAge,
    final String? studentGender,
    final String? schoolName,
  }) {
    return RegisterEntities(
      studentName: studentName ?? this.studentName,
      studentAge: studentAge ?? this.studentAge,
      studentGender: studentGender ?? this.studentGender,
      schoolName: schoolName ?? this.schoolName,
    );
  }
}
