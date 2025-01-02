import 'package:electro_shop/domain/entities/product_item_entity.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProductItemWidget extends StatelessWidget {
  const ProductItemWidget({super.key, required this.productItemEntity});

  final ProductItemEntity productItemEntity;

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
                      productItemEntity.selectedVariant != null
                          ? productItemEntity.selectedVariant!.image
                          : productItemEntity.product.image,
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
                            productItemEntity.product.name,
                            style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        if(productItemEntity.selectedVariant != null)
                          Text(
                            'Phân loại: ${productItemEntity.selectedVariant!.optionName}',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          ),
                        Text(
                          'Số lượng: ${productItemEntity.quantity}',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          _formatPrice(
                              productItemEntity.selectedVariant != null
                              ? productItemEntity.selectedVariant!.price
                              : productItemEntity.product.price
                          ),
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

