import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/datasources/auth_datasources.dart';
import '../../data/models/response/profile/profile_response_model.dart';

part 'profile_state.dart';
part 'profile_cubit.freezed.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(const _Initial());

  void getProfile() async {
    emit(const _Loading());
    final result = await AuthDatasource.getProfile();
    result.fold((l) => {emit(_Error(l))}, (r) {
      emit(_Loaded(r));
    });
  }
}
