// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:fic4_flutter_auth_bloc/data/datasources/auth_datasources.dart';
import 'package:fic4_flutter_auth_bloc/data/models/request/register_model.dart';

import '../../data/models/response/register/register_response_model.dart';

part 'register_cubit.freezed.dart';
part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  AuthDatasource data;
  RegisterCubit(
    this.data,
  ) : super(const _Initial());
  void register(RegisterModel model) async {
    emit(const _Loading());
    final result = await data.register(model);
    result.fold((error) {
      emit(_Error(error));
    }, (r) async {
      emit(_Loaded(r));
    });
  }
}
