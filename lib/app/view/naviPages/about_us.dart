import 'package:flutter/material.dart';

class AboutUs extends StatefulWidget {
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: const Color(0xff52006A),
        centerTitle: true,
        title: Text(
          'Hakkımzıda',
          style: TextStyle(
            fontFamily: 'Nunito Sans',
            fontSize: 14,
            color: const Color(0xffffffff),
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.left,
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [const Color(0XFF52006A), const Color(0xFF05091A)],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Column(
            children: [
              Text(
                'BİZİM HAKKIMIZDA \nNE BİLİYORSUN ?',
                style: TextStyle(
                  fontFamily: 'Metropolis',
                  fontSize: 28,
                  color: const Color(0x80ffffff),
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.left,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    child: Scrollbar(
                        child: SingleChildScrollView(
                            child: Text(
                      "Move, KAF şirketinin ilk ürünü olup, çevrenizde bulunan eğlenceleri ve aktivetileri size tek adresten bilginize sunan, aktivite bazlı sosyal medya uygulamasıdır. Aktiviteler hakkında her türlü bilgiye ulaşabileceğiniz ve gitmek istediğiniz aktiviteler hakkındaki bütün işlemleri tek araç ile yapabilmenizi amaçladığımız Move ile arkadaş edinmek de artık daha basit. Move ile her şey daha hızlı ve eğlenceli. Durma, Move'la!",
                      style: TextStyle(
                        fontFamily: 'Nunito Sans',
                        fontSize: 12,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.left,
                    ))),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
