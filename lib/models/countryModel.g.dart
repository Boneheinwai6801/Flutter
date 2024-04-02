// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'countryModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CountryAdapter extends TypeAdapter<Country> {
  @override
  final int typeId = 0;

  @override
  Country read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Country(
      name: fields[0] as String,
      flag: fields[1] as String,
      pop: fields[2] as int,
      region: fields[3] as String,
      capital: fields[4] as String,
      currencyName: fields[6] as String,
      indep: fields[7] as bool,
      nname: fields[5] as String,
      languages: fields[8] as String,
      currencySymbol: fields[9] as String,
      map: fields[10] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Country obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.flag)
      ..writeByte(2)
      ..write(obj.pop)
      ..writeByte(3)
      ..write(obj.region)
      ..writeByte(4)
      ..write(obj.capital)
      ..writeByte(5)
      ..write(obj.nname)
      ..writeByte(6)
      ..write(obj.currencyName)
      ..writeByte(7)
      ..write(obj.indep)
      ..writeByte(8)
      ..write(obj.languages)
      ..writeByte(9)
      ..write(obj.currencySymbol)
      ..writeByte(10)
      ..write(obj.map);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CountryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CountryAdapterAdapter extends TypeAdapter<CountryAdapter> {
  @override
  final int typeId = 1;

  @override
  CountryAdapter read(BinaryReader reader) {
    return CountryAdapter();
  }

  @override
  void write(BinaryWriter writer, CountryAdapter obj) {
    writer.writeByte(0);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CountryAdapterAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
