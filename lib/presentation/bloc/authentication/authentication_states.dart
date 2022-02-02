part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState({
    this.userName = '',
    this.password = '',
  });

  final String userName;
  final String password;

  @override
  List<Object> get props => [
        userName,
        password,
      ];
}

class NotLogged extends AuthenticationState {
  const NotLogged({
    String userName = '',
    String password = '',
  }) : super(userName: userName, password: password);
}

class Logging extends AuthenticationState {
  const Logging({
    String userName = '',
    String password = '',
  }) : super(userName: userName, password: password);
}

class Logged extends AuthenticationState {
  const Logged({required this.account});

  final Account account;

  @override
  List<Object> get props => [
        account,
      ];
}

class InvalidCredentials extends AuthenticationState {
  const InvalidCredentials({
    required String userName,
    required String password,
  }) : super(
          userName: userName,
          password: password,
        );
}
