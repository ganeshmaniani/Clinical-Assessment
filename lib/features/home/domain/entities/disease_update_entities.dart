import 'dart:typed_data';

import 'package:equatable/equatable.dart';

class DiseaseUpdateEntities extends Equatable {
  final int id;
  final String diseaseName;
  final int diseaseScore;
  final Uint8List? diseaseImage;

  const DiseaseUpdateEntities({
    required this.id,
    required this.diseaseName,
    required this.diseaseScore,
    this.diseaseImage,
  });

  @override
  List<Object?> get props => [id, diseaseName, diseaseScore, diseaseImage];

  @override
  bool get stringify => true;

  DiseaseUpdateEntities copyWith({
    final int? id,
    final String? diseaseName,
    final int? diseaseScore,
    Uint8List? diseaseImage,
  }) {
    return DiseaseUpdateEntities(
      id: id ?? this.id,
      diseaseName: diseaseName ?? this.diseaseName,
      diseaseScore: diseaseScore ?? this.id,
      diseaseImage: diseaseImage ?? this.diseaseImage,
    );
  }
}
