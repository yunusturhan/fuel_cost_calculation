import 'package:hive/hive.dart';
part 'basket_model.g.dart';

@HiveType(typeId: 0)
class Basket extends HiveObject{
  Basket({required this.city,required this.type,required this.unit_price,required this.piece,required this.brand});
  @HiveField(0)
  String city;
  @HiveField(1)
  String type;
  @HiveField(2)
  String brand;
  @HiveField(3)
  double unit_price;
  @HiveField(4)
  double piece;

}