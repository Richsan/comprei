import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:comprei/components/database.dart';
import 'package:comprei/models/account.dart';
import 'package:comprei/presentation/screens/login_screen.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/uuid_util.dart';

part 'authentication_events.dart';
part 'authentication_states.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(const NotLogged()) {
    on<RequestLoginEvent>((event, emit) => emit(const NotLogged()));
    on<ChangeParameterEvent>(
      (event, emit) => emit(NotLogged(
        userName: event.userName,
        password: event.password,
      )),
    );
    on<LoginEvent>((event, emit) async {
      emit(
        Logging(
          userName: event.userName,
          password: event.password,
        ),
      );

      final usersDatabase = await getUsersDatabase();

      final user = await usersDatabase.query(
        'users',
        where: 'username = ?',
        whereArgs: [event.userName],
      ).then((value) => value.isNotEmpty ? value.first : null);

      if (user == null) {
        emit(InvalidCredentials(
            userName: event.userName, password: event.password));
        return;
      }

      try {
        final userDb = await getDatabase(
            event.userName, user['databasepath'] as String, event.password);

        print(await userDb.query('merchant'));
        emit(Logged(
            account: Account(
          userName: event.userName,
          id: user['id'] as int,
          database: userDb,
        )));
      } catch (error) {
        emit(InvalidCredentials(
            userName: event.userName, password: event.password));
      }
    });
  }
}
