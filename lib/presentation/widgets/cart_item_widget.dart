import 'package:electro_shop/domain/entities/product_item_entity.dart';
import 'package:electro_shop/presentation/bloc/cart_cubit.dart';
import 'package:electro_shop/presentation/utils/format_price.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';

class CartItemWidget extends StatefulWidget {
  const CartItemWidget({super.key, required this.productItem});
  final ProductItemEntity productItem;

  @override
  State<CartItemWidget> createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  Future<void> _updateCartItemQuantity (int quantity) async {
    await GetIt.instance<CartCubit>().updateCartItem(
        widget.productItem.product.id,
        widget.productItem.selectedVariant?.id,
        quantity
    );
  }
  @override
  Widget build(BuildContext context) {
    return Column(
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
                    widget.productItem.selectedVariant != null
                        ? widget.productItem.selectedVariant!.image
                        : widget.productItem.product.image,
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.productItem.product.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 5),
                      if(widget.productItem.selectedVariant != null)
                        Row(
                          children: [
                            const Text(
                              'Phân loại:',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              widget.productItem.selectedVariant!.optionName,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            )
                          ],
                        ),
                      const SizedBox(height: 5),
                      Text(
                        formatPrice(widget.productItem.selectedVariant != null
                            ? widget.productItem.selectedVariant!.price
                            : widget.productItem.product.price),
                        style: const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: () {
                                int quantity = widget.productItem.quantity;
                                if(quantity >= 1) {
                                  _updateCartItemQuantity(quantity - 1);
                                }
                              },
                            ),
                            Text(widget.productItem.quantity.toString()),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () {
                                _updateCartItemQuantity(widget.productItem.quantity + 1);
                              },
                            ),
                            IconButton(
                                onPressed: () {
                                  GetIt.instance<CartCubit>().deleteCartItem(
                                      widget.productItem.product.id,
                                      widget.productItem.selectedVariant?.id
                                  );
                                },
                                icon: const Icon(FontAwesomeIcons.xmark)
                            )
                          ],
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
