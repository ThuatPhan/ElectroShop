import 'package:electro_shop/presentation/bloc/cart_item_cubit.dart';
import 'package:electro_shop/presentation/utils/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;

class CartIconWidget extends StatelessWidget {
  const CartIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8.0),
      child: IconButton(
        onPressed: () {},
        icon: BlocProvider.value(
          value: GetIt.instance<CartItemCubit>(),
          child: BlocBuilder<CartItemCubit, CartItemState>(
            builder: (context, state) {
              int numberOfItems = 0;

              if (state is CartItemsLoadSuccess) {
                numberOfItems = state.numberOfItem;
              }

              return GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/cart'),
                child: badges.Badge(
                  showBadge: numberOfItems > 0,
                  position: badges.BadgePosition.topEnd(top: -15, end: -15),
                  badgeContent: Text('$numberOfItems'),
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
              );
            },
          ),
        ),
      ),
    );
  }
}
