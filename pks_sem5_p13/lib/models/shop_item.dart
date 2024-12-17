// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'shop_item.g.dart';

@JsonSerializable()
class ShopItem {
  ShopItem(this.ID, this.Name, this.Category, this.PriceRubles, this.ImageHref,
      this.Description);
  int ID;
  String Name;
  String Category;
  int PriceRubles;
  String ImageHref;
  String Description;
  
  factory ShopItem.fromJson(Map<String, dynamic> json) =>
      _$ShopItemFromJson(json);
  Map<String, dynamic> toJson() => _$ShopItemToJson(this);
}
