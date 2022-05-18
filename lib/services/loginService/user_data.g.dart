// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserDataAdapter extends TypeAdapter<UserData> {
  @override
  final int typeId = 0;

  @override
  UserData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserData(
      name: fields[0] as String,
      password: fields[1] as String,
      email: fields[2] as String,
      accountCreationDate: fields[4] as DateTime,
      lastLoggedIn: fields[5] as DateTime,
      phone: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, UserData obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.password)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.phone)
      ..writeByte(4)
      ..write(obj.accountCreationDate)
      ..writeByte(5)
      ..write(obj.lastLoggedIn);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PatientAdapter extends TypeAdapter<PatientData> {
  @override
  final int typeId = 1;

  @override
  PatientData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PatientData(
      name: fields[0] as String,
      password: fields[1] as String,
      email: fields[2] as String,
      accountCreationDate: fields[4] as DateTime,
      lastLoggedIn: fields[5] as DateTime,
      phone: fields[3] as String,
      address: fields[6] as String,
      age: fields[7] as int,
      birthdate: fields[8] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, PatientData obj) {
    writer
      ..writeByte(9)
      ..writeByte(6)
      ..write(obj.address)
      ..writeByte(7)
      ..write(obj.age)
      ..writeByte(8)
      ..write(obj.birthdate)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.password)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.phone)
      ..writeByte(4)
      ..write(obj.accountCreationDate)
      ..writeByte(5)
      ..write(obj.lastLoggedIn);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PatientAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DoctorAdapter extends TypeAdapter<DoctorData> {
  @override
  final int typeId = 2;

  @override
  DoctorData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DoctorData(
      name: fields[0] as String,
      password: fields[1] as String,
      email: fields[2] as String,
      accountCreationDate: fields[4] as DateTime,
      lastLoggedIn: fields[5] as DateTime,
      phone: fields[3] as String,
      workAddress: fields[6] as String,
      workPhone: fields[7] as String,
      coordinates: (fields[8] as List).cast<int>(),
      website: fields[9] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DoctorData obj) {
    writer
      ..writeByte(10)
      ..writeByte(6)
      ..write(obj.workAddress)
      ..writeByte(7)
      ..write(obj.workPhone)
      ..writeByte(8)
      ..write(obj.coordinates)
      ..writeByte(9)
      ..write(obj.website)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.password)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.phone)
      ..writeByte(4)
      ..write(obj.accountCreationDate)
      ..writeByte(5)
      ..write(obj.lastLoggedIn);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DoctorAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
