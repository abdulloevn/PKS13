// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartItem _$CartItemFromJson(Map<String, dynamic> json) => CartItem(
      (json['ID'] as num).toInt(),
      ShopItem.fromJson(json['Service'] as Map<String, dynamic>),
      (json['Count'] as num).toInt(),
    );

Map<String, dynamic> _$CartItemToJson(CartItem instance) => <String, dynamic>{
      'ID': instance.ID,
      'Service': instance.item,
      'Count': instance.Count,
    };
