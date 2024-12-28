import 'package:electro_shop/data/models/category_model.dart';

abstract class CategoryApiSource {
  Future<List<CategoryModel>> fetchGetCategories ();
}