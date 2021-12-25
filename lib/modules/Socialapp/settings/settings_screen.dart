import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Shared/Components/components.dart';
import 'package:social_app/Themes/icon_broken.dart';
import 'package:social_app/layout/Cubit/cubit.dart';
import 'package:social_app/layout/Cubit/states.dart';
import 'package:social_app/modules/Socialapp/EditProfile/edit_profile_screen.dart';

class SettingsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var Cubit = SocialCubit.get(context);
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context , state) {},
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
                            child:Image(image: NetworkImage(Cubit.model!.cover.toString()),
                              fit: BoxFit.cover,
                              height: 170,
                              width: double.infinity,
                            )
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
                      backgroundImage: NetworkImage(Cubit.model!.image.toString()
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Text(SocialCubit.get(context).model!.name.toString(),
            style:Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.black)),
            Text(Cubit.model!.bio.toString(),
            style:Theme.of(context).textTheme.caption),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      child: Column(
                        children: [
                          Text("265",
                              style:Theme.of(context).textTheme.subtitle2),
                          Text("photos",
                              style:Theme.of(context).textTheme.caption!.copyWith(color: Colors.black)),
                        ],
                      ),
                      onTap: (){},
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      child: Column(
                        children: [
                          Text("10k",
                              style:Theme.of(context).textTheme.subtitle2),
                          Text("Followers",
                              style:Theme.of(context).textTheme.caption!.copyWith(color: Colors.black)),
                        ],
                      ),
                      onTap: (){},
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      child: Column(
                        children: [
                          Text("100",
                              style:Theme.of(context).textTheme.subtitle2),
                          Text("Likes",
                              style:Theme.of(context).textTheme.caption!.copyWith(color: Colors.black)),
                        ],
                      ),
                      onTap: (){},
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      child: Column(
                        children: [
                          Text("100",
                              style:Theme.of(context).textTheme.subtitle2),
                          Text("posts",
                              style:Theme.of(context).textTheme.caption!.copyWith(color: Colors.black)),
                        ],
                      ),
                      onTap: (){},
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(child: OutlinedButton(onPressed: (){}, child: Text("Add Photos"))),
                OutlinedButton(onPressed: (){
                  Navigator.push(context,MaterialPageRoute(builder: (BuildContext context)=>EditProfileScreen()));
                }, child: Icon(IconBroken.Edit,size:16.0)),
              ],
            ),

          ],
        ),
      ),
    );
        
      
    
  }
}
