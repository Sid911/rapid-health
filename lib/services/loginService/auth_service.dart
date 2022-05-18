import 'package:rapid_health/services/loginService/user_data.dart';

/// Abstract class used as an interface for different login service implementations
abstract class AuthService {
  bool? get isUserDoctor;
  bool get isAuthenticated;
  Future<LoginError> loginUserWithEmailPassword({
    required String email,
    required String password,
  });
  Future<LoginError> registerUserWithEmailPassword(UserData data);
  Future<LoginError> loginDoctorWithEmailPassword({
    required String email,
    required String password,
  });
  Future<LoginError> registerDoctor(DoctorData data);
  void logout();
}

enum LoginError {
  success,
  notFound,
  incorrectCredential,
  unknown,
}
