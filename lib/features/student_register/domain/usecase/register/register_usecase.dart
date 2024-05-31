import 'package:dartz/dartz.dart';

import '../../../../../core/core.dart';
import '../../../../features.dart';

class RegisterUseCase implements UseCase<void, RegisterEntities> {
  final RegisterRepository _registerRepository;
  RegisterUseCase(this._registerRepository);

  @override
  Future<Either<Failure, AuthResult>> call(
      RegisterEntities registerEntities) async {
    return await _registerRepository.register(registerEntities);
  }
}
