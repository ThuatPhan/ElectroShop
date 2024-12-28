import 'package:electro_shop/domain/entities/category_entity.dart';
import 'package:electro_shop/domain/use_case/get_categories.dart';
import 'package:electro_shop/domain/use_case/use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class CategoriesState {}

class LoadingCategories extends CategoriesState {}

class CategoriesLoadSuccess extends CategoriesState {
  final List<CategoryEntity> categories;

  CategoriesLoadSuccess({required this.categories});
}

class CategoriesLoadFailed extends CategoriesState {
  final String message;

  CategoriesLoadFailed({required this.message});
}

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit ({required this.useCase}) : super(LoadingCategories());
  final GetCategories useCase;
  Future<void> getCategories () async {
    try {
      emit(LoadingCategories());
      List<CategoryEntity> categories = await useCase.call(NoParams());
      emit(CategoriesLoadSuccess(categories: categories));
    } catch (e) {
      emit(CategoriesLoadFailed(message: e.toString()));
    }
  }
}
