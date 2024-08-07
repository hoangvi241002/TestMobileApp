import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

class LoginBloc extends Cubit<LoginState> {
  LoginBloc() : super(LoginInitial());

  Future<void> login(String email, String password) async {
    emit(LoginLoading());

    try {
      final String response = await rootBundle.loadString('assets/user_data.json');
      final data = await json.decode(response) as List;
      final List<User> users = data.map((json) => User.fromJson(json)).toList();

      final User? user = users.firstWhere(
            (user) => user.email == email && user.password == password,
        orElse: () => User(email: '', password: ''),
      );

      if (user != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
        emit(LoginSuccess());
      } else {
        emit(LoginFailure('Invalid email or password'));
      }
    } catch (e) {
      emit(LoginFailure('Error occurred: $e'));
    }
  }

  Future<void> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedIn) {
      emit(LoginSuccess());
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    emit(LoginInitial());
  }
}

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginFailure extends LoginState {
  final String message;

  LoginFailure(this.message);
}