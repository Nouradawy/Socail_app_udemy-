import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Shared/Components/constants.dart';
import 'package:social_app/layout/Cubit/states.dart';
import 'package:social_app/models/social_app/user_model.dart';
import 'package:social_app/modules/Socialapp/Users/users_screen.dart';
import 'package:social_app/modules/Socialapp/chats/chats_screeen.dart';
import 'package:social_app/modules/Socialapp/feeds/feeds_screeen.dart';
import 'package:social_app/modules/Socialapp/login/Cubit/states.dart';
import 'package:social_app/modules/Socialapp/settings/settings_screen.dart';

class SocialCubit extends Cubit<SocialStates>{
  SocialCubit() : super(SocialinitialState());
  static SocialCubit get(context) => BlocProvider.of(context);

SocialUserModel? model;

void getUserData()
{
  emit(SocialGetUserLoadingState());

  FirebaseFirestore.instance.collection('Users').doc(token).get(

  ).then((value) {
    print("metadata : "+value.metadata.toString());
    model = SocialUserModel.fromJson(value.data());
    emit(SocialGetUserSuccessState());
  }).catchError((error){
    print(error.toString());
    emit(SocialGetUserErrorState(error));
  });
}

int currentIndex = 0;
List<Widget>screens =[
  FeedScreen(),
  chatsScreen(),
  UsersScreen(),
  SettingsScreen(),
];
List<String> titles=[
  "Home",
  "Chats",
  "Users",
  "Settings",
];

void ChangeBottomNav(int index)
{
  currentIndex = index;
  emit(SocialChangeBottomNavState());
}

}
