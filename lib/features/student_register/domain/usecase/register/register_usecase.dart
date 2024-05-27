import 'package:dartz/dartz.dart';
import 'package:skin_disease_backup/core/errors/failure.dart';
import 'package:skin_disease_backup/core/usecase/common_usecase.dart';
import 'package:skin_disease_backup/features/student_register/domain/entities/register_entities.dart';
import 'package:skin_disease_backup/features/student_register/domain/repository/register_repository.dart';

import '../../../data/model/auth_result.dart';

class RegisterUseCase implements UseCase<void, RegisterEntities> {
  final RegisterRepository _registerRepository;
  RegisterUseCase(this._registerRepository);

  @override
  Future<Either<Failure, AuthResult>> call(
      RegisterEntities registerEntities) async {
    return await _registerRepository.register(registerEntities);
  }
}
