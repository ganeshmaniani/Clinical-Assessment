import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../features.dart';

final   homeProvider = StateNotifierProvider<HomeNotifier, HomeState>((ref) {
  final useCaseStudentDetail = ref.watch(studentDetailUseCaseProvider);
  final useCaseDiseaseDetail = ref.watch(addDiseaseUseCaseProviser);
  final useCaseUpdateDiseaseDetail = ref.watch(updateDiseaseUseCaseProviser);
  final useCaseDeleteStudent = ref.watch(deleteStudentUseCaseProvider);
  return HomeNotifier(useCaseStudentDetail, useCaseDiseaseDetail,
      useCaseUpdateDiseaseDetail, useCaseDeleteStudent);
});
