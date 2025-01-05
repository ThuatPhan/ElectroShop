import 'package:electro_shop/constants.dart';
import 'package:electro_shop/data/services/search_history_service.dart';
import 'package:electro_shop/presentation/widgets/cart_icon_widget.dart';
import 'package:electro_shop/presentation/widgets/search_box.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Map<String, String>> recentItems = [];

  @override
  void initState() {
    super.initState();
    _loadSearchHistory();
  }

  void _loadSearchHistory() async {
    List<Map<String, String>> searchHistory = await SearchHistoryService.getSearchHistory();
    setState(() {
      recentItems = searchHistory;
    });
  }

  void _removeSearchKeyword(String id) {
    SearchHistoryService.removeSearchKeyword(id);
    _loadSearchHistory();
  }

  void _clearSearchHistory() {
    SearchHistoryService.clearSearchHistory();
    setState(() {
      recentItems = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const SearchBox(),
        actions: const [
          CartIconWidget()
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Gần đây",
                  style: TextStyle(fontSize: headerSize, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: _clearSearchHistory,
                  child: const Text(
                    "Xoá tất cả",
                    style: TextStyle(fontSize: titleSize, color: Colors.red),
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: recentItems.length,
                itemBuilder: (context, index) {
                  final item = recentItems[index];
                  return GestureDetector(
                    onTap: () => Navigator.pushNamed(
                      context,
                      '/search-result',
                      arguments: {'keyword': item['keyword']},
                    ),
                    child: ListTile(
                      leading: const Icon(FontAwesomeIcons.clock),
                      title: Text(
                        item['keyword']!,
                        style: const TextStyle(fontSize: titleSize),
                      ),
                      trailing: IconButton(
                        icon: const Icon(FontAwesomeIcons.xmark),
                        onPressed: () => _removeSearchKeyword(item['id']!),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
