
part of 'login_cubit.dart';

@freezed
class LoginState with _$LoginState{
  const factory LoginState.initial()=_initial;
  const factory LoginState.loading()=_loading;
  const factory LoginState.loaded(LoginResponseModel data)=_loaded;
  const factory LoginState.error(String message)=_error;

}
