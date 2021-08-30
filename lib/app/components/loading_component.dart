import 'package:flutter/material.dart';

class LoadingComponent extends StatelessWidget {
  final String loadingMessage;

  const LoadingComponent({Key key, this.loadingMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(
            color: Colors.white,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Text(
              loadingMessage,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xff303030),
                fontFamily: "OpenSans",
                fontSize: 26,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
