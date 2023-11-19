class Property {
  String type;
  int minPrice;
  int maxPrice;
  String imageUrl;

  Property({
    required this.type,
    required this.minPrice,
    required this.maxPrice,
    required this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'minPrice': minPrice,
      'maxPrice': maxPrice,
      'imageUrl': imageUrl,
    };
  }

  factory Property.fromMap(Map<String, dynamic> map) {
    return Property(
      type: map['type'],
      minPrice: map['minPrice'],
      maxPrice: map['maxPrice'],
      imageUrl: map['imageUrl'],
    );
  }
}
