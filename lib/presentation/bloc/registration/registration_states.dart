part of 'registration_bloc.dart';

abstract class RegistrationState extends Equatable {
  const RegistrationState({
    this.userName = '',
    this.password = '',
    this.databasePath = '',
  });

  final String userName;
  final String password;
  final String databasePath;

  @override
  List<Object> get props => [
        userName,
        password,
        databasePath,
      ];
}

class CreatingAccount extends RegistrationState {
  const CreatingAccount({
    String userName = '',
    String password = '',
    String databasePath = '',
  }) : super(
          userName: userName,
          password: password,
          databasePath: databasePath,
        );
}

class RequestRegistration extends RegistrationState {
  const RequestRegistration({
    required String userName,
    required String password,
    required String databasePath,
  }) : super(
          userName: userName,
          password: password,
          databasePath: databasePath,
        );
}

class CreatedAccount extends RegistrationState {
  const CreatedAccount({required this.account});

  final Account account;

  @override
  List<Object> get props => [
        account,
      ];
}

class InvalidRegistration extends RegistrationState {
  const InvalidRegistration({
    required String userName,
    required String password,
    required String databasePath,
    this.isValidPassword = true,
    this.isValidUserName = true,
    this.isValidDatabasePath = true,
  }) : super(
          userName: userName,
          password: password,
          databasePath: databasePath,
        );

  final bool isValidUserName;
  final bool isValidPassword;
  final bool isValidDatabasePath;

  @override
  List<Object> get props => [
        isValidUserName,
        isValidPassword,
        isValidDatabasePath,
        userName,
        password,
        databasePath,
      ];
}
