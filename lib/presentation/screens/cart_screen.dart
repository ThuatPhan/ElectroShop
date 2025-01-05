import 'package:electro_shop/constants.dart';
import 'package:electro_shop/presentation/bloc/cart_item_cubit.dart';
import 'package:electro_shop/presentation/screens/checkout_screen.dart';
import 'package:electro_shop/presentation/utils/format_price.dart';
import 'package:electro_shop/presentation/utils/theme_provider.dart';
import 'package:electro_shop/presentation/widgets/cart_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  double _totalAmount = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Align(
          alignment: Alignment.center,
          child: Text(
              'Giỏ hàng',
              style: TextStyle(
                  fontSize: headerSize
              )
          ),
        ),
      ),
      body: BlocProvider.value(
        value: GetIt.instance<CartItemCubit>(),
        child: RefreshIndicator(
          onRefresh: () async{
            await GetIt.instance<CartItemCubit>().getCartItems();
          },
          child: BlocBuilder<CartItemCubit, CartItemState>(
            builder: (context, state) {
              if (state is LoadingCartItems) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is CartItemsLoadSuccess) {
                final cartItems = state.cartItems;

                if(cartItems.isEmpty) {
                  return const Center(
                    child: Text("Giỏ hàng trống"),
                  );
                }

                _totalAmount = cartItems.fold(0.0, (previousValue, element) {
                  return previousValue +
                      (element.selectedVariant != null
                          ? (element.selectedVariant!.price * element.quantity)
                          : (element.product.price * element.quantity));
                });
                
                return Stack(
                  children: [
                    ListView.builder(
                      padding: const EdgeInsets.only(bottom: 100),
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) {
                        return CartItemWidget(
                          productItem: cartItems[index],
                        );
                      },
                    ),
                    if (cartItems.isNotEmpty)
                      Consumer<ThemeProvider>(
                        builder: (context, value, child) => Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Card(
                            margin: EdgeInsets.zero,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8.0),
                                topRight: Radius.circular(8.0),
                              ),
                            ),
                            color: value.themeMode == ThemeMode.light ? Colors.white : Colors.black,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('Tổng tiền'),
                                      Text(
                                        formatPrice(_totalAmount),
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
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => CheckoutScreen(products: cartItems),
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      'Tiếp tục thanh toán',
                                      style: TextStyle(fontSize: 16, color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                );
              }

              if (state is CartItemsLoadFailed) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                });
                return const Center(child: Text("Không tải được giỏ hàng"));
              }

              return Container();
            },
          ),
        ),
      ),
    );
  }
}





