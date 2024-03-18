import 'package:e_commerce/cart_bloc/cart_bloc.dart';
import 'package:e_commerce/cart_bloc/cart_event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../model/product_model.dart';

class ProductDetailPage extends StatelessWidget {
  Product product;
  ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {
              context.read<CartBloc>().add(addToCartEvent(item: product));
            },
            child: Padding(
              padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
              child: Text(
                "ADD TO CART",
                style: TextStyle(color: Colors.white),
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
          ),
        ),
      ),
      appBar: AppBar(
        title: Text(product.title!),
        centerTitle: true,
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.share))],
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                
                PageView.builder(
                    itemCount: product.images!.length,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(product.images![index]),
                                fit: BoxFit.fitHeight)),
                      );
                    }),
      
                Positioned(
                  top: 5,
                  right: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: MaterialButton(
                        color: Colors.grey[200],
                                        onPressed: () {},
                                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.favorite_outline_rounded),
                                        ),
                                        shape: CircleBorder(),
                                        elevation: 10,
                                      ),
                    )),
              ],
            ),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      product.brand!,
                      style:GoogleFonts.lato(fontSize:24,fontWeight:FontWeight.w900),
                    ),
                    Gap(4),
                    Text(
                      "\$" + product.price.toString(),
                      style: GoogleFonts.lato(fontSize:24,fontWeight:FontWeight.w900),
                    ),
                  ],
                ),
                Text(product.title!,style: GoogleFonts.lato(fontSize:10,fontWeight:FontWeight.w400),),
                Gap(4),
                Row(
                  children: [
                    RatingBar.builder(
                      onRatingUpdate: (value) {},
                      ignoreGestures: true,
                      initialRating: product!.rating!,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 13,
                      // itemPadding
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                    ),
                    Gap(3),
                    Text("(" + product.rating.toString() + ")",style: GoogleFonts.lato(fontSize:10,fontWeight:FontWeight.w400),),
                  ],
                ),
                Gap(30),
                Expanded(
                    child: Text(
                  product.description!,
                  style: GoogleFonts.lato(fontSize:14,fontWeight:FontWeight.w900),
                )),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
