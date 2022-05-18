import 'package:rapid_health/services/loginService/user_data.dart';

class User {
  User({required this.userData, this.isUserDoctor = false});

  UserData userData;
  final bool isUserDoctor;

  DoctorData get doctorData => userData as DoctorData;
  PatientData get patientData => userData as PatientData;
}
