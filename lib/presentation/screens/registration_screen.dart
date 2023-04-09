import 'package:comprei/presentation/bloc/inputs/password_field.dart';
import 'package:comprei/presentation/bloc/inputs/text_field.dart';
import 'package:comprei/presentation/bloc/registration/registration_bloc.dart';
import 'package:comprei/widgets/inputs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

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
        BlocProvider<DirectoryPickerCubit>(
          create: (context) => DirectoryPickerCubit(),
        ),
      ],
      child: BlocBuilder<RegistrationBloc, RegistrationState>(
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text(AppLocalizations.of(context)!.registrationScreenTitle),
            centerTitle: true,
          ),
          body: (state is CreatedAccount)
              ? _registrationCompleteScreen(context, state)
              : _registrationForm(context, state),
        ),
      ),
    );
  }

  Widget _registrationForm(context, state) => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(36.0),
          child: Column(
            children: [
              BlocProvider.value(
                value: BlocProvider.of<ITextFieldCubit>(context),
                child: TextInputField(
                  hintText: AppLocalizations.of(context)!.userName,
                  errorText:
                      (state is InvalidRegistration && !state.isValidUserName)
                          ? AppLocalizations.of(context)!.invalidUsername
                          : null,
                ),
              ),
              const SizedBox(height: 25.0),
              BlocProvider.value(
                value: BlocProvider.of<PasswordFieldCubit>(context),
                child: PasswordField(
                  errorText:
                      (state is InvalidRegistration && !state.isValidPassword)
                          ? AppLocalizations.of(context)!.invalidPassword
                          : null,
                ),
              ),
              const SizedBox(height: 25.0),
              BlocProvider.value(
                value: BlocProvider.of<DirectoryPickerCubit>(context),
                child: DirectoryPickerButton(
                  label: AppLocalizations.of(context)!.databaseDirectory,
                ),
              ),
              const SizedBox(height: 35.0),
              ActionButton(
                enabled: state is! RequestRegistration,
                isLoading: state is RequestRegistration,
                onPressed: () => BlocProvider.of<RegistrationBloc>(context)
                    .add(CreateAccountEvent(
                  userName: BlocProvider.of<ITextFieldCubit>(context).state,
                  password:
                      BlocProvider.of<PasswordFieldCubit>(context).state.value,
                  databasePath:
                      BlocProvider.of<DirectoryPickerCubit>(context).state,
                )),
                text: AppLocalizations.of(context)!.registerButton,
              )
            ],
          ),
        ),
      );

  Widget _registrationCompleteScreen(context, state) => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(36.0),
          child: Column(
            children: [
              Text(AppLocalizations.of(context)!.accountCreatedSuccessfully),
              const SizedBox(height: 35.0),
              ActionButton(
                onPressed: () => Navigator.pop(context),
                text: AppLocalizations.of(context)!.okButton,
              )
            ],
          ),
        ),
      );
}
