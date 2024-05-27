import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skin_disease_backup/features/home/data/repository/home_repository_impl.dart';
import 'package:skin_disease_backup/features/home/data/source/home_source_provider.dart';
import 'package:skin_disease_backup/features/home/domain/repository/home_repository.dart';

final homeRepositoryProvider = Provider<HomeRepository>((ref) {
  final remoteDataSource = ref.watch(homeSourceProvider);
  return HomeRepositoryImpl(remoteDataSource);
});
