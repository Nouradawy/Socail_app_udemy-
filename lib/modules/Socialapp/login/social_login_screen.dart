import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Network/local/cache_helper.dart';
import 'package:social_app/Shared/Components/components.dart';
import 'package:social_app/layout/Cubit/cubit.dart';
import 'package:social_app/layout/social_layout.dart';
import 'package:social_app/modules/Socialapp/Register/social_register_screen.dart';

import 'Cubit/cubit.dart';
import 'Cubit/states.dart';

class SocialLoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var EmailController = TextEditingController();
  var PasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialLoginCubit(),
      child:BlocConsumer<SocialLoginCubit , SocialLoginStates>(
          listener:(context , state){
            if(state is SocialLoginSuccessState){
              CacheHelper.saveData(key: "token", value: state.token);
            }
            if(state is SocialLoginSuccessState)
            {
              Navigator.pushAndRemoveUntil(context,
                  MaterialPageRoute(builder:(BuildContext context) => SocialLayout()),
                      (Route<dynamic>route) => false);
            }

            if(state is SocialLoginErrorState){
              showToast(
                  text: state.error,
                  state:ToastStates.WARNING,
              );
            }
          },
          builder:(context , state) {
            SocialLoginCubit Cubit = SocialLoginCubit.get(context);
            return GestureDetector(
              onTap:()=>FocusScope.of(context).unfocus(),
              child: Scaffold(
                appBar: AppBar(),
                body: Center(
                  child: SingleChildScrollView(
                    keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('LOGIN',
                              style: Theme.of(context).textTheme.headline4!.copyWith(color: Colors.black),),
                            Text('login now to see latest news',
                              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                color:Colors.grey,
                              ),),
                            const SizedBox(height: 30.0,),
                            defaultTextForm(context,
                              controller: EmailController,
                              keyBoardType: TextInputType.emailAddress,
                              text: 'Email address',
                              onTap: (){},
                              preIcon: Icons.email,
                            ),
                            const SizedBox(height: 15.0,),
                            defaultTextForm(
                              context,
                              Cubit: Cubit,
                              controller: PasswordController,
                              IsPassword: true,
                              keyBoardType: TextInputType.text,
                              text: 'Password',
                              validate: (String? value) {
                                value!.isEmpty ? 'Password is too short' : null;
                              },
                              onTap: () {},
                              preIcon: Icons.lock_open_outlined,
                            ),
                            const SizedBox(height: 30.0,),
                              ConditionalBuilder(
                                builder: (BuildContext context) => defaultButton(
                                  function: () {
                                    if (formKey.currentState!.validate()) {
                                      SocialLoginCubit.get(context).userLogin(
                                          email: EmailController.text,
                                          password: PasswordController.text);
                                    }
                                  },
                                  text: 'login',
                                  isUpperCase: true,
                                ),
                                condition: state is! SocialLoginLoadingState,
                                fallback: (context) =>
                                    Center(child: CircularProgressIndicator()),
                              ),

                            const SizedBox(
                              height: 15.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('Don\'t have an account ?'),
                                TextButton(onPressed: (){
                                    Navigator.push(context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              BlocProvider.value(
                                                value: SocialLoginCubit(),
                                                  child: SocialRegisterScreen()),
                                    ),
                                  );
                                }, child: const Text('Register Now')),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        )
    );
  }
}
