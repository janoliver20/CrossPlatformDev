import 'package:Me_Fuel/Strings.dart';
import 'package:Me_Fuel/main.dart';
import 'package:Me_Fuel/models/GasStation.dart';
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
  final double _topMargin = 70;
  final double _horizontalMargin = 8;
  int _selectedListIndex = -1;
  final TextEditingController _usernameController = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Container(
            padding: const EdgeInsets.only(bottom: 100),
            child: PageView(
              controller: controller,
              onPageChanged: (index) {
                setState(() {
                  lastPage = index == pageCount;
                });
                FocusManager.instance.primaryFocus?.unfocus();
              },
              children: [
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          Strings.intro_welcome_title,
                          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          Strings.intro_welcome_text,
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white, ),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(40)
                  ),
                  margin: EdgeInsets.only(top: _topMargin, left: _horizontalMargin, right: _horizontalMargin),
                ),
                Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            Strings.intro_name_question,
                            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: TextField(
                            controller: _usernameController,
                            decoration: const InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white, width: 1)
                              ),
                              hintText: Strings.intro_name_placeholder,
                              hintStyle: TextStyle(color: Colors.white70, fontSize: 16)
                            ),
                            style: const TextStyle(color: Colors.white, fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  margin: EdgeInsets.only(top: _topMargin, left: _horizontalMargin, right: _horizontalMargin),
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          Strings.intro_fuelType_question,
                          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: ListView.builder(
                            itemCount: FuelType.values.length,
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              final item = FuelType.values[index];
                              return Card(
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                    color: Colors.white,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                color: Colors.transparent,
                                child: ListTile(
                                  title: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        getFuelTypeName(item),
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      Visibility(
                                          visible: _selectedListIndex == index,
                                          child: const Icon(Icons.check, color: Colors.white, size: 30)
                                      )
                                    ],
                                  ),
                                  onTap: () {
                                    setState(() {
                                      _selectedListIndex = index;
                                    });
                                  },
                                ),
                              ) ;
                            }),
                      )
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  margin: EdgeInsets.only(top: _topMargin, left: _horizontalMargin, right: _horizontalMargin),
                )
              ],
            ),
          ),
        ),
        bottomSheet:  Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                  onPressed: () => controller.jumpToPage(pageCount),
                  child: const Text(Strings.intro_skip),
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    primary: Colors.white,
                    backgroundColor: Colors.blue,
                  ),
              ),

              Center(
                child: SmoothPageIndicator(
                  controller: controller,
                  count: 3,
                  effect: const ExpandingDotsEffect(
                      spacing: 16,
                      dotColor: Colors.black26,
                      dotHeight: 8,
                      dotWidth: 8,
                      activeDotColor: Colors.blue),
                  onDotClicked: (index) => controller
                      .animateToPage(index,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut),
                ),
              ),
              lastPage ? TextButton(onPressed: () async {
                _saveIntroDetails(
                    name: _usernameController.text,
                    fuelType: _selectedListIndex > -1 && _selectedListIndex < FuelType.values.length
                        ? FuelType.values[_selectedListIndex]
                        : null
                );
                Navigator.of(context)
                    .pushReplacement(MaterialPageRoute(builder: (context) => const MyHomePage(title: 'MeFuel Homepage')));
              },
                  child: const Text(Strings.intro_get_started),
                  style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      primary: Colors.white,
                      backgroundColor: Colors.blue,
                  ))
                  : TextButton(
                  onPressed: () => controller.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut),
                  child: const Text(Strings.intro_next),
                  style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      primary: Colors.white,
                      backgroundColor: Colors.blue,
                  ),
              ),
            ],
          ),
        ));
  }

  void _saveIntroDetails({String? name, FuelType? fuelType}) {
    if (name != null && name.trim() != '') {
      store.setUsername(name);
    }
    if (fuelType != null) {
      store.setDefaultFuelType(fuelType);
    }
    store.setHasSeenIntro(true);
  }
}
