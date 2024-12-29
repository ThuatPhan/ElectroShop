import 'package:electro_shop/constants.dart';
import 'package:electro_shop/presentation/utils/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class SearchWidget extends StatelessWidget {
  SearchWidget({super.key});
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) => Container(
        decoration: BoxDecoration(
          border: Border.all(
              width: 0.5,
              color: themeProvider.themeMode == ThemeMode.dark ? Colors.white : Colors.black
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            children: [
              const SizedBox(
                  width: 50,
                  child: Icon(FontAwesomeIcons.magnifyingGlass)
              ),
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Tìm tên sản phẩm ...',
                      hintStyle: TextStyle(
                          fontSize: titleSize
                      )
                  ),
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}
