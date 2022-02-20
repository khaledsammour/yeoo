import 'package:flutter/material.dart';
import 'package:yeeo/pressentation/resource/stringsManager.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage(ImageStrings.rectangle),
            fit: BoxFit.cover,
          )),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(
                flex: 1,
              ),
              Flexible(
                  flex: 3,
                  child: Container(
                      margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * .3),
                      child: Image.asset(ImageStrings.bigPolygon))),
              const Spacer(
                flex: 1,
              ),
              Flexible(
                  flex: 3,
                  child: Container(
                      margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * .1),
                      child: Image.asset(ImageStrings.yeeo))),
              const Spacer(
                flex: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
