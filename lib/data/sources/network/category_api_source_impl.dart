import 'package:electro_shop/data/models/category_model.dart';
import 'package:electro_shop/data/sources/network/api_source.dart';
import 'package:electro_shop/data/sources/network/category_api_source.dart';

class CategoryApiSourceImpl implements CategoryApiSource{
  final ApiSource apiSource;
  CategoryApiSourceImpl({required this.apiSource});
  
  @override
  Future<List<CategoryModel>> fetchGetCategories () async {
    return await apiSource
        .getList<CategoryModel>('category', fromJson: (json) => CategoryModel.fromJson(json));
  }
}