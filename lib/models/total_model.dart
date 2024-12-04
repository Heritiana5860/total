class TotalModel {
  String item;
  double price;

  TotalModel({required this.item, required this.price});

  factory TotalModel.fromMap(Map<String, dynamic> json) {
    return TotalModel(
      item: json['item'],
      price: json['price'],
    );
  }

  // Conversion d'un objet en map
  Map<String, dynamic> toMap() {
    return {
      'item': item,
      'price': price,
    };
  }

  @override
  String toString() => 'TotalModel(item: $item, price: $price)';
}
