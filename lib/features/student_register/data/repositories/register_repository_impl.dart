import 'package:dartz/dartz.dart';
import 'package:skin_disease_backup/core/errors/failure.dart';
import 'package:skin_disease_backup/features/student_register/data/model/auth_result.dart';
import 'package:skin_disease_backup/features/student_register/data/source/register_source.dart';
import 'package:skin_disease_backup/features/student_register/domain/entities/register_entities.dart';
import 'package:skin_disease_backup/features/student_register/domain/repository/register_repository.dart';

class RegisterRepositoryImpl implements RegisterRepository {
  final RegisterSource registerSource;
  RegisterRepositoryImpl(this.registerSource);
  @override
  Future<Either<Failure, AuthResult>> register(
      RegisterEntities registerEntities) async {
    return await registerSource.register(registerEntities);
  }
}
