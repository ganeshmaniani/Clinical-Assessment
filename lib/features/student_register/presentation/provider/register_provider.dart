import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skin_disease_backup/features/student_register/domain/usecase/register/register_usecase_provider.dart';
import 'package:skin_disease_backup/features/student_register/presentation/provider/register_notifier.dart';
import 'package:skin_disease_backup/features/student_register/presentation/provider/register_state.dart';

final registerProvider =
    StateNotifierProvider<RegisterNotifier, RegisterState>((ref) {
  final usecaseRegister = ref.watch(registerUseCaseProvider);
  return RegisterNotifier(usecaseRegister);
});
