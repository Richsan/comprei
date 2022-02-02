import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:comprei/presentation/bloc/authentication/authentication_bloc.dart';
import 'package:comprei/widgets/inputs.dart';
import 'package:comprei/widgets/outputs.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) => Scaffold(
        body: Center(
          child: SingleChildScrollView(
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
                    TextInputField(
                      onChanged: (value) {
                        BlocProvider.of<AuthenticationBloc>(context).add(
                          ChangeParameterEvent(
                            userName: value,
                            password: state.password,
                          ),
                        );
                      },
                      hintText: AppLocalizations.of(context)!.userName,
                    ),
                    const SizedBox(height: 25.0),
                    PasswordField(
                      onChanged: (value) {
                        BlocProvider.of<AuthenticationBloc>(context).add(
                          ChangeParameterEvent(
                            userName: state.userName,
                            password: value,
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 35.0,
                    ),
                    ActionButton(
                      text: AppLocalizations.of(context)!.loginButton,
                      enabled: state is! Logging,
                      isLoading: state is Logging,
                      onPressed: () {
                        BlocProvider.of<AuthenticationBloc>(context).add(
                          LoginEvent(
                            userName: state.userName,
                            password: state.password,
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
    );
  }
}
