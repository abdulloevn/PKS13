import 'package:pks_sem5_p8/models/shop_item.dart';

class SortMenuItem {
  Comparable Function(ShopItem)? getSortParameter;
  String menuOption;

  SortMenuItem(this.getSortParameter, this.menuOption);
  @override
  String toString() {
    return menuOption;
  }
}