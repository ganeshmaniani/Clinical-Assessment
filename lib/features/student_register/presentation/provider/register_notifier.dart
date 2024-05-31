import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/core.dart';
import '../../../features.dart';
 
class RegisterNotifier extends StateNotifier<RegisterState> {
  final RegisterUseCase _registerUseCase;
  final RegisterEditUseCase _registerEditUseCase;
  RegisterNotifier(this._registerUseCase, this._registerEditUseCase)
      : super(const RegisterState.initial());

  Future<Either<Failure, AuthResult>> register(
      RegisterEntities registerEntities) async {
    state.copyWith(isLoading: true);
    final result = await _registerUseCase(registerEntities);
    state.copyWith(isLoading: false);
    return result;
  }
   Future<Either<Failure, AuthResult>> registerEdit(
      RegisterEditEntities registerEditEntities) async {
    state.copyWith(isLoading: true);
    final result = await _registerEditUseCase(registerEditEntities);
    state.copyWith(isLoading: false);
    return result;
  }
}
