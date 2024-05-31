import 'package:dartz/dartz.dart';

import '../../../../../core/core.dart';
import '../../../../features.dart';

class UpdateDiseaseUseCase implements UseCase<dynamic, DiseaseUpdateEntities> {
  final HomeRepository homeRepository;

  UpdateDiseaseUseCase(this.homeRepository);

  @override
  Future<Either<Failure, dynamic>> call(
      DiseaseUpdateEntities diseaseUpdateEntities) async {
    return await homeRepository.updateDisease(diseaseUpdateEntities);
  }
}
