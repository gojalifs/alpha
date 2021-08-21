import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: Future.delayed(const Duration(
            seconds: 10,
          )),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                SizedBox(
                  child: CircularProgressIndicator(),
                  width: 60,
                  height: 60,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text('Awaiting result...'),
                )
              ],
            );
          },

          /*


           */
        ),
      ),
    );
  }
}
