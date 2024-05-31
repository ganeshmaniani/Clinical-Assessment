import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../features.dart';

final updateDiseaseUseCaseProviser = Provider<UpdateDiseaseUseCase>((ref) {
  final repository = ref.watch(homeRepositoryProvider);
  return UpdateDiseaseUseCase(repository);
});
