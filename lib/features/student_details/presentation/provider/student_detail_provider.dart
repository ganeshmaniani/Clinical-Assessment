import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../features.dart';

final studentDetailProvider =
    StateNotifierProvider<StudentDetailNotifier, StudentDetailState>((ref) {
  final useCaseStudentList = ref.watch(studentListUseCaseProvider);
  final useCaseSingleStudentDetail =
      ref.watch(singleStudentDetailUseCaseProvider);
  final useCaseStudentDelete = ref.watch(deleteStudentUseCaseProvider);
  return StudentDetailNotifier(
      useCaseStudentList, useCaseSingleStudentDetail, useCaseStudentDelete);
});
