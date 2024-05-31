import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../../../features.dart';

class RegisterRepositoryImpl implements RegisterRepository {
  final RegisterSource registerSource;
  RegisterRepositoryImpl(this.registerSource);
  @override
  Future<Either<Failure, AuthResult>> register(
      RegisterEntities registerEntities) async {
    return await registerSource.register(registerEntities);
  }

  @override
  Future<Either<Failure, AuthResult>> registerEdit(
      RegisterEditEntities registerEditEntities) async {
    return await registerSource.registerEdit(registerEditEntities);
  }
}
