import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:move/app/components/input_conatiner.dart';
import 'package:move/app/components/rounded_button.dart';
import 'package:move/app/components/rounded_input.dart';
import 'package:move/app/models/LoginResponse.dart';
import 'package:move/app/services/shared_config.dart';
import 'package:move/app/view/authPages/register.dart';
import 'package:http/http.dart' as http;
import 'package:move/app/view/menu_dashboard_layout.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  final _formKeyLogin = GlobalKey<FormState>();
  String _password, _username = "";
  FocusNode _usernameFocusNode = FocusNode();

  FocusNode _passwordFocusNode = FocusNode();
  IconData passwordIconData = Icons.visibility_off_outlined;
  bool _obscureText = true;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  var loginResponse;
  var passHash;
  String _platform;
  String _deviceId;

  @override
  void initState() {
    super.initState();
    print(StorageUtil.getString("token"));
  }

  Future<void> initPlatformState() async {
    String deviceId;

    try {
      deviceId = await PlatformDeviceId.getDeviceId;
    } on PlatformException {
      deviceId = 'Failed to get deviceId.';
    }

    if (!mounted) return;

    setState(() {
      _deviceId = deviceId;
      print("deviceId->$_deviceId");
    });
  }

  Future<void> platformState() async {
    String platform;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      if (Platform.isAndroid) {
        setState(() {
          platform = "Android";
        });
      } else if (Platform.isIOS) {
        platform = "IOS";
      }
    } on PlatformException {
      setState(() {
        platform = 'Failed to get deviceId.';
      });
    }

    setState(() {
      _platform = platform;
      print("platform->$_platform");
    });
  }

  Future<LoginResponse> login(String bodyMap) async {
    final response = await http.post(
      Uri.parse('https://movetech.app/api/user/login'),
      headers: {
        "Authorization":
            "z8Aq9GkZap3rFytZXlvAIsfIfFkyiUadltS5KD9IijQ36Xtk11iEPNl2lA9n",
        "Content-Type": "application/json",
        "Device": _deviceId,
        "Platform": _platform,
      },
      body: bodyMap,
    );

    if (response.statusCode == 200) {
      print("içeride");
      print(response.body);
      setState(() {
        loginResponse = LoginResponse.fromJson(jsonDecode(response.body));
      });

      return LoginResponse.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 400) {
      setState(() {
        loginResponse = LoginResponse.fromJson(jsonDecode(response.body));
      });

      print("400 dönüyor kullanıcı not ok.");
      print(response.body);
      return LoginResponse.fromJson(jsonDecode(response.body));
    } else {
      print("hattaa");
    }
  }

  Future<LoginResponse> _futueLogin;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/loginbg.png"), fit: BoxFit.cover)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 100.0),
                child: Row(
                  children: [
                    Text(
                      'Sign In',
                      style: TextStyle(
                        fontFamily: 'Metropolis',
                        fontSize: 25,
                        color: const Color(0xffffffff),
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Form(
                  key: _formKeyLogin,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Kullanıcı adınız',
                                  style: TextStyle(
                                    fontFamily: 'Metropolis',
                                    fontSize: 18,
                                    color: const Color(0xffffffff),
                                    letterSpacing: -0.36,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              SizedBox(height: 3),
                              InputContainer(
                                child: TextFormField(
                                  focusNode: _usernameFocusNode,
                                  autofocus: true,
                                  style: TextStyle(
                                    fontFamily: 'Metropolis',
                                    fontSize: 18,
                                    color: const Color(0xff000000),
                                    letterSpacing: -0.36,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  controller: usernameController,
                                  validator: (name) {
                                    Pattern pattern =
                                        r'^[A-Za-z0-9]+(?:[ _-][A-Za-z0-9]+)*$';
                                    RegExp regex = new RegExp(pattern);
                                    if (!regex.hasMatch(name))
                                      return 'Hatalı kullanıcı adı';
                                    else
                                      return null;
                                  },
                                  onSaved: (name) => _username = name,
                                  onFieldSubmitted: (_) {
                                    fieldFocusChange(context,
                                        _usernameFocusNode, _usernameFocusNode);
                                  },
                                  cursorColor: const Color(0xff303030),
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 2.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: const Color(0xff909090))),
                                    hintText: "Kullanıcı adınızı girin",
                                    hintStyle: TextStyle(
                                      fontFamily: 'Metropolis',
                                      fontSize: 18,
                                      color: const Color(0xff808080),
                                      letterSpacing: -0.36,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: Column(
                            children: [
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Şifreniz',
                                    style: TextStyle(
                                      fontFamily: 'Metropolis',
                                      fontSize: 18,
                                      color: const Color(0xffffffff),
                                      letterSpacing: -0.36,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    textAlign: TextAlign.left,
                                  )),
                              SizedBox(height: 3),
                              Container(
                                color: Colors.white,
                                child: TextFormField(
                                  focusNode: _passwordFocusNode,
                                  autofocus: true,
                                  cursorColor: const Color(0xff303030),
                                  initialValue: null,
                                  controller: passwordController,
                                  style: TextStyle(
                                    fontFamily: 'Metropolis',
                                    fontSize: 18,
                                    color: const Color(0xff000000),
                                    letterSpacing: -0.36,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  decoration: InputDecoration(
                                    suffixIcon: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: IconButton(
                                        color: const Color(0xff303030),
                                        onPressed: () {
                                          _toggle();
                                          _obscureText
                                              ? passwordIconData =
                                                  Icons.visibility_off_outlined
                                              : passwordIconData =
                                                  Icons.visibility_outlined;
                                        },
                                        icon: Icon(
                                          passwordIconData,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: const Color(0xffBEBEBE),
                                          width: 2.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: const Color(0xff909090))),
                                    hintText: "Şifrenizi girin",
                                    hintStyle: TextStyle(
                                      fontFamily: 'Metropolis',
                                      fontSize: 18,
                                      color: const Color(0xff808080),
                                      letterSpacing: -0.36,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    border: InputBorder.none,
                                  ),
                                  validator: (val) => val.length < 6
                                      ? 'Password too short.'
                                      : null,
                                  onSaved: (val) => _password = val,
                                  obscureText: _obscureText,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: _futueLogin == null
                    ? RoundedButton(
                        title: "Giriş Yap",
                        onTap: () {
                          if (_formKeyLogin.currentState.validate()) {
                            _formKeyLogin.currentState.save();

                            initPlatformState();
                            platformState();
                            setState(() {
                              passHash = hashPassword(
                                  passwordController.text.toString());
                            });

                            setState(() {
                              _futueLogin = login(jsonEncode(
                                {
                                  "username":
                                      "${usernameController.text.toString()}",
                                  "password": "${passHash.toString()}",
                                },
                              ));
                            });
                          }
                        })
                    : FutureBuilder<LoginResponse>(
                        future: _futueLogin,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            print("data var");

                            if (snapshot.data.login == false) {
                              Fluttertoast.showToast(
                                  msg: "Kullanıcı adı veya şifre yanlış ",
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 3,
                                  backgroundColor: Colors.yellow,
                                  textColor: Colors.white,
                                  fontSize: 16.0);

                              SchedulerBinding.instance
                                  .addPostFrameCallback((_) {
                                setState(() {
                                  _futueLogin = null;
                                });
                              });
                            } else {
                              //shared pref işlemleri yapılacak.
                              if (snapshot.data != null) {
                                StorageUtil.putString("token",
                                    snapshot.data.userToken.toString());
                                print("shared oldu ve gidiyor.");
                                SchedulerBinding.instance
                                    .addPostFrameCallback((_) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              MenuDashboardPage()));
                                });
                              }
                            }

                            return Text("girdi");
                          } else if (snapshot.hasError) {
                            return Text('${snapshot.error}');
                          }

                          return const CircularProgressIndicator();
                        },
                      ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Register()),
                  );
                },
                child: Text.rich(
                  TextSpan(
                    style: TextStyle(
                      fontFamily: 'Metropolis',
                      fontSize: 16,
                      color: const Color(0xffffffff),
                      letterSpacing: -0.32,
                    ),
                    children: [
                      TextSpan(
                        text: 'Hesabınız yok mu?',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      TextSpan(
                        text: ' ',
                        style: TextStyle(
                          color: const Color(0xff646464),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      TextSpan(
                        text: 'Kayıt olun',
                        style: TextStyle(
                          color: const Color(0xffff2c33),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  textHeightBehavior:
                      TextHeightBehavior(applyHeightToFirstAscent: false),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

String hashPassword(String password) {
  final key = encrypt.Key.fromUtf8("y8KocTRrhuu5SJBqciaLWv3DAUIR8BYk");
  final iv = encrypt.IV.fromUtf8("3D9rqIv3tcOBlQLX");
  final encrypter =
      encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.cbc));

  final encrypted = encrypter.encrypt(password + "moveapp",
      iv: iv); // Lorem ipsum dolor sit amet, consectetur adipiscing elit
  print("passhash");
  print(encrypted.base64); // R4PxiU3h8YoIRqVowBXm36ZcCeNeZ
  return encrypted.base64;
}

void fieldFocusChange(
    BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
  currentFocus.unfocus();
  FocusScope.of(context).requestFocus(nextFocus);
}
