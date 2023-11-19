import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:property_sale/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:property_sale/selectionPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
    SystemUiOverlay.bottom, //This line is used for showing the bottom bar
  ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    await Future.delayed(Duration(seconds: 2)); // Adjust the duration as needed

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('userId');
    String? password = prefs.getString('password');

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginOrCategoriesScreen(userId: userId, password: password),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Property Harbor',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}

class LoginOrCategoriesScreen extends StatelessWidget {
  final String? userId;
  final String? password;

  const LoginOrCategoriesScreen({
    Key? key,
    this.userId,
    this.password,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (userId != null && password != null) {
      return Categories();
    } else {
      return LoginPage(userId: null, password: null,);
    }
  }
}
