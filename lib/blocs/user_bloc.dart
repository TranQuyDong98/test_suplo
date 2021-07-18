import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_suplo/data/model/model.dart';
import 'package:test_suplo/data/repositories/repositories.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserRepository _userRepository = new UserRepository();
  UserBloc() : super(InitUserState());

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    if (event is GetUserEvent) {
      yield LoadingUser.fromOldState(state);
      try {
        final List<User> users = await _userRepository.getUsers();
        yield LoadSuccessUser.fromOldState(state, users: users);
      } catch (e) {
        print(e.toString());
      }
    }
  }
}

class UserEvent {}

class GetUserEvent extends UserEvent {
  GetUserEvent();
}

class UserState {
  List<User> users;

  UserState({this.users});
}

class InitUserState extends UserState {
  InitUserState() : super(users: []);
}

class LoadingUser extends UserState {
  LoadingUser.fromOldState(UserState oldSate, {List<User> users})
      : super(
          users: users ?? oldSate.users,
        );
}

class LoadSuccessUser extends UserState {
  LoadSuccessUser.fromOldState(UserState oldSate, {List<User> users})
      : super(
    users: users ?? oldSate.users,
  );
}

class LoadFailUser extends UserState {
}
