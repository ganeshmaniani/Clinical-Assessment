import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skin_disease_backup/features/home/domain/usecase/student_detail/student_detail_usecase_provider.dart';
import 'package:skin_disease_backup/features/home/presentation/provider/home_notifier.dart';
import 'package:skin_disease_backup/features/home/presentation/provider/home_state.dart';

final homeProvider = StateNotifierProvider<HomeNotifier, HomeState>((ref) {
  final useCaseStudentDetail = ref.watch(studentDetailUseCaseProvider);
  return HomeNotifier(useCaseStudentDetail);
});
