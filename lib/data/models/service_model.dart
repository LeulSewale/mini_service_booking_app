class ServiceModel {
  final String id;
  final String name;
  final String category;
  final String imageUrl;
  final double price;
  final double rating;
  final String duration;
  final bool availability;

  ServiceModel({
    required this.id,
    required this.name,
    required this.category,
    required this.imageUrl,
    required this.price,
    required this.rating,
    required this.duration,
    required this.availability,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      imageUrl: json['imageUrl'],
      price: json['price'].toDouble(),
      rating: json['rating'].toDouble(),
      duration: json['duration'],
      availability: json['availability'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'imageUrl': imageUrl,
      'price': price,
      'rating': rating,
      'duration': duration,
      'availability': availability,
    };
  }
}
