import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../Constant/snackshow.dart';
import '../../providers/auth_provider.dart';
import '../../providers/crud_provider.dart';
import '../../services/crud_service.dart';
import '../../states/products.dart';


class EditPage extends  ConsumerStatefulWidget {
  final Product product;
  EditPage(this.product);

  @override
  ConsumerState<EditPage> createState() => _EditPageState();
}

class _EditPageState extends ConsumerState<EditPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController detailController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  final _form = GlobalKey<FormState>();

  @override
  void initState() {
    titleController..text = widget.product.product_name;
    detailController..text = widget.product.product_detail;
    priceController..text = widget.product.price.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    ref.listen(crudProvider, (previous, next) {
      if(next.errorMessage.isNotEmpty){
        SnackShow.showFailure(context, next.errorMessage);
      }else if(next.isSuccess){
        ref.refresh(products);
        SnackShow.showSuccess(context, 'succesfully updated');
        Get.back();
      }
    });

    final image = ref.watch(imageProvider);
    final crud = ref.watch(crudProvider);
    final auth = ref.watch(authProvider);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text('Customize Product',style: TextStyle(fontSize: 25.sp, color: Colors.black ),),
      ),

      body:  Padding(
        padding:  EdgeInsets.only(top: 30.h),
        child: Form(
          key: _form,
          child: Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                SizedBox(
                  height: 10.h,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all()
                    ),
                    // color: Colors.red,
                    width: 250.w,
                    child: Column(
                      children: [

                        Padding(
                          padding: const EdgeInsets.only(
                              top: 20, left: 10, right: 10, bottom: 8),
                          child: TextFormField(
                              controller: titleController,
                              validator: (val){
                                if(val!.isEmpty){
                                  return 'title is required';
                                }
                                return null;
                              },
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  enabledBorder: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),

                                  // fillColor: Colors.black,
                                  filled: true,
                                  hintText: 'Title',
                                  hintStyle: TextStyle(color: Colors.grey)
                              )
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10, left: 10, right: 10, bottom: 8),
                          child: TextFormField(
                              validator: (val){
                                if(val!.isEmpty){
                                  return 'detail is required';
                                }else if(val.length > 500){
                                  return 'minimum character exceed';
                                }
                                return null;
                              },
                              controller: detailController,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  enabledBorder: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                  // fillColor: Colors.black,
                                  filled: true,
                                  hintText: 'Detail',
                                  hintStyle: TextStyle(color: Colors.grey)
                              )
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10, left: 10, right: 10, bottom: 8),
                          child: TextFormField(
                              keyboardType: TextInputType.number,
                              validator: (val){
                                if(val!.isEmpty){
                                  return 'price is required';
                                }else if(val.length > 50){
                                  return 'minimum character exceed';
                                }
                                return null;
                              },
                              controller: priceController,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  enabledBorder: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                  // fillColor: Colors.black,
                                  filled: true,
                                  hintText: 'Price',
                                  hintStyle: TextStyle(color: Colors.grey)
                              )
                          ),
                        ),

                        InkWell(
                          onTap: (){
                            ref.read(imageProvider.notifier).pickAnImage();
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 15),
                            height: 150.h,
                            width: 250.w,
                            color: Colors.white,
                            child: image == null ? Image.network(widget.product.image) : Image.file(File(image.path)),
                          ),
                        ),

                        TextButton(
                            style: TextButton.styleFrom(
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white
                            ),
                            onPressed: () {
                              _form.currentState!.save();
                              FocusScope.of(context).unfocus();
                              if(_form.currentState!.validate()){

                                if(image == null){
                                  ref.read(crudProvider.notifier).updatePost(
                                    title: titleController.text.trim(),
                                    detail: detailController.text.trim(),
                                    price: int.parse(priceController.text.trim()),
                                    postId: widget.product.productId,
                                    token: auth.user!.token,
                                  );
                                }else{
                                  ref.read(crudProvider.notifier).updatePost(
                                      title: titleController.text.trim(),
                                      detail: detailController.text.trim(),
                                      price: int.parse(priceController.text.trim()),
                                      postId: widget.product.productId,
                                      token: auth.user!.token,
                                      image: image,
                                      imageId: widget.product.public_id
                                  );

                                }


                              }



                            },
                            child:crud.isLoad ? Center(child: CircularProgressIndicator(
                              color: Colors.white,
                            )): Text('Submit', style: TextStyle(fontSize: 20.sp),))
                      ],
                    ),
                  ),
                ),


              ],

            ),
          ),
        ),
      ),
    );

  }
}
