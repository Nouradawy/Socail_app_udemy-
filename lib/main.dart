import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Network/Remote/dio_heelper.dart';
import 'package:social_app/Themes/dark_theme.dart';
import 'package:social_app/modules/Socialapp/login/social_login_screen.dart';

import 'Network/local/cache_helper.dart';
import 'Shared/Components/constants.dart';
import 'Themes/light_theme.dart';
import 'layout/Cubit/cubit.dart';
import 'layout/social_layout.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  DioHelper.dio;
  await CacheHelper.init();
  token = CacheHelper.getData(key: 'token');
  print("AuthorizationToken: "+token.toString());
  Widget Homescreen = SocialLayout();

    if(token != null)
    {
    Homescreen = SocialLayout();
    } else {
    Homescreen = SocialLoginScreen();
    }

  runApp(MyApp(
    homeScreen:Homescreen,
  ));
}

class MyApp extends StatelessWidget {
final Widget homeScreen;

const MyApp({
  required this.homeScreen,
});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context)=>SocialCubit())
      ],
      child: MaterialApp(
        theme: LightThemeData(),
        darkTheme: DarkThemeData(),
        debugShowCheckedModeBanner: false,
        debugShowMaterialGrid: false,
        themeMode: ThemeMode.light,
        home: homeScreen,
      ),
    );
  }


}


