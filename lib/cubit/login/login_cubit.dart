// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:fic4_flutter_auth_bloc/data/datasources/auth_datasources.dart';
import 'package:fic4_flutter_auth_bloc/data/models/request/login_model.dart';

import '../../data/localsources/auth_local_storage.dart';
import '../../data/models/response/login/login_response_model.dart';

part 'login_cubit.freezed.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthDatasource data;
  LoginCubit(
    this.data,
  ) : super(const _initial());
  void login(LoginModel model) async {
    emit(const _loading());
    final result = await data.login(model);
    result.fold((error) {
      emit(_error(error));
    }, (r) async {
      await AuthLocalStorage().saveToken(r.accessToken);
      emit(_loaded(r));
    });
  }
}
