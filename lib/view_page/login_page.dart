import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_order/view_page/signup_page.dart';
import 'package:get/get.dart';
import '../Constant/snackshow.dart';
import '../providers/auth_provider.dart';



class LoginPage extends  ConsumerStatefulWidget {

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();
  final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    ref.listen(authProvider, (previous, next) {
      if(next.errorMessage.isNotEmpty){
        SnackShow.showFailure(context, next.errorMessage);
      }else if(next.isSuccess){
        SnackShow.showSuccess(context, 'successfully login');
      }
    });

    final auth = ref.watch(authProvider);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text('Food Online',style: TextStyle(fontSize: 25.sp, color: Colors.black ),),
      ),

      body:  Padding(
        padding: const EdgeInsets.only(top: 120),
        child: Form(
          key: _form,
          child: Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Login Page', style: TextStyle(fontSize: 25.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),),
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
                              controller: emailController,
                              validator: (val){
                                if(val!.isEmpty){
                                  return 'email is required';
                                }else if(!val.contains('@')){
                                  return 'please enter valid email';
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
                                  hintText: 'E-MAIL',
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
                                  return 'password is required';
                                }else if(val.length > 30){
                                  return 'minimum character exceed';
                                }
                                return null;
                              },
                              obscureText: true,
                              style: TextStyle(color: Colors.black),
                              controller: passwordController,
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
                                  hintText: 'Password',
                                  hintStyle: TextStyle(color: Colors.grey)
                              )
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

                                ref.read(authProvider.notifier).userLogin(
                                    email: emailController.text.trim(),
                                    password: passwordController.text.trim()
                                );

                              }


                            },
                            child: auth.isLoad ?
                            Center(child: CircularProgressIndicator(
                              color: Colors.white,
                            )):
                            Text('Login', style: TextStyle(fontSize: 20.sp,)),),

                        SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Don\'t have an account',style: TextStyle(color: Colors.black),),
                            TextButton(onPressed: (){
                              // _form.currentState!.reset();
                              Get.to(() => SignUpPage(), transition: Transition.leftToRight);
                            }, child: Text('Sign Up'))
                          ],
                        )
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
