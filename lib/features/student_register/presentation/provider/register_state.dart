import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class RegisterState extends Equatable {
  final bool isLoading;

  const RegisterState({
    required this.isLoading,
  });

  const RegisterState.initial({
    this.isLoading = false,
  });

  @override
  List<Object> get props => [
        isLoading,
      ];

  @override
  bool get stringify => true;

  RegisterState copyWith({
    bool? isLoading,
  }) {
    return RegisterState(
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
