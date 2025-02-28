import 'product_model.dart';

class CartModel {
  int? id;
  ProductModel? product;
  int? quantity;

  CartModel({
    required this.id,
    required this.product,
    required this.quantity,
  });

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product = json['product'] != null ? ProductModel.fromJson(json['product']) : null;
    quantity = json['quantity'] ?? 1; // Default quantity to 1 if missing
  }


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product': product!.toJson(),
      'quantity': quantity,
    };
  }

  double getTotalPrice() {
    return product!.price! * quantity!;
  }
}
