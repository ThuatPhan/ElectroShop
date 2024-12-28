class PagedModel<T> {
  final int remainingItems;
  final List<T> items;

  PagedModel({required this.remainingItems, required this.items});

  factory PagedModel.fromJson(Map<String, dynamic> json) {
    return PagedModel(
        remainingItems: json['remainingItems'],
        items: json['items']
    );
  }
}
