import 'package:electro_shop/domain/entities/product_entity.dart';
import 'package:electro_shop/domain/entities/variant_entity.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProductItemWidget extends StatelessWidget {
  const ProductItemWidget({super.key, required this.product, this.selectedVariant});

  final ProductEntity product;
  final VariantEntity? selectedVariant;

  String _formatPrice (double price) {
    return NumberFormat.currency(locale: 'vi_VN', symbol: '₫').format(price);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          // Card for items
          Card(
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      selectedVariant != null ? selectedVariant!.image : product.image,
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 5,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        if(selectedVariant != null)
                          Text(
                            'Phân loại: ${selectedVariant!.optionName}',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          ),
                        Text(
                          _formatPrice(selectedVariant != null ? selectedVariant!.price : product.price),
                          style: const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

        ],
      );

  }
}

