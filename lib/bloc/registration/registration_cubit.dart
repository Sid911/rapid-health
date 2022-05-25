import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:rapid_health/services/loginService/user_data.dart';

import '../../interfaces/auth_service_interface.dart';
import '../../utility/doctor_categories.dart';

part 'registration_state.dart';

class RegistrationCubit extends Cubit<RegistrationState> {
  RegistrationCubit({required this.authService})
      : super(
          RegistrationPatient.fromState(
            state: const RegistrationInitial(),
            address: "",
            age: 0,
            birthDate: DateTime(
              2022,
            ),
          ),
        );
  @override
  void onChange(Change<RegistrationState> change) {
    super.onChange(change);
    if (kDebugMode) {
      print("Current State : \n\n"
          "Email : ${change.currentState.email}\n"
          "Password : ${change.currentState.password}\n"
          "Phone : ${change.currentState.phone}\n"
          "Name : ${change.currentState.name}");

      print("Next State : \n\n"
          "Email : ${change.currentState.email}\n"
          "Password : ${change.currentState.password}\n"
          "Phone : ${change.currentState.phone}\n"
          "Name : ${change.currentState.name}");
    }
  }

  final AuthServiceInterface authService;

  /// Registers the user
  Future<LoginError> registerUser() async {
    LoginError error = LoginError.unknown;
    if (state is RegistrationPatient) {
      final p = state as RegistrationPatient;
      error = await authService.registerPatient(
        PatientData(
          name: p.name,
          password: p.password,
          email: p.email,
          accountCreationDate: DateTime.now(),
          lastLoggedIn: DateTime.now(),
          phone: p.phone,
          address: p.address,
          age: p.age,
          birthdate: p.birthDate,
        ),
      );
    } else if (state is RegistrationDoctor) {
      final d = state as RegistrationDoctor;
      error = await authService.registerDoctor(
        DoctorData(
          name: d.name,
          password: d.password,
          email: d.email,
          accountCreationDate: DateTime.now(),
          lastLoggedIn: DateTime.now(),
          phone: d.phone,
          workAddress: d.workAddress,
          workPhone: d.workPhone,
          coordinates: d.coordinates,
          website: d.website,
          category: d.category,
        ),
      );
    }
    return error;
  }

  void toggleState() {
    if (state is RegistrationPatient) {
      emit(
        RegistrationDoctor.fromState(
          state: state,
          workAddress: "",
          workPhone: "",
          coordinates: List<double>.empty(),
          website: "",
          category: DoctorCategory.emergency,
        ),
      );
    } else {
      emit(
        RegistrationPatient.fromState(
          state: state,
          address: "",
          age: 0,
          birthDate: DateTime.now(),
        ),
      );
    }
  }

  // Default RegistrationState setters
  void setName(String value) {
    if (state is RegistrationPatient) {
      final p = state as RegistrationPatient;
      emit(p.copyWith(name: value));
    } else if (state is RegistrationDoctor) {
      final d = state as RegistrationDoctor;
      emit(d.copyWith(name: value));
    }
  }

  void setEmail(String value) {
    if (state is RegistrationPatient) {
      final p = state as RegistrationPatient;
      emit(p.copyWith(email: value));
    } else if (state is RegistrationDoctor) {
      final d = state as RegistrationDoctor;
      emit(d.copyWith(email: value));
    }
  }

  void setPassword(String value) {
    if (state is RegistrationPatient) {
      final p = state as RegistrationPatient;
      emit(p.copyWith(password: value));
    } else if (state is RegistrationDoctor) {
      final d = state as RegistrationDoctor;
      emit(d.copyWith(password: value));
    }
  }

  void setPhone(String value) {
    if (state is RegistrationPatient) {
      final p = state as RegistrationPatient;
      emit(p.copyWith(phone: value));
    } else if (state is RegistrationDoctor) {
      final d = state as RegistrationDoctor;
      emit(d.copyWith(phone: value));
    }
  }

  // RegistrationPatient setters
  void setPatientAddress(String value) {
    if (state is RegistrationPatient) {
      final p = state as RegistrationPatient;
      emit(p.copyWith(address: value));
    }
  }

  void setPatientAge(int value) {
    if (state is RegistrationPatient) {
      final p = state as RegistrationPatient;
      emit(p.copyWith(age: value));
    }
  }

  void setPatientBirthDate(DateTime value) {
    if (state is RegistrationPatient) {
      final p = state as RegistrationPatient;
      emit(p.copyWith(birthDate: value));
    }
  }

  // RegistrationDoctor setters
  void setDoctorWorkAddress(String value) {
    if (state is RegistrationDoctor) {
      final d = state as RegistrationDoctor;
      emit(d.copyWith(workAddress: value));
    }
  }

  void setDoctorWorkPhone(String value) {
    if (state is RegistrationDoctor) {
      final d = state as RegistrationDoctor;
      emit(d.copyWith(workPhone: value));
    }
  }

  void setDoctorWorkCoordinates(List<double> value) {
    if (state is RegistrationDoctor) {
      final d = state as RegistrationDoctor;
      emit(d.copyWith(coordinates: value));
    }
  }

  void setDoctorWorkWebsite(String value) {
    if (state is RegistrationDoctor) {
      final d = state as RegistrationDoctor;
      emit(d.copyWith(website: value));
    }
  }

  void setDoctorWorkCategory(DoctorCategory value) {
    if (state is RegistrationDoctor) {
      final d = state as RegistrationDoctor;
      emit(d.copyWith(category: value));
    }
  }
}
