// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PostDataAdapter extends TypeAdapter<PostData> {
  @override
  final int typeId = 8;

  @override
  PostData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PostData(
      title: fields[0] as String,
      description: fields[1] as String,
      subtitle: fields[2] as String,
      postDate: fields[3] as DateTime,
      expireDate: fields[4] as DateTime,
      authorUID: fields[5] as String,
      postCategory: fields[6] as DoctorCategory,
      coordinates: (fields[7] as List).cast<double>(),
      address: fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PostData obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.subtitle)
      ..writeByte(3)
      ..write(obj.postDate)
      ..writeByte(4)
      ..write(obj.expireDate)
      ..writeByte(5)
      ..write(obj.authorUID)
      ..writeByte(6)
      ..write(obj.postCategory)
      ..writeByte(7)
      ..write(obj.coordinates)
      ..writeByte(8)
      ..write(obj.address);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PostDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PostPreviewAdapter extends TypeAdapter<PostPreview> {
  @override
  final int typeId = 9;

  @override
  PostPreview read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PostPreview(
      title: fields[0] as String,
      subtitle: fields[1] as String,
      postCategory: fields[2] as DoctorCategory,
      postDate: fields[3] as DateTime,
      postDataHash: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PostPreview obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.subtitle)
      ..writeByte(2)
      ..write(obj.postCategory)
      ..writeByte(4)
      ..write(obj.postDataHash)
      ..writeByte(3)
      ..write(obj.postDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PostPreviewAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PostsAdapter extends TypeAdapter<Posts> {
  @override
  final int typeId = 10;

  @override
  Posts read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Posts(
      authorUID: fields[0] as String,
      previews: (fields[1] as List).cast<PostPreview>(),
    );
  }

  @override
  void write(BinaryWriter writer, Posts obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.authorUID)
      ..writeByte(1)
      ..write(obj.previews);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PostsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
