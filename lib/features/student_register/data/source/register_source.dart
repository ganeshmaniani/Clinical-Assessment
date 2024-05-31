import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../../../features.dart';

abstract class RegisterSource {
  Future<Either<Failure, AuthResult>> register(
      RegisterEntities registerEntities);
  Future<Either<Failure, AuthResult>> registerEdit(
      RegisterEditEntities registerEditEntities);
}
