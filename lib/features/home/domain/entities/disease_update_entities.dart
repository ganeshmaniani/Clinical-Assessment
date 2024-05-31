  import 'package:equatable/equatable.dart';

  class DiseaseUpdateEntities extends Equatable {
    final int id;
    final String diseaseName;
    final int diseaseScore;

    const DiseaseUpdateEntities(
        {required this.id,
        required this.diseaseName,
        required this.diseaseScore});

    @override
    List<Object?> get props => [id, diseaseName, diseaseScore];

    @override
    bool get stringify => true;

    DiseaseUpdateEntities copyWith({
      final int? id,
      final String? diseaseName,
      final int? diseaseScore,
    }) {
      return DiseaseUpdateEntities(
        id: id ?? this.id,
        diseaseName: diseaseName ?? this.diseaseName,
        diseaseScore: diseaseScore ?? this.id,
      );
    }
  }
