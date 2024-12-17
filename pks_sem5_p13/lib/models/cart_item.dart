// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

import '/models/shop_item.dart';
//  dart run build_runner build --delete-conflicting-outputs

part 'cart_item.g.dart';
@JsonSerializable()
class CartItem {
  CartItem(this.ID, this.item, this.Count);
  int ID;
  @JsonKey(name: "Service")
  ShopItem item;
  int Count;

  factory CartItem.fromJson(Map<String, dynamic> json) =>
      _$CartItemFromJson(json);
  Map<String, dynamic> toJson() => _$CartItemToJson(this);
}