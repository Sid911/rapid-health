import 'package:bloc/bloc.dart';
import 'package:rapid_health/bloc/loginBloc/login_ui_state.dart';
import 'package:rapid_health/services/loginService/auth_service.dart';

import '../../services/loginService/auth_service.dart';

class LoginUICubit extends Cubit<LoginUIState> {
  LoginUICubit({required this.authService})
      : super(const LoginUITransition("", "", false, true));
  AuthService authService;

  @override
  void onChange(Change<LoginUIState> change) {
    super.onChange(change);
    print("Current State : \n\n"
        "Email : ${change.currentState.email}\n"
        "Password : ${change.currentState.password}\n"
        "User is doctor : ${change.currentState.userIsDoctor}\n"
        "Is animating : ${change.currentState.isAnimating}");

    print("Next State : \n\n"
        "Email : ${change.currentState.email}\n"
        "Password : ${change.currentState.password}\n"
        "User is doctor : ${change.currentState.userIsDoctor}\n"
        "Is animating : ${change.currentState.isAnimating}");
  }

  void transitionStart() {
    emit(LoginUITransition(
      state.email,
      state.password,
      state.userIsDoctor,
      true,
    ));
  }

  void transitionEnd() {
    emit(LoginUILoaded(
      state.email,
      state.password,
      state.userIsDoctor,
      false,
    ));
  }

  void setEmail(String email) {
    emit(
      LoginUILoaded(
        email,
        state.password,
        state.userIsDoctor,
        state.isAnimating,
      ),
    );
  }

  void setPassword(String password) {
    emit(
      LoginUILoaded(
        state.email,
        password,
        state.userIsDoctor,
        state.isAnimating,
      ),
    );
  }

  Future<bool> loginPatient() async {
    final result = await authService.loginUserWithEmailPassword(
      email: state.email,
      password: state.password,
    );

    if (result == LoginError.success) {
      return true;
    }

    return false;
  }
}
