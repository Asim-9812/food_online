


import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../providers/auth_provider.dart';

class ProfilePage extends ConsumerStatefulWidget {

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authProvider);
    return Container(
      width: double.infinity,
      child: Column(


        children: [
          
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Container(

                      color: Colors.red,
                      child: Icon(Icons.person,size: 120.sp,color: Colors.white,)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(auth.user!.username,style: TextStyle(color: Colors.black,fontSize: 30.sp,fontWeight: FontWeight.bold),),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(auth.user!.email,style: TextStyle(color: Colors.grey,fontSize: 20.sp,fontWeight: FontWeight.bold),),
              ),

            ],
          ),

          Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Account',style: TextStyle(color: Colors.grey,fontSize: 25.sp,fontWeight: FontWeight.bold),),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: ListTile(
                    tileColor: Colors.grey.withOpacity(0.3),
                    leading: Icon(Icons.person,color: Colors.black,),
                    title: Text('Profile',style: TextStyle(color: Colors.black),),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: ListTile(
                    tileColor: Colors.grey.withOpacity(0.3),
                    leading: Icon(Icons.star,color: Colors.black,),
                    title: Text('Saved',style: TextStyle(color: Colors.black),),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: ListTile(
                    tileColor: Colors.grey.withOpacity(0.3),
                    leading: Icon(Icons.notification_important,color: Colors.black,),
                    title: Text('Notification',style: TextStyle(color: Colors.black),),
                  ),
                ),

              ],
            ),
          ),
          


        ],
      ),
    );
  }
}
