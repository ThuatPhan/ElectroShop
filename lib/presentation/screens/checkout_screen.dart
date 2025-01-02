import 'dart:convert';

import 'package:badges/badges.dart' as badges;
import 'package:electro_shop/constants.dart';
import 'package:electro_shop/data/services/auth_service.dart';
import 'package:electro_shop/domain/entities/product_item_entity.dart';
import 'package:electro_shop/presentation/utils/format_price.dart';
import 'package:electro_shop/presentation/utils/theme_provider.dart';
import 'package:electro_shop/presentation/widgets/product_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart' as stripe;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key, required this.products});

  final List<ProductItemEntity> products;

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String? clientSecret;

  double _calculateTotalAmount() {
    double total = widget.products.fold(0.0, (previousValue, element) {
      return previousValue + (
          element.selectedVariant != null
          ? (element.selectedVariant!.price * element.quantity)
          : (element.product.price * element.quantity)
      );
    });
    return total;
  }

  Future<void> createPaymentIntent() async {
    String url = '${apiUrl}payment/create-intent';
    List<Map<String, dynamic>> items = widget.products.map((product) => {
      'productId': product.product.id,
      'variantId': product.selectedVariant?.id,
      'quantity': product.quantity,
      'price': product.selectedVariant != null ? product.selectedVariant!.price : product.product.price
    }).toList();

    try {
      final token = await AuthService.instance.getAccessToken();
      final response = await post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'},
        body: jsonEncode({
          'items': items
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        setState(() {
          clientSecret = jsonResponse['clientSecret'];
        });
        if (clientSecret != null) {
          await showPaymentSheet();
        }
      } else {
        throw Exception('Failed to create payment intent');
      }
    } catch (e) {
      debugPrint('Error creating payment intent: $e');
    }
  }

  Future<void> showPaymentSheet() async {
    try {
      await stripe.Stripe.instance.initPaymentSheet(
        paymentSheetParameters: stripe.SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret!,
          merchantDisplayName: 'ShopDuck',
        ),
      );

      await stripe.Stripe.instance.presentPaymentSheet();
      Navigator.pushReplacementNamed(context, '/payment-success');
    } on stripe.StripeException catch (e) {
      if (e.error.localizedMessage!.contains("canceled")) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Thanh toán đã bị huỷ")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Stripe error: ${e.error.localizedMessage}")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Thanh toán thất bại: ${e.toString()}")),
      );
    }
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
                itemCount: widget.products.length,
                itemBuilder: (context, index) {
                  final product = widget.products[index].product;
                  final selectedVariant = widget.products[index].selectedVariant;
                  final quantity = widget.products[index].quantity;
                  return ProductItemWidget(
                      productItemEntity: ProductItemEntity(
                          product: product,
                          selectedVariant: selectedVariant,
                          quantity: quantity
                      )
                  );
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
                      Text('Tổng tiền (${widget.products.length} sản phẩm)'),
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
                      createPaymentIntent();
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

