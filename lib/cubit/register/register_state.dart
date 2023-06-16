part of 'register_cubit.dart';

@freezed
class RegisterState with _$RegisterState {
  const factory RegisterState.initial() = _Initial;
  const factory RegisterState.loading() = _Loading;
  const factory RegisterState.loaded(RegisterResponseModel model) = _Loaded;
  const factory RegisterState.error(String message) = _Error;
}
