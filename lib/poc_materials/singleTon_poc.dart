// class Singleton {
//   static final Singleton _singleton = Singleton._internal();
//
//   factory Singleton() {
//     return _singleton;
//   }
//
//   Singleton._internal();
// }
//
// main() {
//   var s1 = Singleton();
//   var s2 = Singleton();
//   print(identical(s1, s2));  // true
//   print(s1 == s2);           // true
// }

import '../dio_service/listmodel.dart';

class Singleton {
  static Singleton _instance = Singleton._();

  Singleton._();

  static Singleton get instance => _instance;
  List<listmodel> listapi = [];
  List<listmodel> SelectedIndexValues = [];
  int selectedIndex = 0;
  void someMethod(){

  }


}