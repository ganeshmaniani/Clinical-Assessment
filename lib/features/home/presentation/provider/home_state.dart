import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class HomeState extends Equatable {
  final bool isLoading;
  const HomeState({required this.isLoading});
  const HomeState.initial({
    this.isLoading = false,
  });

  @override
  List<Object?> get props => [isLoading];
  @override
  bool get stringify => true;
  HomeState copyWith({bool? isLoading}) {
    return HomeState(isLoading: isLoading ?? this.isLoading);
  }
}
