// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'close_contact_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CloseContactModelAdapter extends TypeAdapter<CloseContactModel> {
  @override
  final int typeId = 2;

  @override
  CloseContactModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CloseContactModel(
      username: fields[0] as String?,
      number: fields[1] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, CloseContactModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.username)
      ..writeByte(1)
      ..write(obj.number);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CloseContactModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
