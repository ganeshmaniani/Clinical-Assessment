import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../features.dart';

final studentDetailRepositoryProvider =
    Provider<StudentDetailRepository>((ref) {
  final remoteDataSource = ref.watch(studentDetailSourceProvider);
  return StudentDetailRepositoryImpl(remoteDataSource);
});
