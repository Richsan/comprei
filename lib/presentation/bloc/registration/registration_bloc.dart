import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:comprei/components/database.dart';
import 'package:comprei/models/account.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';
import 'package:uuid/uuid.dart';

part 'registration_events.dart';
part 'registration_states.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  RegistrationBloc() : super(const CreatingAccount()) {
    on<ChangeCreationAccountParameterEvent>(
        (event, emit) => emit(CreatingAccount(
              userName: event.userName,
              password: event.password,
              databasePath: event.databasePath,
            )));
    on<CreateAccountEvent>((event, emit) async {
      emit(RequestRegistration(
        userName: event.userName,
        password: event.password,
        databasePath: event.databasePath,
      ));

      final usersDb = await getUsersDatabase();

      final userId = await usersDb.insert(
        'users',
        {'username': event.userName, 'databasepath': event.databasePath},
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      final userDb =
          await getDatabase(event.userName, event.databasePath, event.password);

      await userDb.insert(
        'merchant',
        {'id': 'teste', 'name': 'carrefour'},
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      await userDb.close();

      emit(CreatedAccount(
          account: Account(
        id: userId,
        userName: event.userName,
      )));
    });
  }
}
