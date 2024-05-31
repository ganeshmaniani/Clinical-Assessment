import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/sql_service/sql_service_provider.dart';
import '../../../features.dart';

final diseaseDetailSourceProvider = Provider<DiseaseDeatailSource>((ref) {
  final apiService = ref.watch(serviceProvider);
  return DiseaseDetailSourceImpl(apiService);
});
