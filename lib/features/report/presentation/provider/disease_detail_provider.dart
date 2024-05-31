import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../features.dart';

final diseaseDetailProvider =
    StateNotifierProvider<DiseaseDetailNotifier, DiseaseDetailState>((ref) {
  final useCaseDiseaseDetail = ref.watch(diseaseDetailUseCaseProvider);

  return DiseaseDetailNotifier(useCaseDiseaseDetail);
});
