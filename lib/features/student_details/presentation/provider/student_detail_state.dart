import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class StudentDetailState extends Equatable {
  final bool isLoading;
  const StudentDetailState({required this.isLoading});
  const StudentDetailState.initial({
    this.isLoading = false,
  });

  @override
  List<Object?> get props => [isLoading];
  @override
  bool get stringify => true;
  StudentDetailState copyWith({bool? isLoading}) {
    return StudentDetailState(isLoading: isLoading ?? this.isLoading);
  }
}
