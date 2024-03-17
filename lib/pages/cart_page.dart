import 'package:e_commerce/cart_bloc/cart_bloc.dart';
import 'package:e_commerce/cart_bloc/cart_event.dart';
import 'package:e_commerce/cart_bloc/cart_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gap/gap.dart';

import '../model/product_model.dart';
import 'detailPage.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
      ),
      body: Container(
        child: BlocBuilder<CartBloc,CartState>(
          builder: (context,state)
          {
            return Container(
              child: ListView.builder(
                itemCount: state.items.length,
                itemBuilder: (context,index)
                {
                  return ProductTile(product: state.items[index]);
                }
                ),
            );
          },
        ),
      )
    );
  }
}



class ProductTile extends StatelessWidget {
  Product product;
  ProductTile({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()
      {
        Navigator.push(context,MaterialPageRoute(builder: (context)=>ProductDetailPage(product: product)));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 135,
          width: MediaQuery.sizeOf(context).width,
          child: Row(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10)),
                          image: DecorationImage(
                              image: NetworkImage(product!.thumbnail!),
                              fit: BoxFit.cover)),
                    ),
                    Positioned(
                        child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child:
                              Text(product.discountPercentage.toString() + "%",style: TextStyle(fontSize: 10,color: Colors.white),),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ))
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topRight: Radius.circular(10),bottomRight: Radius.circular(10)),
                  color: Colors.white,
                  ),
                  padding: EdgeInsets.all(5),
                  // color: Colors.amber,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      RatingBar.builder(
                        onRatingUpdate: (value) {},
                        initialRating: product!.rating!,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        ignoreGestures: true,
                        itemCount: 5,
                        itemSize: 20,
                        // itemPadding:
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                      ),
                      Text(product!.brand!,maxLines: 1,overflow: TextOverflow.ellipsis,),
                      Text(product!.title!,maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,),),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            product!.price.toString() + "\$",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                decoration: TextDecoration.lineThrough,
                                fontWeight: FontWeight.w600),
                          ),
                          Gap(10),
                          Text(
                            product!.discountPercentage.toString() + '\$',
                            style: TextStyle(
                                color: Colors.red, fontWeight: FontWeight.w600),
                          ),
                          
                        ],
                      ),
                      Gap(5),
                      ElevatedButton(onPressed: (){
                            context.read<CartBloc>().add(removeToCartEvent(item: product));
                            // context.read<CartBloc>().add(addToCartEvent(item: product));
                          }, 
                          child: Text("Remove"),
                          )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
