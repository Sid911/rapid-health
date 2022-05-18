import 'package:equatable/equatable.dart';

abstract class LoginUIState extends Equatable {
  const LoginUIState(
    this.email,
    this.password,
    this.userIsDoctor,
    this.isAnimating,
  );

  final String email;
  final String password;
  final bool userIsDoctor;
  final bool isAnimating;
}

class LoginUITransition extends LoginUIState {
  const LoginUITransition(
    super.email,
    super.password,
    super.userIsDoctor,
    super.isAnimating,
  );

  @override
  List<Object?> get props => [email, password, userIsDoctor, isAnimating];
}

class LoginUILoaded extends LoginUIState {
  const LoginUILoaded(
    super.email,
    super.password,
    super.userIsDoctor,
    super.isAnimating,
  );

  @override
  List<Object?> get props => [email, password, userIsDoctor, isAnimating];
}
