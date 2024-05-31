import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skin_disease_backup/features/features.dart';

final studentListUseCaseProvider = Provider<StudentListUseCase>((ref) {
  final studentDetailRepository = ref.watch(studentDetailRepositoryProvider);
  return StudentListUseCase(studentDetailRepository);
});
