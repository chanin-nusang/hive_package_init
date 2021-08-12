// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'starwars_repo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PeopleAdapter extends TypeAdapter<People> {
  @override
  final int typeId = 1;

  @override
  People read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return People(
      name: fields[0] as String?,
      height: fields[1] as String?,
      mass: fields[2] as String?,
      birthYear: fields[3] as String?,
      gender: fields[4] as String?,
      homeworld: fields[5] as String?,
      hairColor: fields[6] as String?,
      skinColor: fields[7] as String?,
      eyeColor: fields[8] as String?,
      no: fields[9] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, People obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.height)
      ..writeByte(2)
      ..write(obj.mass)
      ..writeByte(3)
      ..write(obj.birthYear)
      ..writeByte(4)
      ..write(obj.gender)
      ..writeByte(5)
      ..write(obj.homeworld)
      ..writeByte(6)
      ..write(obj.hairColor)
      ..writeByte(7)
      ..write(obj.skinColor)
      ..writeByte(8)
      ..write(obj.eyeColor)
      ..writeByte(9)
      ..write(obj.no);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PeopleAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
