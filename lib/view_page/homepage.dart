import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_order/view_page/products_widget/create_page.dart';
import 'package:food_order/view_page/products_widget/crud_page.dart';
import 'package:food_order/view_page/products_widget/order_history.dart';
import 'package:food_order/view_page/status_page.dart';
import 'package:food_order/view_page/user_detail.dart';
import 'package:get/get.dart';
import '../providers/auth_provider.dart';
import '../services/crud_service.dart';
import 'cart_page.dart';
import 'detail_page.dart';
import 'feedpage.dart';


class HomePage extends ConsumerStatefulWidget {

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {


  List pages =[
    FeedPage(),
    ProfilePage()
  ];

  int currentIndex=0;

  void onTap(int index){
    setState(() {
      currentIndex = index;
    });
  }


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authProvider);
    final productData = ref.watch(products);
    FlutterNativeSplash.remove();

    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          title: Text('Food 2 Fone',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
          actions: [
            IconButton(onPressed: (){
              Get.to(() => CartPage(), transition: Transition.leftToRight);
            }, icon: Icon(Icons.shopping_bag,color: Colors.red,))
          ],
        ),
        drawer: Drawer(
          backgroundColor: Colors.white,
            child: ListView(
              children: [
                // DrawerHeader(
                //   child: Text(auth.user!.email),
                // ),
                // ListTile(
                //   onTap: (){
                //     Navigator.of(context).pop();
                //   },
                //   leading: Icon(Icons.email),
                //   title: Text(auth.user!.email),
                // ),
                ListTile(
                  onTap: (){
                    Navigator.of(context).pop();
                    Get.to(() => CreatePage(), transition: Transition.leftToRight);
                  },
                  leading: Icon(Icons.add,color: Colors.black,),
                  title: Text('Create Product',style: TextStyle(color: Colors.black),),
                ),
                ListTile(
                  onTap: (){
                    Navigator.of(context).pop();
                    Get.to(() => CrudPage(), transition: Transition.leftToRight);
                  },
                  leading: Icon(Icons.settings,color: Colors.black,),
                  title: Text('Customize Product',style: TextStyle(color: Colors.black),),
                ),
                ListTile(
                  onTap: (){
                    Navigator.of(context).pop();
                    Get.to(() => OrderHistory(), transition: Transition.leftToRight);
                  },
                  leading: Icon(Icons.history,color: Colors.black,),
                  title: Text('History',style: TextStyle(color: Colors.black),),
                ),

                ListTile(
                  onTap: (){
                    Navigator.of(context).pop();
                    ref.read(authProvider.notifier).userLogOut();

                  },
                  leading: Icon(Icons.exit_to_app,color: Colors.black,),
                  title: Text('Log Out',style: TextStyle(color: Colors.black),),
                )
              ],
            )

        ),
        body:  pages[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: onTap,
          type: BottomNavigationBarType.fixed,
          iconSize: 25.w,
          unselectedFontSize:0.0,
          selectedFontSize: 10.w,
          backgroundColor: Colors.white,
          selectedItemColor: Colors.red,
          unselectedItemColor: Colors.black,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home'
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile'
            ),

          ],


        ),
    );
  }
}