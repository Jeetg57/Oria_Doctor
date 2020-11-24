import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoarding extends StatefulWidget {
  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  final String asset = "assets/images/mask-woman.svg";

  @override
  Widget build(BuildContext context) {
    saveOnboarding() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool("onboarding-completed", true);
    }

    double devHeight = MediaQuery.of(context).size.height;
    double devWidth = MediaQuery.of(context).size.width;

    List<PageViewModel> listPagesViewModel = [
      PageViewModel(
        titleWidget: Text(
          "Oria Doctor",
          style: TextStyle(
              fontFamily: "LobsterTwo",
              fontWeight: FontWeight.bold,
              fontSize: 50),
        ),
        bodyWidget: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Discover doctors around you and book appointments all at a reasonable cost",
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 24,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        image: Align(
          child: SvgPicture.asset(
            "assets/images/mask-man.svg",
            fit: BoxFit.cover,
            height: devHeight * 0.40,
          ),
          alignment: Alignment.bottomLeft,
        ),
        decoration: const PageDecoration(
          pageColor: Colors.white30,
        ),
      ),
      PageViewModel(
        titleWidget: Text(
          "Oria Doctor",
          style: TextStyle(
              fontFamily: "LobsterTwo",
              fontWeight: FontWeight.bold,
              fontSize: 50),
        ),
        bodyWidget: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Make your work discoverable by patients around your area",
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 24,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        image: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
            child: SvgPicture.asset(
              "assets/images/slide-2.svg",
              fit: BoxFit.contain,
              height: devHeight * 0.40,
            ),
            alignment: Alignment.bottomLeft,
          ),
        ),
        decoration: const PageDecoration(
          pageColor: Colors.white30,
        ),
      ),
      PageViewModel(
        titleWidget: Text(
          "Oria Doctor",
          style: TextStyle(
              fontFamily: "LobsterTwo",
              fontWeight: FontWeight.bold,
              fontSize: 50),
        ),
        bodyWidget: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "All Done! Proceed to sign up",
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 24,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        image: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
            child: SvgPicture.asset(
              "assets/images/slide-3.svg",
              fit: BoxFit.contain,
              height: devHeight * 0.40,
            ),
            alignment: Alignment.bottomLeft,
          ),
        ),
        decoration: const PageDecoration(
          pageColor: Colors.white30,
        ),
      )
    ];
    return IntroductionScreen(
      pages: listPagesViewModel,
      onDone: () {
        // When done button is press
        saveOnboarding();
        Navigator.of(context).popAndPushNamed("/login");
      },
      onSkip: () {
        // You can also override onSkip callback
      },
      // showSkipButton: true,
      skip: const Icon(
        Icons.skip_next,
        size: 30,
      ),
      next: const Icon(
        Icons.arrow_right_alt,
        size: 30,
      ),
      done: const Text("Finish",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: "Poppins",
              fontSize: 20)),
      dotsDecorator: DotsDecorator(
          size: const Size.square(10.0),
          activeSize: const Size(20.0, 10.0),
          activeColor: Colors.black,
          color: Colors.black26,
          spacing: const EdgeInsets.symmetric(horizontal: 3.0),
          activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0))),
    );
  }
}
