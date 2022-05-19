// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChatMessageAdapter extends TypeAdapter<ChatMessage> {
  @override
  final int typeId = 5;

  @override
  ChatMessage read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ChatMessage(
      fields[0] as String,
      fields[1] as String,
      fields[2] as DateTime,
      fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ChatMessage obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.senderID)
      ..writeByte(1)
      ..write(obj.receiverID)
      ..writeByte(2)
      ..write(obj.messageSent)
      ..writeByte(3)
      ..write(obj.data);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChatMessageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ChatDataAdapter extends TypeAdapter<ChatData> {
  @override
  final int typeId = 4;

  @override
  ChatData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ChatData(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String,
      (fields[3] as List).cast<ChatMessage>(),
    );
  }

  @override
  void write(BinaryWriter writer, ChatData obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.targetID)
      ..writeByte(1)
      ..write(obj.originID)
      ..writeByte(2)
      ..write(obj.hashKey)
      ..writeByte(3)
      ..write(obj.messages);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChatDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ChatPreviewAdapter extends TypeAdapter<ChatPreview> {
  @override
  final int typeId = 6;

  @override
  ChatPreview read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ChatPreview(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String,
      fields[3] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, ChatPreview obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.targetUID)
      ..writeByte(1)
      ..write(obj.chatHash)
      ..writeByte(2)
      ..write(obj.lastMessage)
      ..writeByte(3)
      ..write(obj.lastMessageTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChatPreviewAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ChatAdapter extends TypeAdapter<Chat> {
  @override
  final int typeId = 3;

  @override
  Chat read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Chat(
      (fields[0] as List).cast<ChatPreview>(),
      fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Chat obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.chats)
      ..writeByte(1)
      ..write(obj.userUID);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChatAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
