import 'package:hive_flutter/adapters.dart';

part 'doctor_categories.g.dart';

/// Types of doctors and
@HiveType(typeId: 7, adapterName: "DoctorCategoriesAdapter")
enum DoctorCategory {
  @HiveField(0)
  physician,
  @HiveField(1)
  dentist,
  @HiveField(2)
  gynecologist,
  @HiveField(3)
  ent,
  @HiveField(4)
  orthopaedic,
  @HiveField(5)
  emergency,
}

extension Stringify on DoctorCategory {
  String getString() {
    switch (this) {
      case DoctorCategory.physician:
        return "Physician";

      case DoctorCategory.dentist:
        return "Dentist";
      case DoctorCategory.gynecologist:
        return "Gynecologist";
      case DoctorCategory.ent:
        return "ENT";
      case DoctorCategory.orthopaedic:
        return "Orthopaedic";
      case DoctorCategory.emergency:
        return "Emergency";
    }
  }
}
