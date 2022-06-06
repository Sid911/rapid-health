import 'package:rapid_health/services/loginService/user_data.dart';
import 'package:rapid_health/utility/user.dart';

/// Abstract class used as an interface for different login service implementations
abstract class AuthServiceInterface {
  /// Returns true if the user is a doctor. If there is no current [User] returns
  /// null.
  bool? get isUserDoctor;

  /// Returns true if user is authenticated
  bool get isAuthenticated;

  User? get currentUser;

  /// Login Patient using email and password
  ///
  /// Returns LoginError
  Future<LoginError> loginPatientWithEmailPassword({
    required String email,
    required String password,
  });

  /// Registers patient to the server
  Future<LoginError> registerPatient(PatientData data);
  Future<LoginError> loginDoctorWithEmailPassword({
    required String email,
    required String password,
  });

  /// Registers doctors to the server
  Future<LoginError> registerDoctor(DoctorData data);
  void logout();

  Future<DoctorData?> getDoctorData(String uid);
  Future<PatientData?> getPatientData(String uid);
  Future<UserData?> getUserData(UserUID uid);
}

enum LoginError {
  success,
  notFound,
  incorrectCredential,
  unknown,
}
