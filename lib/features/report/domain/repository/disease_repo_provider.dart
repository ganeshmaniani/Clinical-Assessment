import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../features.dart';
 
final diseaseRepoProvider = Provider<DiseaseRepository>((ref) {
  final remoteDataSource = ref.watch(diseaseDetailSourceProvider);
  return DiseaseRepositoryImpl(remoteDataSource);
});
