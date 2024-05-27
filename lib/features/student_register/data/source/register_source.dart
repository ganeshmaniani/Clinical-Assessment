import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../domain/entities/register_entities.dart';
import '../model/auth_result.dart';

abstract class RegisterSource {
  Future<Either<Failure, AuthResult>> register(
      RegisterEntities registerEntities);
}
