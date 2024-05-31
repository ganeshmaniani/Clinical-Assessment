import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../features.dart';

final studentDetailUseCaseProvider = Provider<StudentDetailUseCase>((ref) {
  final homeRepository = ref.watch(homeRepositoryProvider);
  return StudentDetailUseCase(homeRepository);
});
