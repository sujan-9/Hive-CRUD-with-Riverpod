// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'completed_list.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CompletedListAdapter extends TypeAdapter<CompletedList> {
  @override
  final int typeId = 1;

  @override
  CompletedList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CompletedList(
      title: fields[0] as String,
      desc: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CompletedList obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.desc);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CompletedListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
