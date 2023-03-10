import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../view_page/cart_page.dart';



class SnackShow{

  static showSuccess(BuildContext context, String message){
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          duration: Duration(seconds: 1),
        )
    );
  }

  static showFailure(BuildContext context, String message){
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          duration: Duration(seconds: 1),
        )
    );
  }


  static showCartSuccess(BuildContext context, String message){
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 1),
        action: SnackBarAction(label: 'Go to Cart', onPressed: (){
          Get.to(() => CartPage());
        }),
      ),
    );
  }

  static showCartFailure(BuildContext context, String message){
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 1),
        action: SnackBarAction(label: 'Go to Cart', onPressed: (){
          Get.to(() => CartPage());
        }),
      ),
    );
  }

}