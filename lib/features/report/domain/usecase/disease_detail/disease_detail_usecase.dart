import 'package:dartz/dartz.dart';

import '../../../../../core/core.dart';
import '../../../../features.dart';

class DiseaseDetailUseCase {
  final DiseaseRepository diseaseRepository;
  DiseaseDetailUseCase(this.diseaseRepository);
  Future<Either<Failure, List<DiseaseDetailModel>>> call(int id) async {
    return await diseaseRepository.getDiseaseDetail(id);
  }
}
