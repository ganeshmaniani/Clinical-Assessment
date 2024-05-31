import 'package:dartz/dartz.dart';

import '../../../../../core/core.dart';
import '../../../../features.dart';

class RegisterEditUseCase implements UseCase<void, RegisterEditEntities> {
  final RegisterRepository _registerRepository;
  RegisterEditUseCase(this._registerRepository);
  @override
  Future<Either<Failure, AuthResult>> call(
      RegisterEditEntities registerEditEntities) async {
    return await _registerRepository.registerEdit(registerEditEntities);
  }
}
