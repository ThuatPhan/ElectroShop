import 'package:electro_shop/domain/entities/product_item_entity.dart';

class OrderEntity {
  final int id;
  final DateTime createdDate;
  final double totalAmount;
  final List<ProductItemEntity> items;

  OrderEntity(
      {required this.id,
      required this.createdDate,
      required this.totalAmount,
      required this.items});
}
