import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../../../features.dart';

abstract class DiseaseDeatailSource {
  Future<Either<Failure, List<DiseaseDetailModel>>> getDiseaseDetail(int id);
}
