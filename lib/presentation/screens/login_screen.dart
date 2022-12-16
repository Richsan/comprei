import 'package:comprei/presentation/bloc/authentication/authentication_bloc.dart';
import 'package:comprei/presentation/bloc/inputs/password_field.dart';
import 'package:comprei/presentation/bloc/inputs/text_field.dart';
import 'package:comprei/widgets/inputs.dart';
import 'package:comprei/widgets/outputs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PasswordFieldCubit>(
          create: (context) => PasswordFieldCubit(),
        ),
        BlocProvider<ITextFieldCubit>(
          create: (context) => TextFieldCubit(),
        ),
      ],
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) => Scaffold(
          body: Center(
            child: SingleChildScrollView(
              reverse: true,
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(36.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 155.0,
                        child: Image.asset(
                          "assets/logo.png",
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(height: 45.0),
                      state is InvalidCredentials
                          ? TextAlert(
                              message: AppLocalizations.of(context)!
                                  .invalidCredentials)
                          : const SizedBox(
                              height: 1,
                            ),
                      BlocProvider.value(
                        value: BlocProvider.of<ITextFieldCubit>(context),
                        child: TextInputField(
                          hintText: AppLocalizations.of(context)!.userName,
                        ),
                      ),
                      const SizedBox(height: 25.0),
                      BlocProvider.value(
                          value: BlocProvider.of<PasswordFieldCubit>(context),
                          child: const PasswordField()),
                      const SizedBox(
                        height: 35.0,
                      ),
                      ActionButton(
                        text: AppLocalizations.of(context)!.loginButton,
                        enabled: state is! Logging,
                        isLoading: state is Logging,
                        onPressed: () {
                          final userName =
                              BlocProvider.of<ITextFieldCubit>(context).state;
                          final password =
                              BlocProvider.of<PasswordFieldCubit>(context)
                                  .state
                                  .value;
                          BlocProvider.of<AuthenticationBloc>(context).add(
                            LoginEvent(
                              userName: userName,
                              password: password,
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      LinkButton(
                          text: AppLocalizations.of(context)!.signInButton,
                          onTap: () =>
                              Navigator.pushNamed(context, '/registration')),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
