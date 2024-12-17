// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

import 'cart_item.dart';
part 'order.g.dart';

//  dart run build_runner build --delete-conflicting-outputs
@JsonSerializable()
class Order {
  Order(this.ID, this.UserID, this.Total, this.OrderItems, this.CreatedAt);
  int ID;
  int UserID;
  int Total;
  DateTime CreatedAt;
  List<CartItem> OrderItems;

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
  Map<String, dynamic> toJson() => _$OrderToJson(this);
}
