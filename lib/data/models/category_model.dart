import 'package:electro_shop/domain/entities/category_entity.dart';

class CategoryModel extends CategoryEntity {
  final int id;
  final String name;
  final String icon;

  CategoryModel({required this.id, required this.name, required this.icon})
      : super(id: id, name: name, icon: icon);

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
        id: json['id'], name: json['name'], icon: json['icon']);
  }
}
