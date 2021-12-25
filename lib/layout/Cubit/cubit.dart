

import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
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

File? profileImage;
File? CoverImage;

var picker = ImagePicker();

  Future getProfileImage() async
  {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if(pickedFile !=null){
      profileImage = File(pickedFile.path) ;

      uploadProfileImage(profileImage!.path, profileImage);
      emit(SocialProfileImagePickedSuccessState());

    }
    else{
      print("no image selected");
      emit(SocialProfileImagePickeedErrorState());
    }
  }

  Future getCoverImage() async
  {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if(pickedFile !=null){
      CoverImage = File(pickedFile.path) ;

      uploadProfileImage(CoverImage!.path, profileImage);
      emit(SocialProfileImagePickedSuccessState());

    }
    else{
      print("no image selected");
      emit(SocialProfileImagePickeedErrorState());
    }
  }

void uploadProfileImage(path , file)
{
  firebase_storage.FirebaseStorage.instance.ref().child("useers/${Uri.file(path).pathSegments.last}").putFile(file).then((value) {

    value.ref.getDownloadURL().then((value) {

    print("image Url : " + value.toString());

    emit(SocialUploadImagePickedSuccessState());
    }).catchError((Error){
      print("Error on getting download link : " + Error.toString());
      emit(SocialUploadImageErrorState());
    });

  }).catchError((Error){
    print("Error on uploading the image : " + Error.toString());
    emit(SocialUploadImageErrorState());
  });
}

void updateUser({String? name , String? email , String? phone , String? bio }){

    emit(SocialUpdateUserLoadingState());
    SocialUserModel model = SocialUserModel(
      name : name,
      email : email,
      phone : phone,
      bio : bio,
      uId: token,

    );
  FirebaseFirestore.instance.collection("Users").doc(token).update(model.toMap()).then(
          (value) {

            emit(SocialUpdateUserSuccessState());
          }).catchError((error){
            print("Error on uodate : " + error.toString());

            emit(SocialUpdateUserErrorState(error.toString()));
  });
}

}
