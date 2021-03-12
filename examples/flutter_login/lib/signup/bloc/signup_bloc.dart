import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_login/login/login.dart';
import 'package:formz/formz.dart';
import 'package:meta/meta.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc({
    @required AuthenticationRepository authenticationRepository,
  })  : assert(authenticationRepository != null),
        _authenticationRepository = authenticationRepository,
        super(const SignupState());

  final AuthenticationRepository _authenticationRepository;

  @override
  Stream<SignupState> mapEventToState(
    SignupEvent event,
  ) async* {
    if (event is SignupUsernameChanged) {
      yield _mapUsernameChangedToState(event, state);
    } else if (event is SignupPasswordChanged) {
      yield _mapPasswordChangedToState(event, state);
    } else if (event is SignupSubmitted) {
      yield* _mapSignupSubmittedToState(event, state);
    }
  }

  SignupState _mapUsernameChangedToState(
    SignupUsernameChanged event,
    SignupState state,
  ) {
    final username = Username.dirty(event.username);
    return state.copyWith(
      username: username,
      status: Formz.validate([state.password, username]),
    );
  }

  SignupState _mapPasswordChangedToState(
    SignupPasswordChanged event,
    SignupState state,
  ) {
    final password = Password.dirty(event.password);
    return state.copyWith(
      password: password,
      status: Formz.validate([password, state.username]),
    );
  }

  Stream<SignupState> _mapSignupSubmittedToState(
    SignupSubmitted event,
    SignupState state,
  ) async* {
    if (state.status.isValidated) {
      yield state.copyWith(status: FormzStatus.submissionInProgress);
      try {
        await _authenticationRepository.logIn(
          username: state.username.value,
          password: state.password.value,
        );
        yield state.copyWith(status: FormzStatus.submissionSuccess);
      } on Exception catch (_) {
        yield state.copyWith(status: FormzStatus.submissionFailure);
      }
    }
  }
}
