import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:property_sale/selectionPage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
    SystemUiOverlay.bottom, //This line is used for showing the bottom bar
  ]);

  runApp(MaterialApp(
    home: LoginPage(
      userId: _SignUpPageState(),
      password: _SignUpPageState(),
    ),
    debugShowCheckedModeBanner: false,
  ));
}

class User {
  String userId;
  String password;

  User({required this.userId, required this.password});
}

class UsersData {
  static List<User> users = [];
}

class LoginPage extends StatefulWidget {
  final userId;
  final password;
  const LoginPage({super.key, required this.userId, required this.password});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _userIdController = TextEditingController(text: "");
  final TextEditingController _passwordController = TextEditingController(text: "");
  bool _isHidden = true;
  bool _validateUser(String userId, String password) {
    for (User user in UsersData.users) {
      if (user.userId == userId && user.password == password) {
        return true; // User found and credentials match
      }
    }
    return false; // User not found or credentials don't match
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Stack(children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            decoration: const BoxDecoration(
                gradient:
                LinearGradient(colors: [Colors.orange,Colors.yellow])),
            child: const Padding(
              padding: EdgeInsets.only(top: 60, left: 20),
              child: Text(
                'Hello Welcome\n SignIn to your account',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding:  EdgeInsets.only(top: 200),
            child: Container(
              height: 600,
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(40),
                     )),
              child: Column(
                children: [
                  Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(25.0),
                            child: TextFormField(
                                autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                                controller: _userIdController,
                                decoration: InputDecoration(
                                    label: const Text(
                                      'UserId',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                    suffixIcon: const Icon(Icons.person),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(20))),
                                validator: (String? userid) {
                                  if (userid == null || userid.isEmpty) {
                                    return 'Please enter a userid';
                                  } else if (userid.length < 5) {
                                    return 'UserId should be atleast 5 characters';
                                  }
                                  return null; // Return null for valid input
                                }),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(25.0),
                            child: TextFormField(
                                autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                                controller: _passwordController,
                                obscureText: _isHidden ? true : false,
                                decoration: InputDecoration(
                                    label: const Text(
                                      'Password',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                    suffixIcon: InkWell(
                                      onTap: _changetoVisible,
                                      child: Icon(_isHidden
                                          ? Icons.visibility_off
                                          : Icons.visibility),
                                    ),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(20))),
                                validator: (password) {
                                  if (password == null || password.isEmpty) {
                                    return 'Please enter a password';
                                  }
                                  RegExp pwdRegExp = RegExp(
                                      r'^(?=.*[A-Za-z]+)(?=.*\d+)(?=.*[@$!%*?#&]+)[A-Za-z\d@$!%*?#&]{8,}$');
                                  if (!pwdRegExp.hasMatch(password)) {
                                    return 'Enter a valid password';
                                  }
                                  return null; // Return null for valid input
                                }),
                          ),
                        ],
                      )),
                  Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [Colors.orange,Colors.yellow]),
                        borderRadius: BorderRadius.circular(20)),
                    child: MaterialButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          String userId = _userIdController.text;
                          String password = _passwordController.text;

                          if (_validateUser(userId, password)) {
                            // Credentials are valid, navigate to the authenticated page
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => categories(),
                              ),
                            );
                          } else {
                            // Show an error message or handle failed login
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Login Failed'),
                                  content: const Text(
                                      'Invalid credentials. Please try again.'),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      child: const Text('OK'),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        }
                      },
                      child: const Text('Login'),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Do not have account?'),
                      RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text: 'SignUp',
                                style: const TextStyle(
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline,
                                  decorationThickness: 3,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => const SignUpPage()));
                                  })
                          ]))
                    ],
                  )
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }

  void _changetoVisible() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }
}

//.....................SignUp page.....................................//
void main1() => runApp( MaterialApp(
  home: SignUpPage(),
  debugShowCheckedModeBanner: false,
));

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _userIdController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmpasswordController =
  TextEditingController();
  bool _passwordsMatch = true;

  void _checkPasswordMatch() {
    setState(() {
      _passwordsMatch =
          _passwordController.text == _confirmpasswordController.text;
    });
  }

  bool _isHidden = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Stack(children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                gradient:
                LinearGradient(colors: [Colors.orange,Colors.yellow])),
            child: const Padding(
              padding: EdgeInsets.only(top: 60, left: 20),
              child: Text(
                'Create an account',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 200,
              left: 10,
              right: 10,
            ),
            child: Container(
              height: 600,
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  )),
              child: Column(
                children: [
                  Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(25.0),
                            child: TextFormField(
                                autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                                controller: _userIdController,
                                decoration: InputDecoration(
                                    label: const Text(
                                      'UserId',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                    prefixIcon: const Icon(Icons.person),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(20))),
                                validator: (String? userid) {
                                  if (userid == null || userid.isEmpty) {
                                    return 'Please enter a userid';
                                  } else if (userid.length < 5) {
                                    return 'UserId should be atleast 5 characters';
                                  }
                                  return null; // Return null for valid input
                                }),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(25.0),
                            child: TextFormField(
                              autovalidateMode:
                              AutovalidateMode.onUserInteraction,
                              controller: _emailController,
                              decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.mail),
                                  label: const Text(
                                    'Email',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.circular(20.0))),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your email';
                                }
                                RegExp emailRegExp = RegExp(
                                  //reg Exp to evaluate email of the type 'name@gmail.com' and 'clg mail id'
                                    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                                if (!emailRegExp.hasMatch(value)) {
                                  return 'please enter a valid email';
                                }
                                return null;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(25.0),
                            child: TextFormField(
                                autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                                controller: _passwordController,
                                obscureText: _isHidden ? true : false,
                                decoration: InputDecoration(
                                    label: const Text(
                                      'Password',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                    prefixIcon: const Icon(Icons.lock),
                                    suffixIcon: InkWell(
                                      onTap: _changetoVisible,
                                      child: Icon(_isHidden
                                          ? Icons.visibility_off
                                          : Icons.visibility),
                                    ),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(20))),
                                validator: (password) {
                                  if (password == null || password.isEmpty) {
                                    return 'Please enter a password';
                                  }
                                  RegExp pwdRegExp = RegExp(
                                      r'^(?=.*[A-Za-z]+)(?=.*\d+)(?=.*[@$!%*?#&]+)[A-Za-z\d@$!%*?#&]{8,}$');
                                  if (!pwdRegExp.hasMatch(password)) {
                                    return 'Enter a valid password';
                                  }

                                  return null; // Return null for valid input
                                }),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(25.0),
                            child: TextFormField(
                                autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                                controller: _confirmpasswordController,
                                obscureText: _isHidden ? true : false,
                                decoration: InputDecoration(
                                    label: const Text(
                                      'Confirm password',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                    prefixIcon: const Icon(Icons.lock),
                                    suffixIcon: InkWell(
                                      onTap: _changetoVisible,
                                      child: Icon(_isHidden
                                          ? Icons.visibility_off
                                          : Icons.visibility),
                                    ),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(20))),
                                onChanged: (_) {
                                  _checkPasswordMatch();
                                },
                                validator: (password) {
                                  if (password == null || password.isEmpty) {
                                    return 'Enter the password agian';
                                  } else if (!_passwordsMatch) {
                                    return 'Password does not match';
                                  }
                                  return null; // Return null for valid input
                                }),
                          ),
                        ],
                      )),
                  Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [Colors.orange,Colors.yellow]),
                        borderRadius: BorderRadius.circular(20)),
                    child: MaterialButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          String userId = _userIdController.text;
                          String password = _passwordController.text;

                          UsersData.users
                              .add(User(userId: userId, password: password));

                          // Navigate back to the login page with the entered credentials
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage(
                                    userId: _userIdController.text,
                                    password: _passwordController.text,
                                  )));
                        }
                      },
                      child: const Text('SignUp'),
                    ),
                  ),
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }

  void _changetoVisible() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }
}
