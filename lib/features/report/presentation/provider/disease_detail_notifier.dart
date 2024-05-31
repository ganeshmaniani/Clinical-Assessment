import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/core.dart';
import '../../../features.dart';

class DiseaseDetailNotifier extends StateNotifier<DiseaseDetailState> {
  final DiseaseDetailUseCase _diseaseDetailUseCase;

  DiseaseDetailNotifier(this._diseaseDetailUseCase)
      : super(const DiseaseDetailState.initial());

  Future<Either<Failure, List<DiseaseDetailModel>>> getDiseaseDetail(
      int id) async {
    state.copyWith(isLoading: true);
    final result = await _diseaseDetailUseCase(id);
    state.copyWith(isLoading: false);
    return result;
  }
}
