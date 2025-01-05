import 'package:electro_shop/constants.dart';
import 'package:electro_shop/data/services/search_history_service.dart';
import 'package:electro_shop/presentation/utils/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class SearchBox extends StatelessWidget {
  const SearchBox({super.key});

  void _saveSearchKeyword(String keyword) {
    SearchHistoryService.saveSearchKeyword(keyword);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, value, child) {
        return Container(
          decoration: BoxDecoration(
            border: Border.all(
                width: 0.5,
                color: value.themeMode == ThemeMode.dark ? Colors.white : Colors.black
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            children: [
              const SizedBox(
                  width: 40,
                  child: Icon(FontAwesomeIcons.magnifyingGlass, size: 17)
              ),
              Expanded(
                child: TextField(
                  onSubmitted: (value) {
                    _saveSearchKeyword(value);
                    Navigator.pushReplacementNamed(
                        context,
                        '/search-result',
                        arguments: { 'keyword': value }
                    );
                  },
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
          )
        );
      },
    );
  }
}
