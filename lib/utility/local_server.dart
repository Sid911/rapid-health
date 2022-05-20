import 'package:hive/hive.dart';
import 'package:rapid_health/interfaces/auth_service_interface.dart';
import 'package:rapid_health/services/chatStorageService/chat_data.dart';
import 'package:rapid_health/services/loginService/user_data.dart';

import 'doctor_categories.dart';

class LocalServer {
  static final LocalServer _instance = LocalServer._private();
  static LocalServer get instance => _instance;
  static late Box<DoctorData> doctorsBox;
  static late Box<PatientData> patientBox;
  static late Box<Chat> chatsBox;
  static late Box<ChatData> conversationBox;
  LocalServer._private();

  static Future<void> init() async {
    Hive.registerAdapter(UserDataAdapter());
    Hive.registerAdapter(PatientAdapter());
    Hive.registerAdapter(DoctorAdapter());
    Hive.registerAdapter(DoctorCategoriesAdapter());
    Hive.registerAdapter(ChatAdapter());
    Hive.registerAdapter(ChatDataAdapter());
    Hive.registerAdapter(ChatPreviewAdapter());
    doctorsBox = await Hive.openBox<DoctorData>("doctors");
    patientBox = await Hive.openBox<PatientData>("patients");
    chatsBox = await Hive.openBox<Chat>("chats");
    conversationBox = await Hive.openBox<ChatData>("conversations");
    // generate Dummy Data
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
    final sidDoc = DoctorData(
      name: "Siddharth Sinha",
      password: "0123456789",
      email: "siddharthsinha9752@gmail.com",
      accountCreationDate: DateTime.now(),
      lastLoggedIn: DateTime.now(),
      phone: "9876543210",
      workAddress: "Gali 420 Testing Station,Raipur CG",
      workPhone: "5432109876",
      coordinates: List<double>.of([21.260215, 81.633507], growable: false),
      website: "https://sidthedoc.com",
      category: DoctorCategory.physician,
    );
    // Add dummy data for testing
    if (!patientBox.containsKey("siddevs@outlook.com")) {
      patientBox.put("siddevs@outlook.com", sid);
    }
    if (!doctorsBox.containsKey("siddharthsinha9752@gmail.com")) {
      doctorsBox.put("siddharthsinha9752@gmail.com", sidDoc);
    }
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

  static LoginError loginDoctor(String key, String password) {
    final containsUser = doctorsBox.containsKey(key);
    if (containsUser) {
      final DoctorData doctor = doctorsBox.get(key)!;
      if (doctor.password == password) {
        doctorsBox.put(key, doctor.copyWith(lastLoggedIn: DateTime.now()));
        return LoginError.success;
      } else {
        return LoginError.incorrectCredential;
      }
    } else {
      return LoginError.notFound;
    }
  }

  static DoctorData? getDoctorData(String key) {
    return doctorsBox.get(key);
  }

  static PatientData? getPatientData(String key) {
    return patientBox.get(key);
  }
}
