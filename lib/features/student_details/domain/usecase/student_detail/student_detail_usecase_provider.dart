import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../features.dart';

final singleStudentDetailUseCaseProvider =
    Provider<SingleStudentDetailUseCase>((ref) {
  final studentDetailRepository = ref.watch(studentDetailRepositoryProvider);
  return SingleStudentDetailUseCase(studentDetailRepository);
});
