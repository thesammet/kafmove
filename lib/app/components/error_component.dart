import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ErrorComponent extends StatelessWidget {
  final String errorMessage;

  final Function onRetryPressed;

  const ErrorComponent({Key key, this.errorMessage, this.onRetryPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'assets/images/errorimage.png',
            width: MediaQuery.of(context).size.width / 3,
          ),
          Text(
            "Oops!",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: const Color(0xff303030),
                fontSize: 40,
                fontFamily: "Ubuntu"),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
            child: Text(
              errorMessage + "\nBir hata oluştu. Lütfen yenilemeyi deneyin.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: "OpenSans",
                color: const Color(0xff909090),
                fontSize: 11,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0, bottom: 100.0),
            child: RaisedButton(
              color: const Color(0xff909090),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 50),
                child: Text('Yenile',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "OpenSans",
                      fontSize: 16,
                    )),
              ),
              onPressed: onRetryPressed,
            ),
          ),
        ],
      ),
    );
  }
}
