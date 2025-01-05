//Use case params
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

  SearchProductParams({required this.keyword});
}

class AddCartItemParams {
  int productId;
  int? variantId;
  int quantity;

  AddCartItemParams({required this.productId, this.variantId, required this.quantity});
}

class DeleteCartItemParams  {
  int productId;
  int? variantId;

  DeleteCartItemParams({required this.productId, this.variantId});
}

class UpdateCartItemParams  {
  int productId;
  int? variantId;
  int quantity;

  UpdateCartItemParams({required this.productId, this.variantId, required this.quantity});
}


//Use case interface
abstract class UseCase<Type, Params> {
  Future<Type> call(Params params);
}
