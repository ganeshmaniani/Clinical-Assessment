import 'dart:typed_data';

import 'package:equatable/equatable.dart';

class DiseaseEntities extends Equatable {
  final String diseaseName;
  final int diseaseScore;
  final Uint8List? diseaseImage;
  const DiseaseEntities({
    required this.diseaseName,
    required this.diseaseScore,
    this.diseaseImage,
  });
  @override
  List<Object?> get props => [diseaseName, diseaseScore, diseaseImage];
  @override
  bool get stringify => true;
  DiseaseEntities copyWith({
    String? diseaseName,
    int? diseaseScore,
    Uint8List? diseaseImage,
  }) {
    return DiseaseEntities(
      diseaseName: diseaseName ?? this.diseaseName,
      diseaseScore: diseaseScore ?? this.diseaseScore,
      diseaseImage: diseaseImage ?? this.diseaseImage,
    );
  }
}
