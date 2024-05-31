import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../../../features.dart';

abstract class DiseaseRepository {
  Future<Either<Failure, List<DiseaseDetailModel>>> getDiseaseDetail(int id);
}
