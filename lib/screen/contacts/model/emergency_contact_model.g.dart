// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emergency_contact_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EmergencyContactModelAdapter extends TypeAdapter<EmergencyContactModel> {
  @override
  final int typeId = 1;

  @override
  EmergencyContactModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EmergencyContactModel()
      ..fullname = fields[0] as String?
      ..number = fields[1] as int?
      ..address = fields[2] as String?;
  }

  @override
  void write(BinaryWriter writer, EmergencyContactModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.fullname)
      ..writeByte(1)
      ..write(obj.number)
      ..writeByte(2)
      ..write(obj.address);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmergencyContactModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
