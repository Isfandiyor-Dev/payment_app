import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:payment_app/blocs/auth/auth_bloc.dart';
import 'package:payment_app/blocs/card/card_bloc.dart';
import 'package:payment_app/blocs/navigation_bar/navigation_bar_cubit.dart';
import 'package:payment_app/blocs/transfer/transfer_bloc.dart';
import 'package:payment_app/core/app.dart';
import 'package:payment_app/data/repositories/auth_repository.dart';
import 'package:payment_app/data/repositories/card_repository.dart';
import 'package:payment_app/data/repositories/transfer_repository.dart';
import 'package:payment_app/firebase_options.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_app/services/auth_service.dart';
import 'package:payment_app/services/card_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  AuthService authService = AuthService();
  CardService cardService = CardService();
  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AuthRepository(authService),
        ),
        RepositoryProvider(
          create: (context) => CardRepository(cardService: cardService),
        ),
        RepositoryProvider(
          create: (context) => TransferRepository(
            cardRepository: CardRepository(cardService: cardService),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => NavigationBarCubit(),
          ),
          BlocProvider(
            create: (context) => AuthBloc(context.read<AuthRepository>()),
          ),
          BlocProvider(
            create: (context) => CardBloc(
              cardRepository: context.read<CardRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => TransferBloc(
              transferRepository: context.read<TransferRepository>(),
            ),
          ),
        ],
        child: const MainApp(),
      ),
    ),
  );
}
