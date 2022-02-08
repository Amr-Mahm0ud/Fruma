import 'package:flutter/material.dart';
import 'package:fruma/main_page.dart';
import 'package:fruma/page_view.dart';
import 'package:fruma/provider_controller.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences _pref = await SharedPreferences.getInstance();
  var email = _pref.getString('email');
  var password = _pref.getString('password');
  runApp((email == null || email == '') && (password == null || password == '')
      ? MySplashScreen(false)
      : MySplashScreen(true));
}

// ignore: must_be_immutable
class MySplashScreen extends StatelessWidget {
  MySplashScreen(this.signedIn, {Key? key}) : super(key: key);
  bool signedIn;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => MyProvider(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: SplashScreenView(
              navigateRoute:
                  signedIn == true ? const MainPage() : const MyPageView(),
              backgroundColor: const Color(0xFFfffc99),
              imageSize: 250,
              imageSrc: "assets/images/logo.png",
              pageRouteTransition: PageRouteTransition.CupertinoPageRoute,
              text: 'Please wait',
              textStyle: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange),
              textType: TextType.TyperAnimatedText),
          theme: ThemeData(
            canvasColor: Colors.white,
            primarySwatch: Colors.amber,
          )),
    );
  }
}
