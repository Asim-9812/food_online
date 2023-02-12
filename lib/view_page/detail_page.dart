import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../providers/cart_provider.dart';
import '../states/products.dart';

class DetailPage extends StatelessWidget {
  final Product product;
  DetailPage(this.product);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        automaticallyImplyLeading: true,
      ),
        body: SafeArea(
            child: Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: CircleAvatar(
                            radius: 100,
                            backgroundImage: NetworkImage(
                              product.image,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.product_name,
                                style: TextStyle(fontSize: 45.sp,color: Colors.black,fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(product.product_detail,style: TextStyle(color: Colors.black,fontSize: 30.sp),),
                                  Text('Rs. ${product.price}',
                                      style: TextStyle(fontSize: 35.sp,color: Colors.black)),
                                ],
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
                  Container(
                    height: 100.h,
                    child: Padding(
                      padding: const EdgeInsets.all(9.0),
                      child: Consumer(builder: (context, ref, child) {
                        return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            minimumSize: Size.fromWidth(double.infinity)
                          ),
                            onPressed: () {
                              ref.read(cartProvider.notifier).addToCart(product, context);
                            }, child: Text('Add To Cart'));
                      }),
                    ),
                  )
                ],
              ),
            )));
  }
}