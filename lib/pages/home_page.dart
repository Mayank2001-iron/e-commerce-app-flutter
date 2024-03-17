import 'package:e_commerce/api/api_model.dart';
import 'package:e_commerce/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';

import 'detailPage.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text("Products"),
      ),
      body: FutureBuilder(
          future: ApiCalls.getProducts(),
          builder: (context, data) {
            if (data.hasData) {
              var item = data.data as ProductsModel;
              return Container(
                height: MediaQuery.sizeOf(context).height,
                width: MediaQuery.sizeOf(context).width,
                child: ListView.builder(
                    itemCount: item.products!.length,
                    itemBuilder: (context, index) {
                      return ProductTile(product: item.products![index]);
                    }),
              );
            } else if (data.hasError) {
              return Center(
                child: Container(
                  child: LottieBuilder.asset('assets/lottie/error.json'),
                ),
              );
            } else {
              return Center(
                child: Container(
                  child: Lottie.asset('assets/lottie/loading.json'),
                ),
              );
            }
          }),
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
          height: 100,
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
