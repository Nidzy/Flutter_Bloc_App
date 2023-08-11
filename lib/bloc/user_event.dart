import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class UserEvents extends Equatable{
  const UserEvents();
}

class LoadUserEvent extends UserEvents{
  @override
  List<Object?> get props => [];

}