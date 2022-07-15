import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:first_flutter_proj/model/customIcons.dart';
import 'package:first_flutter_proj/poc_materials/bottomNavBar_poc.dart';
import 'package:first_flutter_proj/poc_materials/singleTon_poc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:splashscreen/splashscreen.dart';

import '../constants/textConstants.dart';
import '../constants/assetConstants.dart';
import 'View Pages/cart_viewpage.dart';
import 'dio_service/apiListcall_service.dart';
import 'dio_service/listmodel.dart';
import 'View Pages/CafeView.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
   List<listmodel> listapi = [];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bismi Cafe',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: SplashScreen(
      //   seconds: 5,
      //   navigateAfterSeconds:MyHomePage(),
      //   // title:  const Text(
      //   //   'SplashScreen Example',
      //   //   style:  TextStyle(
      //   //       fontWeight: FontWeight.bold,
      //   //       fontSize: 20.0,
      //   //       color: Colors.white),
      //   // ),
      //   backgroundColor: Colors.lightBlue[200],
      //   image: Image.asset("assets/Cafe Image_Jpg.jpg"),
      //   photoSize: 250,
      //   useLoader: false,
      // ),
      home:AnimatedSplashScreen(
          duration: 3000,
          splash: Icons.home,
          splashIconSize: 100,
          animationDuration: Duration(milliseconds: 2000),

          nextScreen: MyHomePage(),
          splashTransition: SplashTransition.rotationTransition,
          //pageTransitionType: PageTransitionType.scale,
          backgroundColor: Colors.blue)
    );
  }

  Future<List<listmodel>> apiListCall() async {
    listapi = await getList();
    return listapi;
  }
}

class itemsList extends StatefulWidget {
  itemsList({Key? key}) : super(key: key);
  @override
  State<itemsList> createState() => _itemsListState();
}

class _itemsListState extends State<itemsList> {
  final ScrollController _scrollController = ScrollController();
  List<listmodel> listapi = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(),
      appBar: AppBar(),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: <Widget>[
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.8,
            ),
            delegate: SliverChildListDelegate([
              FutureBuilder(
                future: apiListCall(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    // while data is loading:
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    // data loaded:
                    listmodel product = listapi[0];
                    return Container(
                      color: Colors.grey[400],
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30.0),
                        child: Center(child: Text(product.Name)),
                      ),
                    );
                  }
                },
              )
            ]),
          )
        ],
      ),
    );
  }

  Future<List<listmodel>> apiListCall() async {
    listapi = await getList();
    return listapi;
  }
}

class MyHomePage extends StatefulWidget {

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _title = 'Home';
  final Bodies = [const realHome(), IconFont(textConstants.BeveragesTitle)];
  final AppBarTitles = [ textConstants.HomeTitle, textConstants.BeveragesTitle];
  late gridViewList ko;
  @override
  void initState() {
     apiListCall();

  }
  void apiListCall() async {
    Singleton.instance.listapi = await getList() as List<listmodel>;
    //return widget.listapi;
  }
  void _onItemTapped(int index) {
    setState(() {
      Singleton.instance.selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: const Drawer(
      //   width: 100,
      // ),
      appBar: AppBar(automaticallyImplyLeading: false,title: Text(AppBarTitles[Singleton.instance.selectedIndex]),
    actions: [
          Visibility(
            visible: Singleton.instance.selectedIndex==1,
            child: InkWell(
                onTap: (){
                  if(Singleton.instance.SelectedIndexValues.isNotEmpty) {
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>  cartViewPage(textConstants.CartTitle)));
                  } else{
                  null;
                  }
                  },
                child: SvgPicture.asset(assetConstants.AddToCartIcon,height: 40,width: 40,color: Colors.yellow,)),
          )],
        centerTitle: true,
    ),
      //body: Container(child: SvgPicture.asset('lib/asset/veg.svg',height: 25,width: 25,),),
      //body: Container(child: SvgPicture.asset('assets/veg.svg',height: 25,width: 25,color: Colors.green,),),
      body: Bodies[Singleton.instance.selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_food_beverage),
            label: 'Available Beverages',
          ),
        ],
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.shifting,
        currentIndex: Singleton.instance.selectedIndex,
        selectedItemColor: Colors.amber[800],
        // unselectedFontSize: 40,
        onTap: _onItemTapped,
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Container buildMyNavBar(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      // child: Row(
      //   mainAxisAlignment: MainAxisAlignment.spaceAround,
      //   children: [
      //     IconButton(
      //       enableFeedback: false,
      //       onPressed: () {
      //         setState(() {
      //           pageIndex = 0;
      //         });
      //       },
      //       icon: pageIndex == 0
      //           ? const Icon(
      //         Icons.home_filled,
      //         color: Colors.white,
      //         size: 35,
      //       )
      //           : const Icon(
      //         Icons.home_outlined,
      //         color: Colors.white,
      //         size: 35,
      //       ),
      //     ),
      //     IconButton(
      //       enableFeedback: false,
      //       onPressed: () {
      //         setState(() {
      //           pageIndex = 1;
      //         });
      //       },
      //       icon: pageIndex == 1
      //           ? const Icon(
      //         Icons.work_rounded,
      //         color: Colors.white,
      //         size: 35,
      //       )
      //           : const Icon(
      //         Icons.work_outline_outlined,
      //         color: Colors.white,
      //         size: 35,
      //       ),
      //     ),
      //     IconButton(
      //       enableFeedback: false,
      //       onPressed: () {
      //         setState(() {
      //           pageIndex = 2;
      //         });
      //       },
      //       icon: pageIndex == 2
      //           ? const Icon(
      //         Icons.widgets_rounded,
      //         color: Colors.white,
      //         size: 35,
      //       )
      //           : const Icon(
      //         Icons.widgets_outlined,
      //         color: Colors.white,
      //         size: 35,
      //       ),
      //     ),
      //     IconButton(
      //       enableFeedback: false,
      //       onPressed: () {
      //         setState(() {
      //           pageIndex = 3;
      //         });
      //       },
      //       icon: pageIndex == 3
      //           ? const Icon(
      //         Icons.person,
      //         color: Colors.white,
      //         size: 35,
      //       )
      //           : const Icon(
      //         Icons.person_outline,
      //         color: Colors.white,
      //         size: 35,
      //       ),
      //     ),
      //   ],
      // ),
    );
  }

}
class realHome extends StatelessWidget { // Home Page [Page number 1]
  const realHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
        decoration:   const BoxDecoration(image:  DecorationImage(
        image: AssetImage("assets/Cafe Image_Jpg.jpg"),
    fit: BoxFit.cover,
    )),child:  Center(
      child: Text('Welcome To Bismi Snacks and Cool Bar',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,fontStyle: FontStyle.italic,color: Colors.blue[900]),),
    ),);
  }
}
class IconFont extends StatelessWidget {
  String title;
  IconFont(this.title);
  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
          future: apiListCall(),
          builder: (BuildContext context, AsyncSnapshot<List<listmodel>> snapshot) {
            if(snapshot.hasData){
              return gridViewList(title,Singleton.instance.listapi);
            }
            return Center(child: CircularProgressIndicator());
          },
        );
  }

  Future<List<listmodel>> apiListCall() async {
    Singleton.instance.listapi = await getList();
    return Singleton.instance.listapi;
  }
}

