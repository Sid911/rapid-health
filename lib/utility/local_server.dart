import 'package:hive/hive.dart';
import 'package:rapid_health/services/loginService/auth_service.dart';
import 'package:rapid_health/services/loginService/user_data.dart';

class LocalServer {
  static final LocalServer _instance = LocalServer._private();
  static LocalServer get instance => _instance;
  static late Box<DoctorData> doctorsBox;
  static late Box<PatientData> patientBox;
  LocalServer._private();

  static Future<void> init() async {
    Hive.registerAdapter(UserDataAdapter());
    Hive.registerAdapter(PatientAdapter());
    Hive.registerAdapter(DoctorAdapter());
    doctorsBox = await Hive.openBox<DoctorData>("doctors");
    patientBox = await Hive.openBox<PatientData>("patients");

    final sid = PatientData(
      name: 'Siddharth Sinha',
      password: "1a2b3c4d5e",
      email: "siddevs@outlook.com",
      accountCreationDate: DateTime.now(),
      lastLoggedIn: DateTime.now(),
      phone: "0123456789",
      address: "Raipur Chhattisgarh",
      age: 19,
      birthdate: DateTime(2002, 11, 24),
    );
    patientBox.put("siddevs@outlook.com", sid);
  }

  static LoginError loginPatient(String key, String password) {
    final containsUser = patientBox.containsKey(key);
    if (containsUser) {
      final PatientData patient = patientBox.get(key)!;
      if (patient.password == password) {
        patientBox.put(key, patient.copyWith(lastLoggedIn: DateTime.now()));
        return LoginError.success;
      } else {
        return LoginError.incorrectCredential;
      }
    } else {
      return LoginError.notFound;
    }
  }
}
