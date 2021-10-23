import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Network/local/cache_helper.dart';
import 'package:social_app/Shared/Components/Constants.dart';
import 'package:social_app/Shared/Components/components.dart';
import 'package:social_app/layout/social_layout.dart';
import 'package:social_app/modules/Socialapp/login/Cubit/cubit.dart';
import 'package:social_app/modules/Socialapp/login/Cubit/states.dart';

class SocialRegisterScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    var formKey = GlobalKey<FormState>();
    var namecontroller = TextEditingController();
    var phonecontroller = TextEditingController();
    var emailcontroller = TextEditingController();
    var passwordcontroller = TextEditingController();

    return Scaffold(
        appBar: AppBar(
          title: const Text("Account Register"),),
        body:BlocConsumer<SocialLoginCubit,SocialLoginStates>(
          listener: (context, state) {
            if(state is SocialLoginSuccessState)
            {
              Navigator.pushAndRemoveUntil(context,
                  MaterialPageRoute(builder:(BuildContext context) => SocialLayout()),
                      (Route<dynamic>route) => false);
            }
          },
          builder: (context , state)
          {
            return GestureDetector(
              onTap:()=>FocusScope.of(context).unfocus(),
              child: Center(
                child: SingleChildScrollView(
                  keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('REGISTER',
                            style: Theme.of(context).textTheme.headline4!.copyWith(color: Colors.black),),
                          Text('Register and communicate with your friends.',
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color:Colors.grey,
                            ),),
                          const SizedBox(
                            height: 30.0,
                          ),
                          defaultTextForm(
                            context,
                            controller: namecontroller,
                            keyBoardType: TextInputType.text,
                            text: 'name',
                            onTap: (){},
                            validate: (String? value){
                              return value!.isEmpty? "Name must not be Empty": null;
                            },
                            preIcon: Icons.person,
                          ),
                          const SizedBox(height: 15,),
                          defaultTextForm(
                            context,
                            controller: phonecontroller,
                            keyBoardType: TextInputType.phone,
                            text: 'Phone number',
                            onTap: (){},
                            validate: (String? value){
                              return value!.isEmpty? "Phone must not be Empty": null;
                            },
                            preIcon: Icons.phone,
                          ),const SizedBox(height: 15,),
                          defaultTextForm(
                            context,
                            controller: emailcontroller,
                            keyBoardType: TextInputType.emailAddress,
                            text: 'EmailAddress',
                            onTap: (){},
                            validate: (String? value){
                              return value!.isEmpty? "emailAddress must not be Empty": null;
                            },
                            preIcon: Icons.email,
                          ),const SizedBox(height: 15,),
                          defaultTextForm(
                            context,
                            Cubit: SocialLoginCubit.get(context),
                            controller: passwordcontroller,
                            keyBoardType: TextInputType.text,
                            IsPassword: true,
                            text: 'Password',
                            onTap: (){},
                            validate: (String? value) =>value!.isEmpty? "Password must not be Empty": null,
                            preIcon: Icons.vpn_key,
                          ),
                          SizedBox(height: 25,),
                          ConditionalBuilder(
                              condition: state is! SocialLoadingRegisterUserState,
                              builder: (BuildContext context) =>defaultButton(
                                function: () {
                                  if (formKey.currentState!.validate()) {
                                    SocialLoginCubit.get(context).RegisterUser(
                                        name: namecontroller.text,
                                        phone: phonecontroller.text,
                                        email: emailcontroller.text,
                                        password: passwordcontroller.text);
                                  }
                                },
                                text: 'Submit',
                                isUpperCase: true,
                              ),
                              fallback: (context)=> Center(
                                child: CircularProgressIndicator(),
                              )),
                          Center(child: Text(SocialLoginCubit.get(context).Textstate)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }, )
    );
  }
}
