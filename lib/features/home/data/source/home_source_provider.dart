import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skin_disease_backup/core/sql_service/sql_service_provider.dart';
import 'package:skin_disease_backup/features/home/data/source/home_source.dart';
import 'package:skin_disease_backup/features/home/data/source/home_source_impl.dart';

final homeSourceProvider = Provider<HomeSource>((ref) {
  final apiService = ref.watch(serviceProvider);
  return HomeSourceImpl(apiService);
});
