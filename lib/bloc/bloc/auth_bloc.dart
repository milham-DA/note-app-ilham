import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

enum AuthEvent { login, register, logout }

class AuthState {}

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthState());

  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    // Handle login and register events here
    if (event == AuthEvent.login) {
      // Perform login logic
      yield AuthState(); // Update state after successful login
    } else if (event == AuthEvent.register) {
      // Perform register logic
      yield AuthState(); // Update state after successful registration
    } 
  }
}
