// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReviewDataAdapter extends TypeAdapter<ReviewData> {
  @override
  final int typeId = 14;

  @override
  ReviewData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ReviewData(
      title: fields[0] as String,
      description: fields[1] as String,
      postDate: fields[2] as DateTime,
      authorUID: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ReviewData obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.postDate)
      ..writeByte(3)
      ..write(obj.authorUID);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReviewDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ReviewsAdapter extends TypeAdapter<Reviews> {
  @override
  final int typeId = 15;

  @override
  Reviews read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Reviews(
      fields[0] as String,
      (fields[1] as List).cast<ReviewData>(),
    );
  }

  @override
  void write(BinaryWriter writer, Reviews obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.postUID)
      ..writeByte(1)
      ..write(obj.reviews);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReviewsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
