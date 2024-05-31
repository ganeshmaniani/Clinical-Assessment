import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../features.dart';

final addDiseaseUseCaseProviser = Provider<AddDiseaseUseCase>((ref) {
  final authRepository = ref.watch(homeRepositoryProvider);
  return AddDiseaseUseCase(authRepository);
});
