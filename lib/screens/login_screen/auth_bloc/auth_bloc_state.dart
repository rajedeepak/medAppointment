import 'package:equatable/equatable.dart';

abstract class AuthBlocState extends Equatable {
  const AuthBlocState();
}

class InitialAuthBlocState extends AuthBlocState {
  @override
  List<Object> get props => [];
}
