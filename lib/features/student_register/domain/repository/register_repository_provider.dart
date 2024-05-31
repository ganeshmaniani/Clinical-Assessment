import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../features.dart';
 
final registerRepositoryProvider = Provider<RegisterRepository>((ref) {
  final remoteDataSource = ref.watch(registerSourceProvider);
  return RegisterRepositoryImpl(remoteDataSource);
});
