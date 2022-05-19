// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor_categories.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DoctorCategoriesAdapter extends TypeAdapter<DoctorCategory> {
  @override
  final int typeId = 7;

  @override
  DoctorCategory read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return DoctorCategory.physician;
      case 1:
        return DoctorCategory.dentist;
      case 2:
        return DoctorCategory.gynecologist;
      case 3:
        return DoctorCategory.ent;
      case 4:
        return DoctorCategory.orthopaedic;
      case 5:
        return DoctorCategory.emergency;
      default:
        return DoctorCategory.physician;
    }
  }

  @override
  void write(BinaryWriter writer, DoctorCategory obj) {
    switch (obj) {
      case DoctorCategory.physician:
        writer.writeByte(0);
        break;
      case DoctorCategory.dentist:
        writer.writeByte(1);
        break;
      case DoctorCategory.gynecologist:
        writer.writeByte(2);
        break;
      case DoctorCategory.ent:
        writer.writeByte(3);
        break;
      case DoctorCategory.orthopaedic:
        writer.writeByte(4);
        break;
      case DoctorCategory.emergency:
        writer.writeByte(5);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DoctorCategoriesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
