import 'package:Me_Fuel/HomePage.dart';
import 'package:Me_Fuel/main.dart';
import 'package:Me_Fuel/stores/main_store.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';



class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);
  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  void initState() {
    super.initState();
  }

  final store = getIt<MainStore>();
  final controller = PageController();
  final int pageCount = 2;
  bool lastPage = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          padding: const EdgeInsets.only(bottom: 80),
          child: PageView(
            controller: controller,
            onPageChanged: (index) {
              setState(() {
                lastPage = index == pageCount;
              });
            },
            children: [
              Container(
                color: Colors.red,
                child: const Center(child: Text("Page 1")),
              ),
              Container(
                color: Colors.indigo,
                child: const Center(child: Text("Page 2")),
              ),
              Container(
                color: Colors.green,
                child: const Center(child: Text("Page 3")),
              )
            ],
          ),
        ),
        bottomSheet: lastPage ?
        TextButton(onPressed: () async {
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (context) => const HomePage()));
        },
          child: const Text('Get Started', style: TextStyle(fontSize: 24)),
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
            ),
            primary: Colors.white,
            backgroundColor: Colors.teal.shade700,
            minimumSize: const Size.fromHeight(80)
          ))
            : Container(
          padding: const EdgeInsets.symmetric(horizontal: 80),
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                  onPressed: () => controller.jumpToPage(pageCount),
                  child: const Text("Skip")),
              Center(
                child: SmoothPageIndicator(
                  controller: controller,
                  count: 3,
                  effect: WormEffect(
                      spacing: 16,
                      dotColor: Colors.black26,
                      activeDotColor: Colors.teal.shade700),
                  onDotClicked: (index) => controller.animateToPage(index, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut),
                ),
              ),
              TextButton(
                  onPressed: () => controller.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut),
                  child: const Text("Next")),
            ],
          ),
        ));
  }
}
