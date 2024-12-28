import 'package:electro_shop/domain/entities/category_entity.dart';
import 'package:electro_shop/domain/repositories/category_repository.dart';
import 'package:electro_shop/domain/use_case/use_case.dart';

class GetCategories implements UseCase<List<CategoryEntity>, NoParams> {
  final CategoryRepository categoryRepository;
  GetCategories({required this.categoryRepository});

  @override
  Future<List<CategoryEntity>> call(NoParams params) async {
    return await categoryRepository.getCategories();
  }
}