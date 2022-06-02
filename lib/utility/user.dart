import 'package:rapid_health/services/loginService/user_data.dart';

class User {
  User({
    required this.userData,
    this.isUserDoctor = false,
    this.profilePicLink,
  });

  UserData userData;
  final bool isUserDoctor;

  DoctorData get doctorData => userData as DoctorData;
  PatientData get patientData => userData as PatientData;

  String? profilePicLink;
  String get uid => isUserDoctor ? doctorData.uid : patientData.uid;
  UserUID get parsedUID => UserUID.fromString(uid);
}

class UserUID {
  bool isDoctor;
  String id;
  UserUID({required this.isDoctor, required this.id});
  UserUID.fromString(String value)
      : isDoctor = true,
        id = "" {
    final list = value.trim().split(":");
    isDoctor = list.first == "doctor";
    id = list.last;
  }
}
