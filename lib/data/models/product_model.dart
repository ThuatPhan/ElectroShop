import 'package:electro_shop/data/models/category_model.dart';
import 'package:electro_shop/data/models/variant_model.dart';
import 'package:electro_shop/domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  final int id;
  final String name;
  final String description;
  final String image;
  final double price;
  final int stock;
  final CategoryModel category;
  final List<VariantModel>? variants;

  ProductModel(
      {required this.id,
      required this.name,
      required this.description,
      required this.image,
      required this.price,
      required this.stock,
      required this.category,
      this.variants})
      : super(
            id: id,
            name: name,
            description: description,
            image: image,
            price: price,
            stock: stock,
            category: category,
            variants: variants);

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    //Lấy category từ json
    CategoryModel category = CategoryModel.fromJson(json['category']);

    //Lấy variants từ json
    List<VariantModel>? variants = json['variants'] != null
        ? (json['variants'] as List)
            .map((variantJson) => VariantModel.fromJson(variantJson))
            .toList()
        : null;

    return ProductModel(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        image: json['image'],
        price: json['price'],
        stock: json['stock'],
        category: category,
        variants: variants);
  }
}
