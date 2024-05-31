import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../features.dart';

final deleteStudentUseCaseProvider = Provider<StudentDeleteUseCase>((ref) {
  final authRepository = ref.watch(homeRepositoryProvider);
  return StudentDeleteUseCase(authRepository);
});
