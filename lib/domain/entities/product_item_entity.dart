import 'package:electro_shop/domain/entities/product_entity.dart';
import 'package:electro_shop/domain/entities/variant_entity.dart';

class ProductItemEntity {
  final ProductEntity product;
  final VariantEntity? selectedVariant;

  ProductItemEntity({required this.product, this.selectedVariant});
}