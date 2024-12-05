class TotalModel {
  String item;
  double price;
  int? id;

  TotalModel({required this.item, required this.price, this.id});

  factory TotalModel.fromMap(Map<String, dynamic> json) {
    return TotalModel(
      item: json['item'],
      price: (json['price'] as num).toDouble(),
      id: json['id'],
    );
  }

  // Conversion d'un objet en map
  Map<String, dynamic> toMap() {
    return {
      'item': item,
      'price': price,
      'id': id,
    };
  }

  @override
  String toString() => 'TotalModel(id: $id, item: $item, price: $price)';
}
