import 'package:hive_flutter/adapters.dart';
import 'package:rapid_health/utility/doctor_categories.dart';

part 'user_data.g.dart';

/// Base UserData Class contains basic information about the user.
/// This couldn't be a abstract class in this case because of Hive's way of implementing
/// inheritance.
@HiveType(
  typeId: 0,
  adapterName: "UserDataAdapter",
)
class UserData {
  const UserData(
      {required this.name,
      required this.password,
      required this.email,
      required this.accountCreationDate,
      required this.lastLoggedIn,
      required this.phone});
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String password;
  @HiveField(2)
  final String email;
  @HiveField(3)
  final String phone;
  @HiveField(4)
  final DateTime accountCreationDate;
  @HiveField(5)
  final DateTime lastLoggedIn;

  String get uid {
    return email;
  }
}

@HiveType(
  typeId: 1,
  adapterName: "PatientAdapter",
)
class PatientData extends UserData {
  PatientData({
    required super.name,
    required super.password,
    required super.email,
    required super.accountCreationDate,
    required super.lastLoggedIn,
    required super.phone,
    required this.address,
    required this.age,
    required this.birthdate,
  });

  PatientData.fromUserData({
    required UserData data,
    required this.address,
    required this.age,
    required this.birthdate,
  }) : super(
          name: data.name,
          password: data.password,
          email: data.email,
          accountCreationDate: data.accountCreationDate,
          lastLoggedIn: data.lastLoggedIn,
          phone: data.phone,
        );
  @HiveField(6)
  final String address;
  @HiveField(7)
  final int age;
  @HiveField(8)
  final DateTime birthdate;

  @override
  // Simple patient addon for the uid
  String get uid => "patient:" + email;

  PatientData copyWith({
    String? name,
    String? password,
    String? email,
    DateTime? accountCreationDate,
    DateTime? lastLoggedIn,
    String? phone,
    String? address,
    int? age,
    DateTime? birthdate,
  }) {
    return PatientData(
      name: name ?? this.name,
      password: password ?? this.password,
      email: email ?? this.email,
      accountCreationDate: accountCreationDate ?? this.accountCreationDate,
      lastLoggedIn: lastLoggedIn ?? this.lastLoggedIn,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      age: age ?? this.age,
      birthdate: birthdate ?? this.birthdate,
    );
  }
}

@HiveType(
  typeId: 2,
  adapterName: "DoctorAdapter",
)
class DoctorData extends UserData {
  DoctorData({
    required super.name,
    required super.password,
    required super.email,
    required super.accountCreationDate,
    required super.lastLoggedIn,
    required super.phone,
    required this.workAddress,
    required this.workPhone,
    required this.coordinates,
    required this.website,
    required this.category,
  });
  DoctorData.fromUserData({
    required UserData data,
    required this.workAddress,
    required this.workPhone,
    required this.coordinates,
    required this.website,
    required this.category,
  }) : super(
          name: data.name,
          password: data.password,
          email: data.email,
          accountCreationDate: data.accountCreationDate,
          lastLoggedIn: data.lastLoggedIn,
          phone: data.phone,
        );
  @HiveField(6)
  final String workAddress;
  @HiveField(7)
  final String workPhone;
  @HiveField(8)
  final List<double> coordinates;
  @HiveField(9)
  final String website;
  @HiveField(10)
  final DoctorCategory category;

  @override
  // Simple doctor addon for uid
  String get uid => "doctor:" + email;

  DoctorData copyWith({
    String? name,
    String? password,
    String? email,
    DateTime? accountCreationDate,
    DateTime? lastLoggedIn,
    String? phone,
    String? workAddress,
    String? workPhone,
    List<double>? coordinates,
    String? website,
    DoctorCategory? category,
  }) {
    return DoctorData(
      name: name ?? this.name,
      password: password ?? this.password,
      email: email ?? this.email,
      accountCreationDate: accountCreationDate ?? this.accountCreationDate,
      lastLoggedIn: lastLoggedIn ?? this.lastLoggedIn,
      phone: phone ?? this.phone,
      workAddress: workAddress ?? this.workAddress,
      workPhone: workPhone ?? this.workPhone,
      coordinates: coordinates ?? this.coordinates,
      website: website ?? this.website,
      category: category ?? this.category,
    );
  }
}
