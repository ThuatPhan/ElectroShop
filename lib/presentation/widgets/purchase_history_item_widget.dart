import 'package:flutter/material.dart';
import 'package:electro_shop/domain/entities/order_entity.dart';
import 'package:electro_shop/domain/entities/product_item_entity.dart';
import 'package:electro_shop/presentation/screens/order_detail_screen.dart';
import 'package:electro_shop/presentation/utils/format_price.dart';

class PurchaseHistoryItemWidget extends StatefulWidget {
  const PurchaseHistoryItemWidget({
    super.key,
    required this.orderEntity,
  });

  final OrderEntity orderEntity;

  @override
  _PurchaseHistoryItemWidgetState createState() =>
      _PurchaseHistoryItemWidgetState();
}

class _PurchaseHistoryItemWidgetState extends State<PurchaseHistoryItemWidget> {
  late OrderEntity _orderEntity;

  @override
  void initState() {
    super.initState();
    _orderEntity = widget.orderEntity; // Lưu trữ orderEntity ban đầu
  }

  // Giả sử bạn có một phương thức để cập nhật lại đơn hàng khi thanh toán thành công
  void _updateOrder(OrderEntity newOrderEntity) {
    setState(() {
      _orderEntity = newOrderEntity;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ProductItemEntity firstProduct = _orderEntity.items[0];

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => OrderDetailScreen(order: _orderEntity)),
      ),
      child: Column(
        children: [
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
                      firstProduct.selectedVariant != null
                          ? firstProduct.selectedVariant!.image
                          : firstProduct.product.image,
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Tên sản phẩm
                        Text(
                          firstProduct.product.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 5),

                        // Phân loại sản phẩm
                        if (firstProduct.selectedVariant != null) ...[
                          Row(
                            children: [
                              const Text(
                                'Phân loại: ',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  firstProduct.selectedVariant!.name,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],

                        const SizedBox(height: 5),

                        // Tổng tiền và giá
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Tổng tiền (${_orderEntity.items.fold<int>(0, (previousValue, item) => previousValue + item.quantity)} sản phẩm):',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),

                            Text(
                              formatPrice(_orderEntity.totalAmount),
                              style: const TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
