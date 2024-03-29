import 'package:comprei/presentation/bloc/authentication/authentication_bloc.dart';
import 'package:comprei/presentation/bloc/registration/registration_bloc.dart';
import 'package:comprei/presentation/screens/insert_options_screen.dart';
import 'package:comprei/presentation/screens/login_screen.dart';
import 'package:comprei/presentation/screens/product_search_screen.dart';
import 'package:comprei/presentation/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthenticationBloc(),
      child: MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: const <Locale>[
          Locale('en'),
          Locale('pt'),
        ],
        initialRoute: '/home',
        routes: {
          // When navigating to the "/" route, build the FirstScreen widget.
          '/home': (context) =>
              BlocBuilder<AuthenticationBloc, AuthenticationState>(
                builder: (context, state) {
                  if (state is Logged) {
                    return const ProductSearchScreen();
                  }

                  //TODO: Register screen
                  //Refactor Login screen to receive functions
                  return const LoginScreen();
                },
              ),
          // When navigating to the "/second" route, build the SecondScreen widget.
          '/registration': (context) => BlocProvider(
                create: (context) => RegistrationBloc(),
                child: const RegistrationScreen(),
              ),
          '/insert-option': (context) =>
              BlocBuilder<AuthenticationBloc, AuthenticationState>(
                builder: (context, state) => state is Logged
                    ? const InsertOptionScreen()
                    : const LoginScreen(),
              ),
        },
      ),
    );
  }
}
