import 'package:rapid_health/services/loginService/user_data.dart';
import 'package:rapid_health/services/settingsService/settings_service.dart';
import 'package:rapid_health/utility/local_server.dart';
import 'package:rapid_health/utility/user.dart';

import '../../interfaces/auth_service_interface.dart';

/// [LocalAuthService] is a mock [AuthServiceInterface] implementation which stores data locally about the users.
/// Using hive as its key pair database
///
///
class LocalAuthService extends AuthServiceInterface {
  bool? _isDoc;
  bool _auth = false;
  User? _currentUser;
  final SettingsService settings = SettingsService();
  @override
  Future<LoginError> loginDoctorWithEmailPassword({
    required String email,
    required String password,
  }) async {
    final result = LocalServer.loginDoctor(email, password);
    if (result == LoginError.success) {
      _auth = true;
      final user = LocalServer.getDoctorData(email)!;
      _currentUser = User(userData: user, isUserDoctor: true);
      _isDoc = true;
      settings.saveUser(user);
    }
    return result;
  }

  @override
  Future<LoginError> loginPatientWithEmailPassword({
    required String email,
    required String password,
  }) async {
    final result = LocalServer.loginPatient(email, password);
    if (result == LoginError.success) {
      _auth = true;
      final user = LocalServer.getPatientData(email)!;
      _currentUser = User(userData: user, isUserDoctor: false);
      _isDoc = false;
      settings.saveUser(user);
    }
    return result;
  }

  @override
  void logout() {
    _auth = false;
    _currentUser = null;
    settings.resetSettings();
  }

  @override
  Future<LoginError> registerDoctor(DoctorData data) async {
    if (!LocalServer.doctorsBox.containsKey(data.email)) {
      LocalServer.doctorsBox.put(data.email, data);
    } else {
      return LoginError.incorrectCredential;
    }
    return LoginError.success;
  }

  @override
  Future<LoginError> registerPatient(PatientData data) async {
    LocalServer.patientBox.put(data.email, data);
    return LoginError.success;
  }

  @override
  Future<DoctorData?> getDoctorData(String uid) async {
    return LocalServer.getDoctorData(uid);
  }

  @override
  Future<PatientData?> getPatientData(String uid) async {
    return LocalServer.getPatientData(uid);
  }

  @override
  bool? get isUserDoctor => _isDoc;

  @override
  bool get isAuthenticated => _auth;

  @override
  User? get currentUser => _currentUser;

  @override
  Future<UserData?> getUserData(UserUID uid) async {
    return uid.isDoctor
        ? await getDoctorData(uid.id)
        : await getPatientData(uid.id);
  }
}
