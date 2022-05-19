import 'package:rapid_health/services/loginService/user_data.dart';
import 'package:rapid_health/utility/local_server.dart';

import '../../interfaces/auth_service_interface.dart';

/// [LocalAuthService] is a mock [AuthServiceInterface] implementation which stores data locally about the users.
/// Using hive as its key pair database
///
///
class LocalAuthService extends AuthServiceInterface {
  bool? _isDoc;
  bool _auth = false;
  @override
  Future<LoginError> loginDoctorWithEmailPassword({
    required String email,
    required String password,
  }) async {
    final result = LocalServer.loginDoctor(email, password);
    if (result == LoginError.success) {
      _auth = true;
    }
    ;
    return result;
  }

  @override
  Future<LoginError> loginPatientWithEmailPassword({
    required String email,
    required String password,
  }) async {
    final result = LocalServer.loginPatient(email, password);
    if (result == LoginError.success) _auth = true;
    return result;
  }

  @override
  void logout() {
    _auth = false;
  }

  @override
  Future<LoginError> registerDoctor(DoctorData data) async {
    LocalServer.doctorsBox.put(data.email, data);
    return LoginError.success;
  }

  @override
  Future<LoginError> registerPatient(PatientData data) async {
    LocalServer.patientBox.put(data.email, data);
    return LoginError.success;
  }

  @override
  bool? get isUserDoctor => _isDoc;

  @override
  bool get isAuthenticated => _auth;
}
