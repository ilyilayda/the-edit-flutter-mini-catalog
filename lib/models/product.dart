class Product {
  final int id;
  final String name;
  final String category;
  final int price;
  final String description;
  final String image;
  final double rating;

  const Product(
      {required this.id,
      required this.name,
      required this.category,
      required this.price,
      required this.description,
      required this.image,
      required this.rating});

  factory Product.fromJson(Map<String, dynamic> json) => Product(
      id: json['id'] as int,
      name: json['name'] as String,
      category: json['category'] as String,
      price: json['price'] as int,
      description: json['description'] as String,
      image: json['image'] as String,
      rating: (json['rating'] as num).toDouble());

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'category': category,
        'price': price,
        'description': description,
        'image': image,
        'rating': rating
      };
}
