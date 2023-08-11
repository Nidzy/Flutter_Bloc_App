import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_app/bloc/user_event.dart';
import 'package:flutter_bloc_app/bloc/user_state.dart';
import 'package:flutter_bloc_app/models/user_model.dart';

import '../repos/repositories.dart';

class UserBloc extends Bloc<UserEvents,UserState>{

  final UserRepositories userRepositories;

  UserBloc(this.userRepositories):super(UserLoadingState()){
    on<LoadUserEvent>((event,emit) async{
      emit(UserLoadingState());

      try {
        final users = await userRepositories.getUsers();
        emit(UserLoadedState(users));
      }
      catch (e){
      emit(UserErrorLoadingState(e.toString()));
      }
    });
  }
}