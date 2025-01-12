import 'package:electro_shop/data/models/product_item_model.dart';
import 'package:electro_shop/domain/entities/order_entity.dart';

class OrderModel extends OrderEntity {
  final int id;
  final DateTime createdDate;
  final double totalAmount;
  final List<ProductItemModel> items;

  OrderModel(
      {required this.id,
      required this.createdDate,
      required this.totalAmount,
      required this.items})
      : super(
            id: id,
            createdDate: createdDate,
            totalAmount: totalAmount,
            items: items);
  factory OrderModel.fromJson(Map<String,dynamic>json){
    List<dynamic> jsonItems = json['items'];
    return OrderModel(
      id: json['id'],
      createdDate: DateTime.now(),
      totalAmount: json['totalAmount'],
      items: jsonItems.map((json)=>ProductItemModel.fromJson(json)).toList()
    );
  }
}
