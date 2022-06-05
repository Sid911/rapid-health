// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BookingDataAdapter extends TypeAdapter<BookingData> {
  @override
  final int typeId = 11;

  @override
  BookingData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BookingData(
      patientUID: fields[0] as String,
      doctorUID: fields[1] as String,
      key: fields[2] as String,
      bookingDate: fields[3] as DateTime,
      isValid: fields[4] as bool,
      postUID: fields[5] as String,
      time: fields[6] as TimeOfDay,
    );
  }

  @override
  void write(BinaryWriter writer, BookingData obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.patientUID)
      ..writeByte(1)
      ..write(obj.doctorUID)
      ..writeByte(2)
      ..write(obj.key)
      ..writeByte(3)
      ..write(obj.bookingDate)
      ..writeByte(4)
      ..write(obj.isValid)
      ..writeByte(5)
      ..write(obj.postUID)
      ..writeByte(6)
      ..write(obj.time);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookingDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PatientBookingsAdapter extends TypeAdapter<PatientBookings> {
  @override
  final int typeId = 12;

  @override
  PatientBookings read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PatientBookings(
      fields[0] as String,
      (fields[1] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, PatientBookings obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.patientUID)
      ..writeByte(1)
      ..write(obj.bookingUIDs);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PatientBookingsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DoctorBookingsAdapter extends TypeAdapter<DoctorBookings> {
  @override
  final int typeId = 13;

  @override
  DoctorBookings read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DoctorBookings(
      fields[0] as String,
      (fields[1] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, DoctorBookings obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.doctorUID)
      ..writeByte(1)
      ..write(obj.bookingUIDs);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DoctorBookingsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
