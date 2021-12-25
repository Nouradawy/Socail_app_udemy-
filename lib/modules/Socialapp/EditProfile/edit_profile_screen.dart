import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Shared/Components/components.dart';
import 'package:social_app/Themes/icon_broken.dart';
import 'package:social_app/layout/Cubit/cubit.dart';
import 'package:social_app/layout/Cubit/states.dart';

class EditProfileScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    var Cubit = SocialCubit.get(context);
    var NameController =TextEditingController();
    var BioController = TextEditingController();
    var phoneController = TextEditingController();
    var emailController = TextEditingController();
    phoneController.text = Cubit.model!.phone!;
    emailController.text = Cubit.model!.email!;

    return Scaffold(
      appBar:defaultAppBar(
        context: context,
        title:"Edit Profile",
        LeadingIcon: IconBroken.Arrow___Left_2,
        actions: [
          TextButton(onPressed: (){
            Cubit.updateUser(name: NameController.text , bio: BioController.text,phone: phoneController.text , email: emailController.text,);
          },
              child: Text("UPDATE",
                style: TextStyle(color:Colors.white)
                ,)),
          SizedBox(width:5.0),

        ]
      ),
      body: BlocConsumer<SocialCubit,SocialStates>(
      listener: (context , state) {
        if(state is! SocialUpdateUserLoadingState)
          {
            NameController.text = Cubit.model!.name!;
            BioController.text = Cubit.model!.bio!;

          }
      },
      builder:(context , states)=> Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [

                Container(
                  height:230,
                  child: Align(
                    alignment: AlignmentDirectional.topCenter,
                    child: Card(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        elevation: 7,
                        child:Image(image: Cubit.CoverImage == null ? NetworkImage(Cubit.model!.cover.toString()) : ImageSwap(Cubit.CoverImage),
                          fit: BoxFit.cover,
                          height: 170,
                          width: double.infinity,
                        )
                    ),
                  ),
                ),
                Container(
                  height:230,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Align(
                      alignment: AlignmentDirectional.topEnd,
                      child: IconButton(onPressed:(){
                        Cubit.getCoverImage();
                      },icon:Icon(IconBroken.Edit,),color: Colors.white,),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: Cubit.profileImage == null ? NetworkImage(Cubit.model!.image.toString()) : ImageSwap(Cubit.profileImage),
                    ),
                  ),
                ),
                IconButton(onPressed:(){
                  Cubit.getProfileImage();
                },icon:Icon(IconBroken.Edit,),color: Colors.white,),
              ],
            ),
            Container(
              width: 160,
              child: TextFormField(
              controller: NameController,
              keyboardType: TextInputType.text,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.black),
              decoration: InputDecoration.collapsed(
                border:InputBorder.none,
                hintText: "edit",
              ),
            ),
              ),
            Container(
              width: 230,
              child: TextFormField(
                controller: BioController,
                keyboardType: TextInputType.text,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.caption,
                maxLines: 3,
                decoration: InputDecoration.collapsed(
                  border:InputBorder.none,
                  hintText: "edit",
                ),
              ),
            ),


          ],
        ),
      ),
    ),
    );
  }

  ImageProvider<Object> ImageSwap(profileImage) => FileImage(profileImage);
}
