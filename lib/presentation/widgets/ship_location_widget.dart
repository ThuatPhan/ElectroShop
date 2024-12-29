import 'package:electro_shop/constants.dart';
import 'package:electro_shop/presentation/utils/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShipLocationWidget extends StatelessWidget {
  const ShipLocationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return GestureDetector(
      onTap: () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Giao hàng tới',
            style: TextStyle(fontSize: titleSize, fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              const Text(
                '494 Lê Văn Việt, TP. Hồ Chí Minh',
                style: TextStyle(fontSize: titleSize),
              ),
              Icon(
                Icons.keyboard_arrow_down,
                size: 20,
                color: themeProvider.themeMode == ThemeMode.dark ? Colors.white : Colors.black,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
