import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:payment_app/blocs/navigation_bar/navigation_bar_cubit.dart';
import 'package:payment_app/firebase_options.dart';
import 'package:payment_app/ui/auth/auth_gate/auth_gate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
      home: const AuthGate(),
    );
  }
}
