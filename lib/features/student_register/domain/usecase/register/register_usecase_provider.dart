import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skin_disease_backup/features/student_register/domain/repository/register_repository_provider.dart';
import 'package:skin_disease_backup/features/student_register/domain/usecase/register/register_usecase.dart';

final registerUseCaseProvider = Provider<RegisterUseCase>((ref) {
  final registerRepository = ref.watch(registerRepositoryProvider);
  return RegisterUseCase(registerRepository);
});
