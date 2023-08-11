import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../models/user_model.dart';
@immutable
abstract class UserState extends Equatable{}

//data loading state
class UserLoadingState extends UserState{
  @override
  List<Object?> get props => [];
}

//data loded stata
class UserLoadedState extends UserState{
  UserLoadedState(this.users);
  final List<UserModel> users;

  @override
  List<Object?> get props => [users];

}

//data error loading state

class UserErrorLoadingState extends UserState{
UserErrorLoadingState(this.error);
final String error;

  @override
  List<Object?> get props => [error];

}

