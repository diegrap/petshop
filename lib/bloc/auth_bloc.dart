import 'package:flutter_bloc/flutter_bloc.dart';
import '../provider/firebase_auth.dart';
import '../model/user_model.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuthenticationService _authenticationService =
      FirebaseAuthenticationService();

  AuthBloc() : super(Unauthenticated()) {
    on<AuthServerEvent>((event, emit) {
      if (event.userModel == null) {
        emit(Unauthenticated());
      } else {
        // FirestoreDatabase.helper.uid = event.userModel!.uid;
        emit(Authenticated(userModel: event.userModel!));
      }
    });

    on<RegisterUser>((event, emit) async {
      try {
        await _authenticationService.createUserWithEmailAndPassword(
          event.email,
          event.password,
          event.name,
        );
        emit(RegistrationSuccess(message: "Cadastro realizado com sucesso!"));
      } catch (e) {
        emit(AuthError(message: "Impossível Registrar: ${e.toString()}"));
      }
    });

    on<LoginUser>((event, emit) async {
      try {
        await _authenticationService.signInWithEmailAndPassword(
            event.email, event.password);
        emit(Unauthenticated());
      } catch (e) {
        emit(AuthError(
            message: "Impossível Logar com ${event.email}: ${e.toString()}"));
      }
    });

    on<Logout>((event, emit) async {
      try {
        await _authenticationService.signOut();
        emit(Unauthenticated());
      } catch (e) {
        emit(AuthError(message: "Impossível Efetuar Logout: ${e.toString()}"));
      }
    });
  }
}

// Eventos
abstract class AuthEvent {}

class RegisterUser extends AuthEvent {
  String name;
  String email;
  String password;

  RegisterUser(
      {required this.name, required this.email, required this.password});
}

class LoginUser extends AuthEvent {
  String email;
  String password;

  LoginUser({required this.email, required this.password});
}

class LoginAnonymousUser extends AuthEvent {}

class Logout extends AuthEvent {}

class AuthServerEvent extends AuthEvent {
  final UserModel? userModel;
  AuthServerEvent(this.userModel);
}

// Estados
abstract class AuthState {}

class Unauthenticated extends AuthState {}

class RegistrationSuccess extends AuthState {
  final String message;
  RegistrationSuccess({required this.message});
}

class Authenticated extends AuthState {
  final UserModel userModel;
  Authenticated({required this.userModel});
}

class AuthError extends AuthState {
  final String message;

  AuthError({required this.message});
}
