import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_order/providers/crud_provider.dart';
import 'package:get/get.dart';

import '../../providers/auth_provider.dart';
import '../../services/crud_service.dart';
import 'crud_page.dart';
import 'edit_page.dart';


class CrudPage extends ConsumerWidget {

  @override
  Widget build(BuildContext context, ref) {
    final auth = ref.watch(authProvider);
    final productData = ref.watch(products);
    return Scaffold(
      appBar: AppBar(
        title: Text('Customize',style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        automaticallyImplyLeading: true,
      ),
      backgroundColor: Colors.white,
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: productData.when(
              data: (data){
                return ListView.separated(
                  separatorBuilder: (context,index){
                    return SizedBox(height: 20,);
                  },
                  itemCount: data.length,
                  itemBuilder: (context, index){
                    return  ListTile(
                      leading: Image.network(data[index].image, width:60.w,height:60.h,fit: BoxFit.cover,),
                      title: Text(data[index].product_name,style: TextStyle(color: Colors.black),),
                      trailing: Container(
                        width: 100,
                        child: Row(
                          children: [
                            IconButton(onPressed: (){
                              Get.to(() => EditPage(data[index]));
                            }, icon: Icon(Icons.edit,color: Colors.red,)),
                            IconButton(onPressed: (){
                              ref.read(crudProvider.notifier).deletePost(postId: data[index].productId, imageId: data[index].public_id, token: auth.user!.token);
                              ref.refresh(products);
                              }, icon: Icon(Icons.delete,color: Colors.red,)),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              error: (err, stack) => Center(child: Text('$err')),
              loading: () => Center(child: CircularProgressIndicator())
          ),
        )
    );
  }
}