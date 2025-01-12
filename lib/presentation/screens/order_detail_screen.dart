import 'package:electro_shop/presentation/utils/format_price.dart';
import 'package:flutter/material.dart';
import 'package:electro_shop/domain/entities/order_entity.dart';

class OrderDetailScreen extends StatelessWidget {
  final OrderEntity order;

  const OrderDetailScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    // Tạo danh sách mở rộng, mỗi sản phẩm lặp lại theo số lượng của nó
    final expandedItems = order.items.expand((item) {
      return List.generate(item.quantity, (_) => item);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chi tiết mua hàng'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hiển thị tổng tiền và tổng số lượng sản phẩm
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Tổng tiền (${order.items.fold<int>(0, (sum, item) => sum + item.quantity)} sản phẩm): ${formatPrice(order.totalAmount)}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          const Divider(),
          // Hiển thị danh sách sản phẩm
          Expanded(
            child: ListView.builder(
              itemCount: expandedItems.length,
              itemBuilder: (context, index) {
                final product = expandedItems[index];
                final productPrice =
                product.selectedVariant != null ? product.selectedVariant!.price : product.product.price;

                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Hình ảnh sản phẩm
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            product.selectedVariant != null
                                ? product.selectedVariant!.image
                                : product.product.image,
                            height: 80,
                            width: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 8),
                        // Thông tin sản phẩm
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.product.name,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              if (product.selectedVariant != null) ...[
                                Text(
                                  'Phân loại: ${product.selectedVariant!.name}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                              const SizedBox(height: 4),
                              Text(
                                'Thành tiền: ${formatPrice(productPrice)}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
