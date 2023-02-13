import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../providers/cart_provider.dart';
import '../states/products.dart';

class DetailPage extends ConsumerWidget {
  final Product product;
  DetailPage(this.product);
  @override
  Widget build(BuildContext context,ref) {

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
                  Stack(
                    children:[ Container(
                      width: double.infinity,
                      height: 500.h,
                      // color: Colors.red,

                      child: Card(
                        color: Colors.white,
                        semanticContainer: true,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(500.0),
                        ),
                        elevation: 5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 30.h,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                product.product_name,
                                style: TextStyle(fontSize: 30.sp,color: Colors.black,fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(product.product_detail,style: TextStyle(color: Colors.grey,fontSize: 22.sp)),
                            ),
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

                                  SizedBox(
                                    height: 20,
                                  ),

                                ],
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                    
                      Positioned(
                        left: 18.w,
                          bottom: 60.h,
                          child: TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.red,
                              ),
                              onPressed: (){}, child: Text('S',style: TextStyle(fontSize: 25.sp,color: Colors.white),))),
                      Positioned(
                        left: 170.w,
                          bottom: 0.h,
                          child: TextButton(

                              style: TextButton.styleFrom(
                                backgroundColor: Colors.red
                              ),
                              onPressed: (){}, child: Text('M',style: TextStyle(fontSize: 25.sp,color: Colors.white),))),
                      Positioned(
                        right: 18.w,
                          bottom: 60.h,
                          child: TextButton(

                              style: TextButton.styleFrom(
                                backgroundColor: Colors.red
                              ),
                              onPressed: (){}, child: Text('L',style: TextStyle(fontSize: 25.sp,color: Colors.white),))),

                    
                    ]
                  ),
                  SizedBox(
                    height: 200.h,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Rs. ${product.price}',
                          style: TextStyle(fontSize: 35.sp,color: Colors.black)),
                      Container(
                        height: 60.h,
                        width: 120.w,
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
                      ),
                    ],
                  )
                ],
              ),
            )));
  }
}