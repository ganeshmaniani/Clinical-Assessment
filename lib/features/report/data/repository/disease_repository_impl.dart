import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../../../features.dart';

class DiseaseRepositoryImpl implements DiseaseRepository {
  final DiseaseDeatailSource diseaseDeatailSource;
  DiseaseRepositoryImpl(this.diseaseDeatailSource);
  @override
  Future<Either<Failure, List<DiseaseDetailModel>>> getDiseaseDetail(
      int id) async {
    return await diseaseDeatailSource.getDiseaseDetail(id);
  }
}
