import 'package:currency_now/screens/splash_screen/models/splash_screen_model.dart';
import 'package:currency_now/widgets/buttons/default_button.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class SplashScreen extends StatefulWidget {
  final SplashScreenModel model;

  const SplashScreen({Key? key, required this.model}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      widget.model.init(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: FadeInImage(
                width: 200,
                height: 200,
                fit: BoxFit.contain,
                placeholder: MemoryImage(kTransparentImage),
                image: const AssetImage("assets/images/logo.png")),
          ),
          Positioned(
            bottom: MediaQuery.of(context).padding.bottom + 20,
            left: 0,
            right: 0,
            child: Center(
                child: widget.model.hasError
                    ? DefaultButton(
                        color: Colors.red,
                        height: 40,
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: const [
                            Icon(Icons.refresh),
                            Padding(
                              padding: EdgeInsetsDirectional.only(start: 5),
                              child: Text("Reload"),
                            ),
                          ],
                        ),
                        onPressed: () {
                          widget.model.reload(context);
                        })
                    : widget.model.isLoading
                        ? const CircularProgressIndicator()
                        : const SizedBox()),
          )
        ],
      ),
    );
  }
}
