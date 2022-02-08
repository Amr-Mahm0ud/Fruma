import 'package:flutter/material.dart';
import 'package:fruma/log_form.dart';
import 'package:fruma/provider_controller.dart';
import 'package:provider/provider.dart';

class MyPageView extends StatefulWidget {
  const MyPageView({Key? key}) : super(key: key);

  @override
  _MyPageViewState createState() => _MyPageViewState();
}

class _MyPageViewState extends State<MyPageView> {
  PageController pageController = PageController(
    initialPage: 0,
  );
  int currentPage = 0;
  final List _pages = [
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
    'sed do ejusdem temper incident ut labor et door magna alia.',
    'It is a long established fact that a reader will be distracted.',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            PageView.builder(
                controller: pageController,
                scrollDirection: Axis.horizontal,
                onPageChanged: (val) {
                  setState(() {
                    currentPage = val;
                  });
                },
                itemBuilder: (ctx, index) {
                  return buildPageView(index, ctx);
                }),
            Align(
              alignment: const Alignment(0, 0.9),
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => const LogForm()));
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  constraints: BoxConstraints(
                    minWidth: currentPage == 2 ? 100 : 40,
                    maxWidth: currentPage == 2 ? 120 : 60,
                    minHeight: 25,
                    maxHeight: 25,
                  ),
                  child: Text(
                    currentPage == 2 ? 'Get Started' : 'Skip',
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Center buildPageView(int index, BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 100),
        padding: const EdgeInsets.fromLTRB(35, 70, 35, 0),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(30),
                bottomLeft: Radius.circular(30)),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 5,
                spreadRadius: 5,
                offset: Offset(0, 2),
              ),
            ]),
        child: Column(
          children: [
            Image.asset(
              Provider.of<MyProvider>(context).fruits[index].imgSrc,
              scale: 1.7,
            ),
            const SizedBox(height: 50),
            Text(
              Provider.of<MyProvider>(context).fruits[index].name,
              style: Theme.of(context).textTheme.headline4,
            ),
            const SizedBox(height: 10),
            Text(
              _pages[index],
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.black54, fontSize: 17),
            ),
            const SizedBox(height: 50),
            Indicator(currentPage),
          ],
        ),
      ),
    );
  }
}

class Indicator extends StatelessWidget {
  final int index;

  const Indicator(this.index, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildContainer(index == 0 ? Colors.black54 : Colors.black12),
        buildContainer(index == 1 ? Colors.black54 : Colors.black12),
        buildContainer(index == 2 ? Colors.black54 : Colors.black12),
      ],
    );
  }

  Container buildContainer(Color color) {
    return Container(
      margin: const EdgeInsets.all(4),
      height: 12,
      width: color == Colors.black54 ? 28 : 12,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}
