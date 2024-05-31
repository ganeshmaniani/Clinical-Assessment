import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/core.dart';
import '../../../features.dart';

class StudentDetailNotifier extends StateNotifier<StudentDetailState> {
  final StudentListUseCase _studentListUseCase;
  final SingleStudentDetailUseCase _singleStudentDetailUseCase;
  final StudentDeleteUseCase _studentDeleteUseCase;

  StudentDetailNotifier(this._studentListUseCase,
      this._singleStudentDetailUseCase, this._studentDeleteUseCase)
      : super(const StudentDetailState.initial());
  Future<Either<Failure, List<StudentDetailModel>>> getStudentList() async {
    state.copyWith(isLoading: true);
    final result = await _studentListUseCase();
    state.copyWith(isLoading: false);
    return result;
  }

  Future<Either<Failure, StudentDetailModel>> getSingleStudentDetail(
      int id) async {
    state.copyWith(isLoading: true);
    final result = await _singleStudentDetailUseCase(id);
    state.copyWith(isLoading: false);
    return result;
  }

  Future<Either<Failure, void>> studentDelete(int id) async {
    state.copyWith(isLoading: true);
    final result = await _studentDeleteUseCase(id);
    state.copyWith(isLoading: false);
    return result;
  }
}
