import 'package:flutter/material.dart';
import 'package:move/app/view/authPages/register.dart';

import 'login.dart';

class SplashTwo extends StatefulWidget {
  @override
  _SplashTwoState createState() => _SplashTwoState();
}

class _SplashTwoState extends State<SplashTwo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/splashbg.png"), fit: BoxFit.cover)),
      child: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Adobe XD layer: 'Digital' (text)
              Text(
                'Party?',
                style: TextStyle(
                  fontFamily: 'Metropolis',
                  fontSize: 40,
                  color: const Color(0xffffffff),
                  letterSpacing: -2,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ), // Adobe XD layer: 'Digital' (text)
              Text(
                'Where?',
                style: TextStyle(
                  fontFamily: 'Metropolis',
                  fontSize: 50,
                  color: const Color(0xffff2c33),
                  letterSpacing: -2.5,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          Image.asset('assets/coolguy.png'),
          Column(
            children: [
              SizedBox(
                width: 299.0,
                height: 158.0,
                child: Scrollbar(
                  child: SingleChildScrollView(
                    child: Text.rich(
                      TextSpan(
                        style: TextStyle(
                          fontFamily: 'Metropolis',
                          fontSize: 13,
                          color: const Color(0xffffffff),
                        ),
                        children: [
                          TextSpan(
                            text:
                                'Move bir aracı sosyal medya uygulamasıdır.\nBirlikte çalıştığı  eğlence işletmeleri ve organizatörlerin düzenlediği bütün etkinliklerin görünmesi ve katılımını kolaylaştırma misyonuna sahip bir mobil uygulamasıdır.\n\n',
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          TextSpan(
                            text:
                                'Hangi parti nerede? Ne zaman? Kimler gidecek ?\n',
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          TextSpan(
                            text: '\nİşte bütün bu bilgiler ',
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          TextSpan(
                            text: 'Move‘',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextSpan(
                            text: 'da .\n',
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                      textHeightBehavior:
                          TextHeightBehavior(applyHeightToFirstAscent: false),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Register()),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(color: Colors.red, width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                              fontFamily: 'Metropolis',
                              fontSize: 20,
                              color: const Color(0xffff2c33),
                              letterSpacing: -0.4,
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Login()),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Sign In',
                            style: TextStyle(
                              fontFamily: 'Metropolis',
                              fontSize: 20,
                              color: const Color(0xffffffff),
                              letterSpacing: -0.4,
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    ));
  }
}
