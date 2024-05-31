import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skin_disease_backup/core/sql_service/sql_service_provider.dart';

import '../../../features.dart';

final studentDetailSourceProvider = Provider<StudentDetailSource>((ref) {
  final apiService = ref.watch(serviceProvider);
  return StudentDetailSourceImpl(apiService);
});
