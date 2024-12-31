import 'package:badges/badges.dart' as badges;
import 'package:electro_shop/constants.dart';
import 'package:electro_shop/domain/entities/product_item_entity.dart';
import 'package:electro_shop/presentation/screens/payments_success_screen.dart';
import 'package:electro_shop/presentation/utils/format_price.dart';
import 'package:electro_shop/presentation/utils/theme_provider.dart';
import 'package:electro_shop/presentation/widgets/product_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key, required this.products});

  final List<ProductItemEntity> products;

  double _calculateTotalAmount() {
    double total = products.fold(0.0, (previousValue, element) {
      return previousValue + (element.selectedVariant != null
          ? element.selectedVariant!.price
          : element.product.price);
    });
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Thanh toán',
            style: TextStyle(fontSize: headerSize)
          )
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 8),
            child: IconButton(
              onPressed: () {},
              icon: badges.Badge(
                position: badges.BadgePosition.topEnd(top: -15, end: -15),
                badgeContent: const Text('3'),
                child: Consumer<ThemeProvider>(
                  builder: (context, themeProvider, _) {
                    return Icon(
                      FontAwesomeIcons.cartShopping,
                      color: themeProvider.themeMode == ThemeMode.dark
                          ? Colors.white
                          : Colors.black,
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index].product;
                  final selectedVariant = products[index].selectedVariant;
                  return ProductItemWidget(product: product, selectedVariant: selectedVariant);
                },
            ),
          ),
          Card(
            margin: const EdgeInsets.only(top: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Đơn hàng',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Tổng tiền (${products.length} sản phẩm)'),
                      Text(
                        formatPrice(_calculateTotalAmount()),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      backgroundColor: const Color(buttonPrimaryColor),
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const PaymentsSuccessScreen(),));
                    },
                    child: const Text(
                      'Chọn phương thức thanh toán',
                      style: TextStyle(fontSize: 16, color: Colors.white),
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

