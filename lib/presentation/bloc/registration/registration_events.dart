part of 'registration_bloc.dart';

abstract class RegistrationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CreateAccountEvent extends RegistrationEvent {
  CreateAccountEvent({
    required this.userName,
    required this.password,
    required this.databasePath,
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

class ChangeCreationAccountParameterEvent extends RegistrationEvent {
  ChangeCreationAccountParameterEvent({
    required this.userName,
    required this.password,
    required this.databasePath,
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
