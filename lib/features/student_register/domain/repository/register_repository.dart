import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../data/model/auth_result.dart';
import '../entities/register_entities.dart';

abstract class RegisterRepository {
  Future<Either<Failure, AuthResult>> register(
      RegisterEntities registerEntities);
}
