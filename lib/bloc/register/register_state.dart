// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'register_bloc.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterLoaded extends RegisterState {
  final RegisterResponseModel model;
  RegisterLoaded({
    required this.model,
  });
}
class RegisterError extends RegisterState {
  final String msg;
  RegisterError({
    required this.msg,
  });
}
