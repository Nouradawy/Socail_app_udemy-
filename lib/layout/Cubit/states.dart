abstract class SocialStates{}

class SocialinitialState extends SocialStates{}

class SocialGetUserLoadingState extends SocialStates{}

class SocialGetUserSuccessState extends SocialStates{}

class SocialGetUserErrorState extends SocialStates{
  final String error;
  SocialGetUserErrorState(this.error);

}class SocialUpdateUserLoadingState extends SocialStates{}

class SocialUpdateUserSuccessState extends SocialStates{}

class SocialUpdateUserErrorState extends SocialStates{
  final String error;
  SocialUpdateUserErrorState(this.error);
}


class SocialChangeBottomNavState extends SocialStates {}

class SocialNewPostsState extends SocialStates {}

class SocialProfileImagePickedSuccessState extends SocialStates {}

class SocialProfileImagePickeedErrorState extends SocialStates {}

class SocialUploadImagePickedSuccessState extends SocialStates {}

class SocialUploadImageErrorState extends SocialStates {}
