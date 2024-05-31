import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../features.dart';

 
final registerEditUseCaseProvider = Provider<RegisterEditUseCase>((ref) {
  final authRepository = ref.watch(registerRepositoryProvider);
  return RegisterEditUseCase(authRepository);
});
