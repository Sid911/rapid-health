import 'package:rapid_health/services/loginService/user_data.dart';
import 'package:rapid_health/utility/local_server.dart';

import './auth_service.dart';

/// [LocalAuthService] is a mock [AuthService] implementation which stores data locally about the users.
/// Using hive as its key pair database
///
///
class LocalAuthService extends AuthService {
  bool? _isDoc;
  bool _auth = false;
  @override
  Future<LoginError> loginDoctorWithEmailPassword(
      {required String email, required String password}) {
    // TODO: implement loginDoctorWithEmailPassword
    throw UnimplementedError();
  }

  @override
  Future<LoginError> loginUserWithEmailPassword({
    required String email,
    required String password,
  }) async {
    final result = LocalServer.loginPatient(email, password);
    if (result == LoginError.success) _auth = true;
    return result;
  }

  @override
  void logout() {
    // TODO: implement logout
  }

  @override
  Future<LoginError> registerDoctor(DoctorData data) {
    // TODO: implement registerDoctor
    throw UnimplementedError();
  }

  @override
  Future<LoginError> registerUserWithEmailPassword(UserData data) {
    // TODO: implement registerUserWithEmailPassword
    throw UnimplementedError();
  }

  @override
  bool? get isUserDoctor => _isDoc;

  @override
  bool get isAuthenticated => _auth;
}
