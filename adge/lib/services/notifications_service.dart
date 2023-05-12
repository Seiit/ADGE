import 'package:flutter/material.dart';

int _duration = 2000;

class NotificationsService {
  static GlobalKey<ScaffoldMessengerState> messengerKey =
      new GlobalKey<ScaffoldMessengerState>();

  static Map<String, dynamic> _positionCalcule(context) {
    Map<String, dynamic> res = {};
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var paddingLeft = 0.0;
    var paddingRight = 0.0;

    if (width < 500) {
      paddingLeft = width * 0.1;
      paddingRight = 0.1;
    } else {
      paddingRight = 0.1;
      paddingLeft = width - 400 - (width * paddingRight);
    }

    res = {
      'height': height,
      'width': width,
      'paddingLeft': paddingLeft,
      'paddingRight': paddingRight
    };

    return res;
  }

  static showSnackbarError(String title, String message, context) {
    Map<String, dynamic> dimenciones = _positionCalcule(context);

    var height = dimenciones['height'];
    var width = dimenciones['width'];
    var paddingLeft = dimenciones['paddingLeft'];
    var paddingRight = dimenciones['paddingRight'];

    final snackBar = SnackBar(
        duration: Duration(milliseconds: _duration),
        content: Container(
            padding: const EdgeInsets.all(8),
            height: 100,
            decoration: const BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Row(
              children: [
                const Icon(
                  Icons.warning,
                  color: Colors.white,
                  size: 40,
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Spacer(),
                    Text(
                      title,
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      message,
                      style: const TextStyle(color: Colors.white, fontSize: 15),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Spacer()
                  ],
                ))
              ],
            )),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
        margin: EdgeInsets.only(
            bottom: height - 120,
            left: paddingLeft,
            right: width * paddingRight));

    messengerKey.currentState!.showSnackBar(snackBar);
  }

  static showSnackbarAlert(String title, String message, context) {
    Map<String, dynamic> dimenciones = _positionCalcule(context);

    var height = dimenciones['height'];
    var width = dimenciones['width'];
    var paddingLeft = dimenciones['paddingLeft'];
    var paddingRight = dimenciones['paddingRight'];

    final snackBar = SnackBar(
        duration: Duration(milliseconds: _duration),
        content: Container(
            padding: const EdgeInsets.all(8),
            height: 100,
            decoration: const BoxDecoration(
                color: Colors.yellow,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Row(
              children: [
                const Icon(
                  Icons.warning,
                  color: Colors.white,
                  size: 40,
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Spacer(),
                    Text(
                      title,
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      message,
                      style: const TextStyle(color: Colors.white, fontSize: 15),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Spacer()
                  ],
                ))
              ],
            )),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
        margin: EdgeInsets.only(
            bottom: height - 120,
            left: paddingLeft,
            right: width * paddingRight));

    messengerKey.currentState!.showSnackBar(snackBar);
  }

  static showSnackbarSucces(String title, String message, context) {
    Map<String, dynamic> dimenciones = _positionCalcule(context);

    var height = dimenciones['height'];
    var width = dimenciones['width'];
    var paddingLeft = dimenciones['paddingLeft'];
    var paddingRight = dimenciones['paddingRight'];

    final snackBar = SnackBar(
        duration: Duration(milliseconds: _duration),
        content: Container(
            padding: const EdgeInsets.all(8),
            height: 100,
            decoration: const BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Row(
              children: [
                const Icon(
                  Icons.warning,
                  color: Colors.white,
                  size: 40,
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Spacer(),
                    Text(
                      title,
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      message,
                      style: const TextStyle(color: Colors.white, fontSize: 15),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Spacer()
                  ],
                ))
              ],
            )),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
        margin: EdgeInsets.only(
            bottom: height - 120,
            left: paddingLeft,
            right: width * paddingRight));

    messengerKey.currentState!.showSnackBar(snackBar);
  }

  static showBusyIndicator(BuildContext context) {
    final AlertDialog dialog = AlertDialog(
      content: Container(
        width: 100,
        height: 100,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );

    showDialog(context: context, builder: (_) => dialog);
  }
}
