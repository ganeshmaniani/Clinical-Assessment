import 'package:dartz/dartz.dart';

import '../../../../../core/core.dart';
import '../../../../features.dart';

class AddDiseaseUseCase implements UseCase<dynamic, DiseaseEntities> {
  final HomeRepository homeRepository;

  AddDiseaseUseCase(this.homeRepository);

  @override
  Future<Either<Failure, dynamic>> call(DiseaseEntities diseaseEntities) async {
    return await homeRepository.addDisease(diseaseEntities);
  }
}
