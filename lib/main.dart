import 'package:flutter/material.dart';
import 'package:payment_app/blocs/navigation_bar/navigation_bar_cubit.dart';
import 'package:payment_app/ui/auth/auth_gate/login_or_register.dart';
import 'package:payment_app/ui/auth/register/register_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NavigationBarCubit(),
        ),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.blue[200],
        appBarTheme: AppBarTheme(backgroundColor: Colors.blue[300]),
      ),
      home: const LoginOrRegister(),
    );
  }
}
