import 'package:electro_shop/data/models/product_model.dart';
import 'package:electro_shop/data/models/variant_model.dart';
import 'package:electro_shop/domain/entities/product_item_entity.dart';

class ProductItemModel extends ProductItemEntity{
  final ProductModel product;
  final VariantModel? selectedVariant;

  ProductItemModel({required this.product, this.selectedVariant})
      : super(product: product, selectedVariant: selectedVariant);

  factory ProductItemModel.fromJson(Map<String, dynamic> json) {
    return ProductItemModel(
        product: ProductModel.fromJson(json['product']),
        selectedVariant: json['selectedVariant'] != null ? VariantModel.fromJson(json['selectedVariant']) : null
    );
  }
}