


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../services/crud_service.dart';
import 'detail_page.dart';

class FeedPage extends ConsumerStatefulWidget {

  @override
  ConsumerState<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends ConsumerState<FeedPage> {


  @override
  Widget build(BuildContext context) {

    final productData = ref.watch(products);
    return Column(
      children: [
        Container(
          height: 230.h,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: productData.when(
              data: (data){
                return ListView.builder(
                  itemCount: data.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index){
                    return  InkWell(
                      onTap: (){
                        Get.to(() => DetailPage(data[index]));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 180.h,
                          width: 120.w,
                          child: Card(
                            color: Colors.white,
                            semanticContainer: true,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.network(data[index].image, height: 80.h,width: 80.w,fit: BoxFit.cover,),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(data[index].product_name,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(Icons.arrow_circle_right_rounded,color: Colors.black,),
                                )
                              ],
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            elevation: 5,
                            // margin: EdgeInsets.all(10),
                          ),
                        ),

                      ),
                    );
                  },
                );
              },
              error: (err, stack) => Center(child: Text('$err')),
              loading: () => Center(child: CircularProgressIndicator())
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
        Container(
          height: 470.h,
          width: double.infinity,
          // color: Colors.red,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Popular',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 30.sp),),
                    Text('View all >',style: TextStyle(color: Colors.red),)
                  ],
                ),
              ),
              SizedBox(
                height: 5.h,
              ),

              Container(
                height: 410.h,
                width: double.infinity,
                child: productData.when(
                    data: (data){

                      return ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index){

                            return InkWell(
                              onTap: (){
                                Get.to(() => DetailPage(data[index]));
                              },

                              child: SizedBox(
                                height: 230.h,
                                width: 390.w,
                                child: Stack(
                                    children:[

                                      Card(
                                        color: Colors.white,
                                        semanticContainer: true,
                                        clipBehavior: Clip.antiAliasWithSaveLayer,
                                        child:Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(12.0),
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(10),
                                                child: Container(
                                                  height: 140.h,
                                                  width: 380.w,
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 12.0,right: 12),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(data[index].product_name,style: TextStyle(fontSize:30.sp ,color: Colors.black,fontWeight: FontWeight.bold),),
                                                  Text('Rs. ${data[index].price}',style: TextStyle(fontSize:30.sp ,color: Colors.black,fontWeight: FontWeight.bold),),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 12.0),
                                              child: Text(data[index].product_detail,style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),),
                                            )
                                          ],
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10.0),
                                        ),
                                        elevation: 5,
                                        // margin: EdgeInsets.all(10),
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Align(
                                          alignment: Alignment.topCenter,
                                          child: CircleAvatar(
                                              radius: 70,
                                              backgroundImage: NetworkImage(data[index].image)),
                                        ),
                                      ),

                                    ]
                                ),
                              ),
                            );

                          }

                      );

                    },
                    error: (err, stack) => Center(child: Text('$err')),
                    loading: () => Center(child: CircularProgressIndicator())),
              )
            ],
          ),
        ),

      ],
    );
  }
}
