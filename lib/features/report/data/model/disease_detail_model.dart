import 'dart:typed_data';

import 'package:skin_disease_backup/core/sql_service/db_keys.dart';

class DiseaseDetailModel {
  int? id;
  String? diseaseName;
  int? diseaseScore;
  Uint8List? diseaseImage;

  DiseaseDetailModel({
    this.id,
    this.diseaseName,
    this.diseaseScore,
    this.diseaseImage,
  });
  DiseaseDetailModel.fromJson(Map<String, dynamic> json) {
    id = json[DBKeys.dbColumnId];
    diseaseName = json[DBKeys.dbDiseaseName];
    diseaseScore = json[DBKeys.dbDiseaseScore];
    diseaseImage = json[DBKeys.dbDiseaseImage];
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data[DBKeys.dbColumnId] = id;
    data[DBKeys.dbDiseaseName] = diseaseName;
    data[DBKeys.dbDiseaseScore] = diseaseScore;
    data[DBKeys.dbDiseaseImage] = diseaseImage;

    return data;
  }
}
