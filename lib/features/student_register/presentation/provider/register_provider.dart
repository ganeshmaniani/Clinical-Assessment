import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../features.dart';
 
final registerProvider =
    StateNotifierProvider<RegisterNotifier, RegisterState>((ref) {
  final usecaseRegister = ref.watch(registerUseCaseProvider);
  final useCaseRegisterEdit = ref.watch(registerEditUseCaseProvider);
  return RegisterNotifier(usecaseRegister,useCaseRegisterEdit);
});
