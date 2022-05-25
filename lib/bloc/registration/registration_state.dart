part of 'registration_cubit.dart';

abstract class RegistrationState extends Equatable {
  const RegistrationState({
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
  });

  final String name;
  final String email;
  final String password;
  final String phone;
}

class RegistrationInitial extends RegistrationState {
  const RegistrationInitial({
    super.name = "",
    super.email = "",
    super.password = "",
    super.phone = "",
  });

  @override
  List<Object> get props => [name, email, password, phone];
}

class RegistrationPatient extends RegistrationState {
  ///
  const RegistrationPatient({
    required super.name,
    required super.email,
    required super.password,
    required super.phone,
    required this.address,
    required this.age,
    required this.birthDate,
  });

  ///
  RegistrationPatient.fromState({
    required RegistrationState state,
    required this.address,
    required this.age,
    required this.birthDate,
  }) : super(
          email: state.email,
          password: state.password,
          name: state.name,
          phone: state.phone,
        );

  ///
  final String address;
  final int age;
  final DateTime birthDate;

  ///
  RegistrationPatient copyWith({
    String? name,
    String? email,
    String? password,
    String? phone,
    String? address,
    int? age,
    DateTime? birthDate,
  }) {
    return RegistrationPatient(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      age: age ?? this.age,
      birthDate: birthDate ?? this.birthDate,
    );
  }

  ///
  @override
  List<Object> get props => [
        name,
        email,
        password,
        phone,
        address,
        age,
        birthDate,
      ];
}

class RegistrationDoctor extends RegistrationState {
  const RegistrationDoctor({
    required super.name,
    required super.email,
    required super.password,
    required super.phone,
    required this.workAddress,
    required this.workPhone,
    required this.coordinates,
    required this.website,
    required this.category,
  });
  RegistrationDoctor.fromState({
    required RegistrationState state,
    required this.workAddress,
    required this.workPhone,
    required this.coordinates,
    required this.website,
    required this.category,
  }) : super(
          email: state.email,
          password: state.password,
          name: state.name,
          phone: state.phone,
        );

  ///
  final String workAddress;
  final String workPhone;
  final List<double> coordinates;
  final String website;
  final DoctorCategory category;

  ///
  RegistrationDoctor copyWith({
    String? name,
    String? email,
    String? password,
    String? phone,
    String? workAddress,
    String? workPhone,
    List<double>? coordinates,
    String? website,
    DoctorCategory? category,
  }) {
    return RegistrationDoctor(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      phone: phone ?? this.phone,
      workAddress: workAddress ?? this.workAddress,
      workPhone: workPhone ?? this.workPhone,
      coordinates: coordinates ?? this.coordinates,
      website: website ?? this.website,
      category: category ?? this.category,
    );
  }

  ///
  @override
  List<Object> get props => [
        name,
        email,
        password,
        phone,
        workAddress,
        workPhone,
        coordinates,
        website,
        category,
      ];
}
