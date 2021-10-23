import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_app/Network/local/cache_helper.dart';

class MyBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    print('onCreate -- ${bloc.runtimeType}');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('onChange -- ${bloc.runtimeType}, $change');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('onError -- ${bloc.runtimeType}, $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    print('onClose -- ${bloc.runtimeType}');
  }
}

// void signOut(context) {
//   CacheHelper.deleteData(key: 'token').then(
//         (value) {
//       if (value) {
//         Navigator.pushAndRemoveUntil(
//           context,
//           MaterialPageRoute(
//               builder: (BuildContext context) => ShopLoginScreen()),
//               (Route<dynamic> route) => false,
//         );
//       }
//     },
//   );
// }

String? token ;
