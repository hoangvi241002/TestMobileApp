import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app_test/view_models/home_bloc.dart';
import 'package:mobile_app_test/view_models/login_bloc.dart';
import 'package:mobile_app_test/views/home_screen.dart';
import 'package:mobile_app_test/views/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<LoginBloc>(create: (context) => LoginBloc()),
          BlocProvider<HomeBloc>(create: (context) => HomeBloc()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Flutter Demo",
          theme: ThemeData(primarySwatch: Colors.blue),
          home: const LoginScreen(),
          routes: {
            '/home': (context) => const HomeScreen(),
          },
        )
    );
  }
}
