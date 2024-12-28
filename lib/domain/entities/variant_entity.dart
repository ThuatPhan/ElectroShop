class VariantEntity {
  final int id;
  final int productId;
  final String optionName;
  final String name;
  final String? image;
  final double price;
  final int stock;

  VariantEntity(
      {required this.id,
      required this.productId,
      required this.optionName,
      required this.name,
      required this.image,
      required this.price,
      required this.stock});
}
