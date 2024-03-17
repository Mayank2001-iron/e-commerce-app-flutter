import '../model/product_model.dart';

class CartState{
  List<Product> items;
  CartState({required this.items});
}
class initializeCart extends CartState{
  initializeCart({required super.items});
  
}


class addedToCartState extends CartState{
  addedToCartState({required super.items});
  // List<Product> cartItems;
  // addedToCartState({required this.cartItems});
}

class removedFromCarState extends CartState{
  removedFromCarState({required super.items});

}