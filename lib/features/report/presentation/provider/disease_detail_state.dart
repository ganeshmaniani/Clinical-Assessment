import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class DiseaseDetailState extends Equatable {
  final bool isLoading;
  const DiseaseDetailState({required this.isLoading});
  const DiseaseDetailState.initial({
    this.isLoading = false,
  });

  @override
  List<Object?> get props => [isLoading];
  @override
  bool get stringify => true;
  DiseaseDetailState copyWith({bool? isLoading}) {
    return DiseaseDetailState(isLoading: isLoading ?? this.isLoading);
  }
}
