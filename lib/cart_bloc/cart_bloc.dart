
import 'package:e_commerce/cart_bloc/cart_event.dart';
import 'package:e_commerce/cart_bloc/cart_state.dart';
import 'package:e_commerce/model/product_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartBloc extends Bloc<CartEvent,CartState>
{
  List<Product> cartItems = [];
  CartBloc({required this.cartItems}) : super(initializeCart(items: []))
  {
    on<addToCartEvent>((event,emit){
      cartItems.add(event.item);
      print(event.item.brand);
      emit(addedToCartState(items: cartItems));
    });
    on<removeToCartEvent>((event,emit){
      cartItems.remove(event.item);
      emit(removedFromCarState(items: cartItems));
    });
  }

}