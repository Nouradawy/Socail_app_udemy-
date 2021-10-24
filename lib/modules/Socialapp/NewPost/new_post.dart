import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_app/Shared/Components/components.dart';
import 'package:social_app/Themes/icon_broken.dart';

class NewPostScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:defaultAppBar(
        context: context,
        title:"Addpost",
        LeadingIcon: IconBroken.Arrow___Left_2,
      ),
    );
  }
}
