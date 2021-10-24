import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Themes/icon_broken.dart';
import 'package:social_app/layout/Cubit/cubit.dart';

import 'package:social_app/modules/Socialapp/NewPost/new_post.dart';

class FeedScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var Cubit = SocialCubit.get(context);
    return BlocProvider.value(
      value: SocialCubit()..getUserData(),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              elevation: 7,
              margin: EdgeInsets.all(8),
              child:Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  Image(image: NetworkImage("https://image.freepik.com/free-photo/positive-dark-skinned-young-woman-man-bump-fists-agree-be-one-team-look-happily-each-other-celebrates-completed-task-wear-pink-green-clothes-pose-indoor-have-successful-deal_273609-42756.jpg"),
                fit: BoxFit.cover,
                height: 220,
                    width: double.infinity,
                ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Communicate with friends",
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            color: Colors.white,
                          ),
                    ),
                  ),
                ]
              )
            ),
            Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              elevation: 7,
              margin: EdgeInsets.all(8),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage("https://as1.ftcdn.net/v2/jpg/02/68/62/04/1000_F_268620420_raIDjo1HJvtratuDz5z338yZ9QUcr7lZ.jpg"
                    ),
                  ),
                  SizedBox(width: 30),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context,MaterialPageRoute(
                            builder: (BuildContext context)=>NewPostScreen(),)
                        );
                      },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 7.0),
                          child: Text("What's on your mind ${Cubit.model?.name} ",style: Theme.of(context).textTheme.caption,),
                        )),
                  ),
                ],),
              ),
            ),
            ListView.separated(
                itemBuilder: (context , index) => buildPostItem(context),
              itemCount: 10,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              separatorBuilder: (context , index) => SizedBox(height: 8.0,),
            ),
          ],
        ),
      ),
    );
  }
  Widget buildPostItem(context) =>Card(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 10,
    margin: EdgeInsets.symmetric(
        horizontal: 8
    ),

    child:Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Row(children: [
            CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage("https://as1.ftcdn.net/v2/jpg/02/68/62/04/1000_F_268620420_raIDjo1HJvtratuDz5z338yZ9QUcr7lZ.jpg"
              ),
            ),
            SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                  Row(
                    children: [
                      Text("Nouradawy",
                        style: TextStyle(
                          height: 1.4,
                        ),
                      ),
                      SizedBox(width:5),
                      Icon(
                        Icons.check_circle,
                        color: Colors.blue,
                        size: 15,
                      ),
                    ],
                  ),
                  Text("January 21 2021 at 11:00 pm",
                    style: Theme.of(context).textTheme.caption?.copyWith(
                      height: 1.4,
                    ),),
                ],
              ),
            ),
            SizedBox(width: 15),
            IconButton(
                onPressed: (){},
                icon:Icon(Icons.more_horiz,)),
          ],),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Container(
              width:double.infinity,
              height: 1,
              color:Colors.grey[300],
            ),
          ),
          Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
            ,style: Theme.of(context).textTheme.subtitle1?.copyWith(height:1.2,fontWeight: FontWeight.w200, fontSize: 14),),
          Padding(
            padding: const EdgeInsets.only(
              bottom:10.0,
              top:5.0,
            ),
            child: Container(
              width:double.infinity,
              child: Wrap(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 3),
                    child: Container(
                      height: 20,
                      child: MaterialButton(
                          minWidth: 1.0,
                          padding: EdgeInsets.zero,
                          onPressed: (){},
                          child:Text("#Software",
                            style: Theme.of(context).textTheme.caption?.copyWith(color:Colors.blue),)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 3),
                    child: Container(
                      height: 20,
                      child: MaterialButton(
                          minWidth: 1.0,
                          padding: EdgeInsets.zero,
                          onPressed: (){},
                          child:Text("#Software",
                            style: Theme.of(context).textTheme.caption?.copyWith(color:Colors.blue),)),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
              height:180,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                image: DecorationImage(
                  image: NetworkImage("https://image.freepik.com/free-photo/positive-dark-skinned-young-woman-man-bump-fists-agree-be-one-team-look-happily-each-other-celebrates-completed-task-wear-pink-green-clothes-pose-indoor-have-successful-deal_273609-42756.jpg",
                  ),
                  fit:BoxFit.cover,
                ),
              )
          ),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      children: [
                        Icon(IconBroken.Heart,
                            size:20,
                            color:Colors.red),
                        SizedBox(width:5,),
                        Text("120" , style: Theme.of(context).textTheme.caption,),
                      ],
                    ),
                  ),
                  onTap: (){},
                ),
              ),
              SizedBox(width:180),
              Expanded(
                child: InkWell(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(IconBroken.Chat,
                            size:20,
                            color:Colors.amber),
                        SizedBox(width:5,),
                        Text("120 comment" , style: Theme.of(context).textTheme.caption,),
                      ],
                    ),
                  ),
                  onTap: (){},
                ),
              ),
            ],),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Container(
              width:double.infinity,
              height: 1,
              color:Colors.grey[300],
            ),
          ),
          Row(children: [
            CircleAvatar(
              radius: 18,
              backgroundImage: NetworkImage("https://as1.ftcdn.net/v2/jpg/02/68/62/04/1000_F_268620420_raIDjo1HJvtratuDz5z338yZ9QUcr7lZ.jpg"
              ),
            ),
            SizedBox(width: 15),
            Expanded(
              child: InkWell(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text("Write a comment ....",
                    style: Theme.of(context).textTheme.caption?.copyWith(
                    ),),
                ),
                onTap: (){},
              ),
            ),
            InkWell(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5 , horizontal: 7),
                child: Row(
                  children: [
                    Icon(IconBroken.Heart,
                        size:17,
                        color:Colors.red),
                    SizedBox(width:5,),
                    Text("Like" , style: Theme.of(context).textTheme.caption,),
                  ],
                ),
              ),
              onTap: (){},
            ),
            InkWell(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5 , horizontal: 7),
                child: Row(
                  children: [
                    Icon(IconBroken.Logout,
                        size:17,
                        color:Colors.green),
                    SizedBox(width:5,),
                    Text("Share" , style: Theme.of(context).textTheme.caption,),
                  ],
                ),
              ),
              onTap: (){},
            ),
          ],),

        ],
      ),
    ),
  );
}
