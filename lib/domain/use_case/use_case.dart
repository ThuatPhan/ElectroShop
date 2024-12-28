class NoParams {}

class GetProductsParams {
  int pageNumber;
  int pageSize;

  GetProductsParams({required this.pageNumber, required this.pageSize});
}

abstract class UseCase<Type, Params> {
  Future<Type> call(Params params);
}
