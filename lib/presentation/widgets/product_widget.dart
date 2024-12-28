import 'package:electro_shop/constants.dart';
import 'package:electro_shop/domain/entities/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProductWidget extends StatelessWidget {
  final ProductEntity product;

  const ProductWidget({super.key, required this.product});

  String _formatPrice (double price) {
    return NumberFormat.currency(locale: 'vi_VN', symbol: '₫').format(price);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: Image.network(
                      product.image,
                      fit: BoxFit.cover,
                    ),
                  )),
              ),
              Text(
                product.name,
                style: const TextStyle(
                  fontSize: productPriceSize,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis
                ),
              ),
              Text(
                _formatPrice(product.price),
                style: const TextStyle(
                  fontSize: productPriceSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                minimumSize: const Size(200,20), // Set width and height
              ),
              child: const Text(
                'Thêm vào giỏ',
                style: TextStyle(
                  color: Colors.white
                ),
              ),
            ),
            ],
          ),
        ),
      ),
    );
  }
}
