import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ProductModelUpdate {
    final String title;
  final int price;
  final String description;
  ProductModelUpdate({
    required this.title,
    required this.price,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'price': price,
      'description': description,
    };
  }

  factory ProductModelUpdate.fromMap(Map<String, dynamic> map) {
    return ProductModelUpdate(
      title: map['title'] as String,
      price: map['price'] as int,
      description: map['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModelUpdate.fromJson(String source) => ProductModelUpdate.fromMap(json.decode(source) as Map<String, dynamic>);
}
