import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../features.dart';

final diseaseDetailUseCaseProvider = Provider<DiseaseDetailUseCase>((ref) {
  final diseaseRepository = ref.watch(diseaseRepoProvider);
  return DiseaseDetailUseCase(diseaseRepository);
});
