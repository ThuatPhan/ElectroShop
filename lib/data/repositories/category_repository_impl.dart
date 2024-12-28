import 'package:electro_shop/data/sources/network/category_api_source.dart';
import 'package:electro_shop/domain/entities/category_entity.dart';
import 'package:electro_shop/domain/repositories/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryApiSource categoryApiSource;
  CategoryRepositoryImpl({required this.categoryApiSource});

  @override
  Future<List<CategoryEntity>> getCategories() async {
    return await categoryApiSource.fetchGetCategories();
  }

}