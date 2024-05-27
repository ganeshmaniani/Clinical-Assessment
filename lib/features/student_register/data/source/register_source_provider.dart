import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skin_disease_backup/core/sql_service/sql_service_provider.dart';
import 'package:skin_disease_backup/features/student_register/data/source/register_source.dart';
import 'package:skin_disease_backup/features/student_register/data/source/register_source_impl.dart';

final registerSourceProvider = Provider<RegisterSource>((ref) {
  final apiService = ref.watch(serviceProvider);
  return RegisterSourceImpl(apiService);
});
