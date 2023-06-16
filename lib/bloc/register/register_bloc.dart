// ignore_for_file: depend_on_referenced_packages

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import 'package:fic4_flutter_auth_bloc/data/datasources/auth_datasources.dart';
import 'package:fic4_flutter_auth_bloc/data/models/request/register_model.dart';
import 'package:fic4_flutter_auth_bloc/data/models/response/register/register_response_model.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthDatasource datasource;
  RegisterBloc(
    this.datasource,
  ) : super(RegisterInitial()) {
    on<SaveRegisterEvent>((event, emit) async {
      emit(RegisterLoading());
      final result = await datasource.register(event.request);
      result.fold((error) {
        emit(RegisterError(msg: error));
      }, (r) {
        emit(RegisterLoaded(model: r));
      });
      //fold disini seperti fungsi if
      // emit(RegisterLoaded(model: result));
    });
  }
}
