import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skin_disease_backup/features/home/data/repository/home_repository_impl.dart';
import 'package:skin_disease_backup/features/home/domain/repository/home_repository_provider.dart';
import 'package:skin_disease_backup/features/home/domain/usecase/student_detail/student_detail_usecase.dart';

final studentDetailUseCaseProvider = Provider<StudentDetailUseCase>((ref) {
  final homeRepository = ref.watch(homeRepositoryProvider);
  return StudentDetailUseCase(homeRepository);
});
