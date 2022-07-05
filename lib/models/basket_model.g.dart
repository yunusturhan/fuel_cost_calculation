// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basket_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BasketAdapter extends TypeAdapter<Basket> {
  @override
  final int typeId = 0;

  @override
  Basket read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Basket(
      city: fields[0] as String,
      type: fields[1] as String,
      unit_price: fields[3] as double,
      piece: fields[4] as double,
      brand: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Basket obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.city)
      ..writeByte(1)
      ..write(obj.type)
      ..writeByte(2)
      ..write(obj.brand)
      ..writeByte(3)
      ..write(obj.unit_price)
      ..writeByte(4)
      ..write(obj.piece);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BasketAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
