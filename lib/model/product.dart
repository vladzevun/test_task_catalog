class Product {
  int? id;
  String? name;
  double? price;
  String? description;

  Product({
    this.id,
    this.name,
    this.price,
    this.description
  });

  factory Product.fromJSON(Map<String,dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      description: json['description'],
    );
  }

  Map<String,dynamic> toJSON() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'description': description,
    };
  }
}