import 'package:rapid_health/services/loginService/user_data.dart';

import './login_service.dart';

/// [LocalLoginService] is a mock [LoginService] implementation which stores data locally about the users.
///
///
class LocalLoginService extends LoginService {
  @override
  LoginError loginDoctorWithEmailPassword(
      {required String email, required String password}) {
    // TODO: implement loginDoctorWithEmailPassword
    throw UnimplementedError();
  }

  @override
  LoginError loginUserWithEmailPassword(
      {required String email, required String password}) {
    // TODO: implement loginUserWithEmailPassword
    throw UnimplementedError();
  }

  @override
  void logout() {
    // TODO: implement logout
  }

  @override
  LoginError registerDoctor(DoctorData data) {
    // TODO: implement registerDoctor
    throw UnimplementedError();
  }

  @override
  LoginError registerUserWithEmailPassword(UserData data) {
    // TODO: implement registerUserWithEmailPassword
    throw UnimplementedError();
  }
}
