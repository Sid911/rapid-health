import 'package:rapid_health/services/loginService/user_data.dart';

/// Abstract class used as an interface for different login service implementations
abstract class LoginService {
  LoginError loginUserWithEmailPassword({
    required String email,
    required String password,
  });
  LoginError registerUserWithEmailPassword(UserData data);
  LoginError loginDoctorWithEmailPassword({
    required String email,
    required String password,
  });
  LoginError registerDoctor(DoctorData data);
  void logout();
}

enum LoginError {
  success,
  unknown,
}
