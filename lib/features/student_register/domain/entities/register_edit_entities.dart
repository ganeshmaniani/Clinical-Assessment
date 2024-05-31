import 'dart:async';
import 'dart:ui';

import 'package:equatable/equatable.dart';

class RegisterEditEntities extends Equatable {
  final String id;
  final String studentName;
  final String studentAge;
  final String studentGender;
  final String schoolName;

  const RegisterEditEntities(
      {required this.id,
      required this.studentName,
      required this.studentAge,
      required this.studentGender,
      required this.schoolName});

  @override
  List<Object?> get props {
    return [id, studentName, studentAge, studentGender, schoolName];
  }

  @override
  bool get stringify => true;

  RegisterEditEntities copyWith({
    final String? id,
    final String? studentName,
    final String? studentAge,
    final String? studentGender,
    final String? schoolName,
  }) {
    return RegisterEditEntities(
        id: id ?? this.id,
        studentName: studentName ?? this.id,
        studentAge: studentAge ?? this.studentAge,
        studentGender: studentGender ?? this.studentGender,
        schoolName: schoolName ?? this.schoolName);
  }
}
