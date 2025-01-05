import 'dart:async';
import 'dart:convert';
import 'package:electro_shop/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LocationPicker extends StatefulWidget {
  @override
  _LocationPickerState createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, dynamic>> _suggestions = [];
  Timer? _debounce;

  @override
  void dispose() {
    _controller.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Chọn Vị Trí",
          style: TextStyle(
            fontSize: headerSize
          ),
        ),
      ),
      body: Column(
        children: [
          // Ô nhập địa chỉ
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              onChanged: (value) {
                if (_debounce?.isActive ?? false) _debounce?.cancel();
                _debounce = Timer(const Duration(milliseconds: 500), () {
                  _fetchSuggestions(value);
                });
              },
              decoration: const InputDecoration(
                labelText: "Nhập địa chỉ",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),

          // Danh sách gợi ý
          Expanded(
            child: ListView.builder(
              itemCount: _suggestions.length,
              itemBuilder: (context, index) {
                final suggestion = _suggestions[index];
                return ListTile(
                  title: Text(suggestion['display_name']),
                  onTap: () {
                    Navigator.pop(
                      context,
                      {
                        'address': suggestion['display_name'],
                        'latitude': suggestion['lat'],
                        'longitude': suggestion['lon'],
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _fetchSuggestions(String query) async {
    if (query.isEmpty) return;

    final url = "https://nominatim.openstreetmap.org/search?q=$query&format=json&addressdetails=1&limit=5&countrycodes=VN";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;

      setState(() {
        _suggestions.clear();

        _suggestions.addAll(data.map((item) {
          return {
            'display_name': item['display_name'],
            'lat': double.parse(item['lat']),
            'lon': double.parse(item['lon']),
          };
        }).toList());
      });
    } else {
      debugPrint("Error: ${response.statusCode}");
    }
  }
}
