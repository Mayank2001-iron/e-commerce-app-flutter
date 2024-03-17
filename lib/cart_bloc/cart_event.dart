
import 'package:e_commerce/model/product_model.dart';

class CartEvent{

}

class addToCartEvent extends CartEvent{
  Product item;
  addToCartEvent({required this.item});
}

class removeToCartEvent extends CartEvent{
  Product item;
  removeToCartEvent({required this.item});
}