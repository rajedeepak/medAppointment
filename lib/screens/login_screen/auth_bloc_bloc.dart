import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class AuthBlocBloc extends Bloc<AuthBlocEvent, AuthBlocState> {
  @override
  AuthBlocState get initialState => InitialAuthBlocState();

  @override
  Stream<AuthBlocState> mapEventToState(
    AuthBlocEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
