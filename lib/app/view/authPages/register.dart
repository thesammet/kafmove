import 'dart:convert';
import 'dart:io';
import 'package:email_validator/email_validator.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:move/app/components/input_conatiner.dart';
import 'package:move/app/components/rounded_button.dart';
import 'package:move/app/components/rounded_input.dart';
import 'package:move/app/models/RegisterResponse.dart';
import 'package:http/http.dart' as http;
import 'package:move/app/services/shared_config.dart';
import 'package:move/app/view/menu_dashboard_layout.dart';
import 'package:platform_device_id/platform_device_id.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  FocusNode _usernameFocusNode = FocusNode();
  FocusNode _emailFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();
  FocusNode _lastNameFocusNode = FocusNode();
  FocusNode _firstNameFocusNode = FocusNode();
  FocusNode _phoneFocusNode = FocusNode();
  IconData passwordIconData = Icons.visibility_off_outlined;
  String _username, _email, _password, _firstName, _lastName, _phone = "";
  bool _obscureText = true;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  var passHash;
  var registerResponse;
  String _platform;
  String _deviceId;

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

  Future<RegisterResponse> register(String bodyMap) async {
    final response = await http.post(
      Uri.parse('https://movetech.app/api/user/register'),
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
        registerResponse = RegisterResponse.fromJson(jsonDecode(response.body));
      });

      return RegisterResponse.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 400) {
      setState(() {
        registerResponse = RegisterResponse.fromJson(jsonDecode(response.body));
      });

      print("400 dönüyor kullanıcı not ok.");
      print(response.body);
      return RegisterResponse.fromJson(jsonDecode(response.body));
    } else {
      print("hattaa");
    }
  }

  File _imageFile;
  Future<void> _selectAndPickImage() async {
    _imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    print(_imageFile);
  }

  Future<RegisterResponse> _futureRegister;
  @override
  Widget build(BuildContext context) {
    final double _screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/registerbg.png"), fit: BoxFit.cover)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 100.0),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Sign UP',
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
              InkWell(
                onTap: _selectAndPickImage,
                child: CircleAvatar(
                  radius: _screenWidth * 0.15,
                  backgroundColor: Colors.white,
                  backgroundImage:
                      _imageFile == null ? null : FileImage(_imageFile),
                  child: _imageFile == null
                      ? Icon(
                          Icons.person,
                          size: _screenWidth * 0.15,
                          color: Colors.grey,
                        )
                      : null,
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
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
                                controller: username,
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
                                  fieldFocusChange(context, _usernameFocusNode,
                                      _emailFocusNode);
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
                                'Mailiniz',
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
                                focusNode: _emailFocusNode,
                                autofocus: true,
                                style: TextStyle(
                                  fontFamily: 'Metropolis',
                                  fontSize: 18,
                                  color: const Color(0xff000000),
                                  letterSpacing: -0.36,
                                  fontWeight: FontWeight.w500,
                                ),
                                controller: email,
                                validator: (email) =>
                                    EmailValidator.validate(email)
                                        ? null
                                        : "Hatalı mail adresi",
                                onSaved: (email) => _email = email,
                                onFieldSubmitted: (_) {
                                  fieldFocusChange(context, _emailFocusNode,
                                      _passwordFocusNode);
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
                                  hintText: "Mailinizi girin",
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
                                'İsminiz',
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
                                focusNode: _firstNameFocusNode,
                                autofocus: true,
                                style: TextStyle(
                                  fontFamily: 'Metropolis',
                                  fontSize: 18,
                                  color: const Color(0xff000000),
                                  letterSpacing: -0.36,
                                  fontWeight: FontWeight.w500,
                                ),
                                controller: firstName,
                                validator: (name) {
                                  Pattern pattern =
                                      r'^[A-Za-z0-9]+(?:[ _-][A-Za-z0-9]+)*$';
                                  RegExp regex = new RegExp(pattern);
                                  if (!regex.hasMatch(name))
                                    return 'Hatalı isim';
                                  else
                                    return null;
                                },
                                onSaved: (name) => _firstName = name,
                                onFieldSubmitted: (_) {
                                  fieldFocusChange(context, _usernameFocusNode,
                                      _emailFocusNode);
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
                                  hintText: "İsminizi girin",
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
                                'Soyisminiz',
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
                                focusNode: _lastNameFocusNode,
                                autofocus: true,
                                style: TextStyle(
                                  fontFamily: 'Metropolis',
                                  fontSize: 18,
                                  color: const Color(0xff000000),
                                  letterSpacing: -0.36,
                                  fontWeight: FontWeight.w500,
                                ),
                                controller: lastName,
                                validator: (name) {
                                  Pattern pattern =
                                      r'^[A-Za-z0-9]+(?:[ _-][A-Za-z0-9]+)*$';
                                  RegExp regex = new RegExp(pattern);
                                  if (!regex.hasMatch(name))
                                    return 'Hatalı soyisim';
                                  else
                                    return null;
                                },
                                onSaved: (name) => _lastName = name,
                                onFieldSubmitted: (_) {
                                  fieldFocusChange(context, _usernameFocusNode,
                                      _emailFocusNode);
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
                                  hintText: "Soyisminizi girin",
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
                                  'Telefon numaranız',
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
                            InputContainer(
                              child: TextFormField(
                                keyboardType: TextInputType.phone,
                                focusNode: _phoneFocusNode,
                                autofocus: true,
                                style: TextStyle(
                                  fontFamily: 'Metropolis',
                                  fontSize: 18,
                                  color: const Color(0xff000000),
                                  letterSpacing: -0.36,
                                  fontWeight: FontWeight.w500,
                                ),
                                controller: phone,
                                validator: (name) {
                                  Pattern pattern =
                                      r'^[A-Za-z0-9]+(?:[ _-][A-Za-z0-9]+)*$';
                                  RegExp regex = new RegExp(pattern);
                                  if (!regex.hasMatch(name))
                                    return 'Hatalı telefon numarası';
                                  else
                                    return null;
                                },
                                onSaved: (name) => _phone = name,
                                onFieldSubmitted: (_) {
                                  fieldFocusChange(context, _usernameFocusNode,
                                      _emailFocusNode);
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
                                  hintText: "Telefon numaranızı girin",
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
                                controller: password,
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
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: _futureRegister == null
                    ? RoundedButton(
                        title: "Giriş Yap",
                        onTap: () {
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();

                            initPlatformState();
                            platformState();
                            setState(() {
                              passHash = hashPassword(password.text.toString());
                            });

                            setState(() {
                              _futureRegister = register(jsonEncode(
                                {
                                  "username": "${username.text.toString()}",
                                  "password": "${passHash.toString()}",
                                  "firstName": "${firstName.text.toString()}",
                                  "lastName": "${lastName.text.toString()}",
                                  "email": "${email.text.toString()}",
                                  "phone": "${phone.text.toString()}",
                                  "sex": "Male",
                                  "latitude": "36.549362",
                                  "longitude": "31.996994"
                                },
                              ));
                            });
                          }
                        })
                    : FutureBuilder<RegisterResponse>(
                        future: _futureRegister,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            print("data var");

                            if (snapshot.data.register == false) {
                              Fluttertoast.showToast(
                                  msg:
                                      "Kullanıcı adı veya Email daha önce kullanılmış ",
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 3,
                                  backgroundColor: Colors.yellow,
                                  textColor: Colors.white,
                                  fontSize: 16.0);

                              SchedulerBinding.instance
                                  .addPostFrameCallback((_) {
                                setState(() {
                                  _futureRegister = null;
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
                            setState(() {
                              _futureRegister = null;
                            });
                            Fluttertoast.showToast(
                                msg:
                                    "Hata meydana geldi. Daha sonra tekrar deneyin.",
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 3,
                                backgroundColor: Colors.yellow,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          }

                          return const CircularProgressIndicator();
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void toastMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        fontSize: 16.0);
  }

  void fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
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
}
