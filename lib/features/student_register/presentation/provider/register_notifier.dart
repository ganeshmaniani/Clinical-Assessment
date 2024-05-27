import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/errors/failure.dart';
import '../../data/model/auth_result.dart';
import '../../domain/entities/register_entities.dart';
import '../../domain/usecase/register/register_usecase.dart';

import 'register_state.dart';

class RegisterNotifier extends StateNotifier<RegisterState> {
  final RegisterUseCase _registerUseCase;
  RegisterNotifier(this._registerUseCase)
      : super(const RegisterState.initial());

  Future<Either<Failure, AuthResult>> register(
      RegisterEntities registerEntities) async {
    state.copyWith(isLoading: true);
    final result = await _registerUseCase(registerEntities);
    state.copyWith(isLoading: false);
    return result;
  }
}
