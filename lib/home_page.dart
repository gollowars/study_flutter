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
          decoration: BoxDecoration(
           gradient: LinearGradient(
             colors: [gradientStartColor, gradientEndColor],
             begin: Alignment.topCenter,
             end: Alignment.bottomCenter,
             stops: const [0.3,0.7]
           ) 

          ),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Explore',
                        style: TextStyle(
                          fontFamily: 'Raleway',
                          fontSize: 44,
                          color: Color(0xffffffff),
                          fontWeight: FontWeight.bold
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
                Padding(
                  padding: const EdgeInsets.only(left: 32.0),
                  child: SizedBox(
                    height: 460,
                    child: Swiper(
                      itemCount: planets.length,
                      itemWidth: MediaQuery.of(context).size.width - 2 * 64,
                      layout: SwiperLayout.STACK,
                      pagination: const SwiperPagination(
                        builder: DotSwiperPaginationBuilder(
                          activeSize: 20,
                          space: 8
                        )
                      ),
                      itemBuilder: (context, index) {
                        return Stack(
                          children: [
                            Column(
                              children: [
                                const SizedBox(height: 100,),
                                Card(
                                  elevation: 8,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(32)
                                  ),
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(32.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                      const SizedBox(height: 100,),
                                      Text(
                                        planets[index].name,
                                        style: TextStyle(fontFamily:'Raleway',fontSize: 44,color: primaryTextColor),
                                        textAlign: TextAlign.left,),
                                      Text(
                                        'Solar System',
                                        style: TextStyle(
                                          fontFamily: 'Raleway',
                                          fontSize: 23,
                                          color: primaryTextColor, 
                                        ),
                                      ),
                                      const SizedBox(height: 20,),
                                      Row(
                                        children: [
                                          Text("Know more",style: TextStyle(fontFamily: 'Raleway', fontSize: 18,color: secondaryTextColor),),
                                          const SizedBox(width: 5,),
                                          Icon(Icons.arrow_forward, color: secondaryTextColor,)
                                        ],
                                      )
                                    ]),
                                  )
                                )
                              ],
                            ), 
                          Image.asset(planets[index].iconImage), 
                          ],
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(36)
            ),
            color: navigationColor,
          ),
          padding: const EdgeInsets.all(24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children:  [
              IconButton(
                icon: Image.asset('assets/menu_icon.png'),
                onPressed: (){},
              ),
              IconButton(
                icon: Image.asset('assets/search_icon.png'),
                onPressed: (){},
              ),
              IconButton(
                icon: Image.asset('assets/profile_icon.png'),
                onPressed: (){},
              )
            ],
          )
        ),
        );
  }
}
