import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../providers/auth_provider.dart';
import '../providers/cart_provider.dart';
import '../providers/order_provider.dart';

class CartPage extends ConsumerStatefulWidget {

  @override
  ConsumerState<CartPage> createState() => _CartPageState();
}

class _CartPageState extends ConsumerState<CartPage> {

  bool isLoad = false;

  @override
  Widget build(BuildContext context) {
    final cartData = ref.watch(cartProvider);
    final total = ref.watch(cartProvider.notifier).total;
    final userData = ref.watch(authProvider);
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          automaticallyImplyLeading: true,
          title: Text('Cart',style: TextStyle(color: Colors.black),),
        ),
        body: SafeArea(
            child: cartData.isEmpty ? Center(child: Text('Add Some Product To cart')):
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  Expanded(
                      child: ListView.builder(
                          itemCount: cartData.length,
                          itemBuilder:(context, index){
                            final cart = cartData[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(

                                width: 370.w,
                                height: 200.h,
                                child: Column(
                                  children: [


                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        CircleAvatar(
                                            radius: 60,
                                            backgroundImage: NetworkImage(cart.productImage)),
                                        Text(cart.productName,style: TextStyle(color: Colors.black,fontSize: 20.sp,fontWeight: FontWeight.bold),),
                                        IconButton(onPressed: (){
                                          ref.read(cartProvider.notifier).removeFromCart(cart);
                                        },icon: Icon(Icons.close,color: Colors.black,),),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Container(
                                      // margin: EdgeInsets.only(top: 70),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(

                                            children: [
                                              OutlinedButton(
                                                  style: IconButton.styleFrom(
                                                    backgroundColor: Colors.red
                                                  ),
                                                  onPressed: (){
                                                ref.read(cartProvider.notifier).singleAdd(cart);
                                              }, child: Icon(Icons.add,color: Colors.white,)),
                                              Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                child: Text('X  ${cart.quantity}',style: TextStyle(color: Colors.black),),
                                              ),
                                              OutlinedButton(
                                                  style: IconButton.styleFrom(
                                                      backgroundColor: Colors.red
                                                  ),
                                                  onPressed: (){
                                                ref.read(cartProvider.notifier).singleRemove(cart);
                                              }, child:Icon(Icons.remove,color: Colors.white,)),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 20),
                                            child: Text('Rs. ${cart.price}',style: TextStyle(color: Colors.black,fontSize: 25.sp),),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Divider(
                                      thickness: 2,
                                      height: 1,
                                      color: Colors.black,
                                    )
                                  ],
                                ),
                              ),
                            );
                          }
                      )
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Total:-',style: TextStyle(color: Colors.black,fontSize: 30.sp),),
                            Text('$total',style: TextStyle(color: Colors.black,fontSize: 30.sp))
                          ],
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red
                        ),
                          onPressed: () async{
                            setState(() {
                              isLoad = true;
                            });
                            final response = await ref.read(order).orderCreate(total, cartData, userData.user!.id, userData.user!.token);
                            setState(() {
                              isLoad = false;
                            });

                            if(response == 'success'){
                              ref.read(cartProvider.notifier).cartClear();
                            }


                          }, child: isLoad ? Center(child: CircularProgressIndicator(
                        color: Colors.white,
                      )): Text('CheckOut'))
                    ],
                  )
                ],
              ),
            )
        )
    );
  }
}