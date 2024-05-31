import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../features.dart';

final homeRepositoryProvider = Provider<HomeRepository>((ref) {
  final remoteDataSource = ref.watch(homeSourceProvider);
  return HomeRepositoryImpl(remoteDataSource);
});
