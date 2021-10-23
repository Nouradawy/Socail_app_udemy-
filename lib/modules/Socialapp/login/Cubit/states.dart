abstract class SocialLoginStates{}
class SocialLoginInitialState extends SocialLoginStates{}

class SocialLoginLoadingState extends SocialLoginStates{}

class SocialLoginSuccessState extends SocialLoginStates{
  final String token;
  SocialLoginSuccessState(this.token);
}

class SocialLoginErrorState extends SocialLoginStates{
  final String error;
  SocialLoginErrorState(this.error);
}

class SocialIsPasswordState extends SocialLoginStates{}

class SocialLoadingRegisterUserState extends SocialLoginStates{
 final String Textstate;
 SocialLoadingRegisterUserState(this.Textstate);
}
class SocialSuccessRegisterUserState extends SocialLoginStates{
  final String Textstate;
  SocialSuccessRegisterUserState(this.Textstate);
}
class SocialErrorRegisterUserState extends SocialLoginStates{}

class SocialLoadingUserCreationState extends SocialLoginStates{}
class SocialSuccessUserCreationState extends SocialLoginStates{
  final String Textstate;
  SocialSuccessUserCreationState(this.Textstate);
}
class SocialErrorUserCreationState extends SocialLoginStates{}
