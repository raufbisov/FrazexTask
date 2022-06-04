class Product {
  int? id;
  String? title;
  double? price;
  String? description;
  String? category;
  String? error;

  Product({this.id, this.title, this.price, this.description, this.category});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = json['price'];
    description = json['description'];
    category = json['category'];
  }

  Product.error(String errorMessage) {
    error = errorMessage;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id!;
    data['title'] = title!;
    data['price'] = price!;
    data['description'] = description!;
    data['category'] = category!;
    return data;
  }
}
