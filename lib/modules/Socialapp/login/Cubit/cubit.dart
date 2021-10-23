import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Network/local/cache_helper.dart';
import 'package:social_app/Shared/Components/constants.dart';
import 'package:social_app/layout/Cubit/cubit.dart';
import 'package:social_app/models/social_app/user_model.dart';
import 'package:social_app/modules/Socialapp/login/Cubit/states.dart';

class SocialLoginCubit extends Cubit<SocialLoginStates>
{
  SocialLoginCubit() : super(SocialLoginInitialState());

  String Textstate ="";
  static SocialLoginCubit get(context) => BlocProvider.of(context);
  bool isPassword = true;
  IconData? suffixIcon = Icons.visibility;

  void Passon(){
    isPassword =! isPassword;
    suffixIcon = isPassword ?Icons.visibility:Icons.visibility_off;
    emit(SocialIsPasswordState());
  }

  void userLogin({String? email , String? password}){
    emit(SocialLoginLoadingState());
    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.toString(),
        password: password.toString(),).then((value){
      CacheHelper.saveData(key: 'token', value: value.user?.uid);
      token=value.user?.uid;

          emit(SocialLoginSuccessState(value.user!.uid));
        }
    ).catchError((error){
      print(error.toString());
      emit(SocialLoginErrorState(error.toString()));
    });
  }

  void RegisterUser({String? name , String? email , String? phone , String? password , String? uId}) {
    Textstate = "Pushing your Data to our servers";
    emit(SocialLoadingRegisterUserState(Textstate));
    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.toString(), password: password.toString()
    ).then((value){
      Textstate = "Dear $name your Account is Almost Ready, pushing last steps";
      emit(SocialSuccessRegisterUserState(Textstate));
      SocialUserModel model = SocialUserModel(
        name : name,
        email : email,
        phone : phone,
        uId : value.user?.uid,
        isEmailVerified: false,
      );
      FirebaseFirestore.instance.collection("Users").doc(value.user!.uid).set(model.toMap()).then((value){

        Textstate = "Dear $name your Account is now Ready , please wait while we try signing you in";

        emit(SocialSuccessUserCreationState(Textstate));

        userLogin(email: "$email" , password: "$password");
      }).catchError((error){
       print("UserCreation error : " + error.toString());
       emit(SocialErrorUserCreationState());
      });

    }).catchError((error){
      print("Register User error : " + error.toString());
      emit(SocialErrorRegisterUserState());
    });
  }
}
