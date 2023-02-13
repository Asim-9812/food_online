import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../providers/auth_provider.dart';
import '../../providers/order_provider.dart';


class OrderHistory extends ConsumerWidget{

  @override
  Widget build(BuildContext context, ref) {
    final auth = ref.watch(authProvider);
    final history = ref.watch(orderHistory(auth.user!.id));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.white,
        body: SafeArea(
            child: history.when(
                data: (data){
                  return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index){
                        return ExpansionTile(
                          title: Text(data[index].dateTime,style: TextStyle(color: Colors.black),),
                          children: data[index].products.map((e){

                            return  Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.network(e.productImage, height: 90,width: 90,fit: BoxFit.cover,),
                                ),

                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 90,
                                    child: Column(
                                      children: [
                                        Text(e.productName,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 30.sp)),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 20),
                                          child: Text('Rs. ${e.price}',style: TextStyle(color: Colors.black)),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            );
                          }).toList(),
                        );
                      }
                  );
                },
                error: (err, stack) => Text('$err'),
                loading: () => Center(child: CircularProgressIndicator())
            )
        )
    );
  }
}