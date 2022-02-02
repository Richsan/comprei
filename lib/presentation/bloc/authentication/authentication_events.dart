part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class RequestLoginEvent extends AuthenticationEvent {
  RequestLoginEvent();
}

class ChangeParameterEvent extends AuthenticationEvent {
  ChangeParameterEvent({
    required this.userName,
    required this.password,
  });

  final String userName;
  final String password;

  @override
  List<Object> get props => [
        userName,
        password,
      ];
}

class LoginEvent extends AuthenticationEvent {
  LoginEvent({
    required this.userName,
    required this.password,
  });

  final String userName;
  final String password;

  @override
  List<Object> get props => [
        userName,
        password,
      ];
}
