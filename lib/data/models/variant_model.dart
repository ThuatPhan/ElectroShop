import 'package:electro_shop/domain/entities/variant_entity.dart';

class VariantModel extends VariantEntity {
  final int id;
  final int productId;
  final String optionName;
  final String name;
  final String? image;
  final double price;
  final int stock;

  VariantModel(
      {required this.id,
      required this.productId,
      required this.optionName,
      required this.name,
      required this.image,
      required this.price,
      required this.stock})
      : super(
            id: id,
            productId: productId,
            optionName: optionName,
            name: name,
            image: image,
            price: price,
            stock: stock);

  factory VariantModel.fromJson(Map<String, dynamic> json) {
    return VariantModel(
        id: json['id'],
        productId: json['productId'],
        optionName: json['optionName'],
        name: json['name'],
        image: json['image'],
        price: json['price'],
        stock: json['stock']);
  }
}
