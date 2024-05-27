import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skin_disease_backup/features/home/data/model/student_detail_model.dart';
import 'package:skin_disease_backup/features/home/domain/usecase/student_detail/student_detail_usecase.dart';
import 'package:skin_disease_backup/features/home/presentation/provider/home_state.dart';

import '../../../../core/errors/failure.dart';

class HomeNotifier extends StateNotifier<HomeState> {
  final StudentDetailUseCase _studentDetailUseCase;
  HomeNotifier(this._studentDetailUseCase) : super(const HomeState.initial());
  Future<Either<Failure, StudentDetailModel>> getStudentDetail() async {
    state.copyWith(isLoading: true);
    final result = await _studentDetailUseCase();
    state.copyWith(isLoading: false);
    return result;
  }
}
