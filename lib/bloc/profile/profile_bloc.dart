// ignore_for_file: depend_on_referenced_packages

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import 'package:fic4_flutter_auth_bloc/data/datasources/auth_datasources.dart';
import 'package:fic4_flutter_auth_bloc/data/models/response/profile/profile_response_model.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  
  ProfileBloc(
 
  ) : super(ProfileInitial()) {
    on<GetProfileEvent>((event, emit) async {
      // try {
      //   emit(ProfileLoading());
      //   final result = await authDatasource.getProfile();
      //   emit(ProfileLoaded(profile: result));
      // } catch (e) {
      //   emit(ProfileError(message: 'network problem: ${e.toString()}'));
      // }
      emit(ProfileLoading());
      try {
        final result = await AuthDatasource.getProfile();
        emit(ProfileLoaded(profile: result));
      } catch (e) {
        emit(ProfileError(message: 'network problem: ${e.toString()}'));
      }
    });
  }
}
