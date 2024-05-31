import 'dart:developer';

import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../../../features.dart';

class DiseaseDetailSourceImpl implements DiseaseDeatailSource {
  final BaseCRUDDataBaseServices baseCRUDDataBaseServices;
  DiseaseDetailSourceImpl(this.baseCRUDDataBaseServices);
  @override
  Future<Either<Failure, List<DiseaseDetailModel>>> getDiseaseDetail(
      int id) async {
    try {
      List<Map<String, dynamic>> response = await baseCRUDDataBaseServices
          .getDataById(DBKeys.dbDiseaseTable, id, DBKeys.dbStudentId);
      log("DiseaseDetail:${response.toString()}");
      if (response.isNotEmpty) {
        List<DiseaseDetailModel> diseaseDetail =
            response.map((data) => DiseaseDetailModel.fromJson(data)).toList();
        return Right(diseaseDetail);
      } else {
        return const Left(Failure("Disease detail Not Found"));
      }
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
