import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skin_disease_backup/features/student_register/data/repositories/register_repository_impl.dart';
import 'package:skin_disease_backup/features/student_register/data/source/register_source_provider.dart';
import 'package:skin_disease_backup/features/student_register/domain/repository/register_repository.dart';

final registerRepositoryProvider = Provider<RegisterRepository>((ref) {
  final remoteDataSource = ref.watch(registerSourceProvider);
  return RegisterRepositoryImpl(remoteDataSource);
});
