/// Base UserData Class contains basic information about the user
class UserData {
  const UserData({
    required this.name,
    required this.password,
    required this.email,
    required this.accountCreationDate,
    required this.lastLoggedIn,
  });

  final String name;
  final String password;
  final String email;
  final DateTime accountCreationDate;
  final DateTime lastLoggedIn;
}

class PatientData extends UserData {
  PatientData({
    required super.name,
    required super.password,
    required super.email,
    required super.accountCreationDate,
    required super.lastLoggedIn,
  });
}

class DoctorData extends UserData {
  DoctorData({
    required super.name,
    required super.password,
    required super.email,
    required super.accountCreationDate,
    required super.lastLoggedIn,
  });
}
