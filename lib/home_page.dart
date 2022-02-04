import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:netroll/constants.dart';
import 'package:netroll/data.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: gradientEndColor,
        body: Container(
          child: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        'Explore',
                        style: TextStyle(
                          fontFamily: 'Raleway',
                          fontSize: 44,
                          color: Color(0xffffffff),
                        ),
                        textAlign: TextAlign.left,
                      ),
                      DropdownButton<DropdownMenuItem>(
                        items: const [
                          DropdownMenuItem(
                            child: Text(
                              'Solor System',
                              style: TextStyle(
                                fontFamily: 'Raleway',
                                fontSize: 24,
                                color: Color(0x7cbdf1ff),
                              ),
                              textAlign: TextAlign.left,
                            ),
                          )
                        ],
                        onChanged: (value) {},
                        underline: const SizedBox(),
                        icon: const Padding(
                          padding: EdgeInsets.only(left: 16.0),
                          child: Icon(
                            Icons.arrow_downward,
                            color: Colors.red,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                    height: 500,
                    child: Swiper(
                      itemCount: planets.length,
                      itemWidth: MediaQuery.of(context).size.width - 2 * 64,
                      layout: SwiperLayout.STACK,
                      itemBuilder: (context, index) {
                        return Stack(
                          children: <Widget>[
                            const SizedBox(height: 100),
                            Card(
                              color: Colors.white,
                              child: Column(
                                children: const <Widget>[
                                  SizedBox(
                                    height: 100,
                                  ),
                                  Text("Jupiter",
                                      style: TextStyle(
                                          fontFamily: 'Raleway',
                                          fontSize: 44,
                                          color: Color(0xff47455f)))
                                ],
                              ),
                            )
                          ],
                        );
                      },
                    ))
              ],
            ),
          ),
        ));
  }
}
