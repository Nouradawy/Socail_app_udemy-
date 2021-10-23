import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Shared/Components/components.dart';
import 'package:social_app/Themes/icon_broken.dart';
import 'package:social_app/layout/Cubit/cubit.dart';
import 'package:social_app/modules/Socialapp/login/Cubit/cubit.dart';

import 'Cubit/states.dart';

class SocialLayout extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value:SocialCubit.get(context)..getUserData(),
      child: BlocConsumer<SocialCubit,SocialStates>(
          listener: (context , state){},
          builder: (context , state) {
            var Cubit = SocialCubit.get(context);
            return Scaffold(
              appBar: AppBar(
                title: Text(Cubit.titles[Cubit.currentIndex]),
                actions: [
                  IconButton(onPressed: (){}, icon: Icon(IconBroken.Notification) , tooltip:"Notifications" ,),
                  IconButton(onPressed: (){}, icon: Icon(IconBroken.Search) , tooltip: "Search",),
                ],
              ),
              body: ConditionalBuilder(
                condition:SocialCubit.get(context).model !=null,
                builder: (context) {
                  return Column(
                    children: [
                    FirebaseAuth.instance.currentUser?.emailVerified == false?Container(
                          color: Colors.amber.withOpacity(.6),
                          height: 50,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              children: [
                                const Icon(Icons.warning_amber_outlined),
                                const SizedBox(width: 20),
                                 Expanded(
                                    child: Text(
                                  "Please verify you email",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 15),
                                )),
                                const SizedBox(
                                  width: 20,
                                ),
                                TextButton(
                                  onPressed: () {
                                    FirebaseAuth.instance.currentUser?.sendEmailVerification().then(
                                            (value)
                                            {
                                                  showToast(
                                                      text: "Check your email",
                                                      state:
                                                          ToastStates.SUCCESS);
                                                  FirebaseAuth.instance.currentUser?.reload();
                                                }).catchError((error){
                                      print(error.toString());
                                    });
                                  },
                                  child: const Text("SEND"),
                                ),
                              ],
                            ),
                          ),
                        ):Container(),
                      Expanded(child: Cubit.screens[Cubit.currentIndex]),
                    ],
                  );
                },
                fallback: (context)=>const Center(child: CircularProgressIndicator()),
              ),

              bottomNavigationBar: BottomNavigationBar(
                currentIndex: Cubit.currentIndex,
                onTap: (index){
                  Cubit.ChangeBottomNav(index);
                },
                items: const [
                  BottomNavigationBarItem(icon: Icon(IconBroken.Home),label:"Home" ),
                  BottomNavigationBarItem(icon: Icon(IconBroken.Chat),label:"Chat"),
                  BottomNavigationBarItem(icon: Icon(IconBroken.Location),label: "Users"),
                  BottomNavigationBarItem(icon: Icon(IconBroken.Setting),label:"Settings"),
                ],
              ),
            );
          }
        ),
    );
  }
}

class SocailCubit {
}
