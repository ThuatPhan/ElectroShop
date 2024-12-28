import 'package:electro_shop/domain/entities/category_entity.dart';
import 'package:electro_shop/domain/entities/variant_entity.dart';

class ProductEntity {
  final int id;
  final String name;
  final String description;
  final String image;
  final double price;
  final int stock;
  final CategoryEntity category;
  final bool isVariant;
  final List<VariantEntity>? variants;

  ProductEntity(
      {required this.id,
      required this.name,
      required this.description,
      required this.image,
      required this.price,
      required this.stock,
      required this.isVariant,
      required this.category,
      this.variants});
}
