import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../features.dart';
 
final registerUseCaseProvider = Provider<RegisterUseCase>((ref) {
  final registerRepository = ref.watch(registerRepositoryProvider);
  return RegisterUseCase(registerRepository);
});
