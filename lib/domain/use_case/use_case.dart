class NoParams {}

class GetProductsParams {
  int pageNumber;
  int pageSize;

  GetProductsParams({required this.pageNumber, required this.pageSize});
}

class GetProductParams{
  int id;
  GetProductParams({required this.id});
}

class GetProductOfCategoryParams{
  int categoryId;
  int pageNumber;
  int pageSize;
  GetProductOfCategoryParams({required this.categoryId,required this.pageNumber,required this.pageSize});
}

class SearchProductParams {
  String keyword;
  int pageNumber;
  int pageSize;

  SearchProductParams({required this.keyword, required this.pageNumber, required this.pageSize});
}

abstract class UseCase<Type, Params> {
  Future<Type> call(Params params);
}
