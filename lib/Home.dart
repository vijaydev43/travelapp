import 'package:flutter/material.dart';
import 'package:travelapp/api.dart';
import 'package:travelapp/places.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String scname = 'Enter Source';
  String dsname = 'Enter Destination';

  dynamic idFromSecondPage;
  String nameFromSecondPage = "";

  void receiveDataFromSecondPage(Map data) {
    setState(() {
      idFromSecondPage = data['id'];
      scname = data['name']!;
    });
  }

  String message = "Please choose source area";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xff054CDC),
        padding: const EdgeInsets.only(top: 35, bottom: 50),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 30,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    'Plan your trip',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'poppinsm',
                    ),
                    textScaleFactor: 2.1,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                      top: 30,
                      bottom: 20,
                    ),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: Stack(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                final resultt = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        places(placee: placeType.source),
                                  ),
                                );
                                receiveDataFromSecondPage(resultt);
                              },
                              child: Row(
                                children: [
                                  Image.asset(
                                    'assets/images/bus.png',
                                    width: MediaQuery.of(context).size.width *
                                        0.08,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 1.4,
                                    child: Text(
                                      scname,
                                      textScaleFactor:
                                          scname.contains('Enter Source')
                                              ? 1.1
                                              : 1.4,
                                      style: TextStyle(
                                        color: scname.contains('Enter Source')
                                            ? Colors.grey
                                            : Colors.black,
                                        fontFamily: 'poppins',
                                        fontWeight:
                                            scname.contains('Enter Source')
                                                ? FontWeight.normal
                                                : FontWeight.bold,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const Divider(
                              height: 30,
                            ),
                            GestureDetector(
                              onTap: () async {
                                if (idFromSecondPage != null) {
                                  dsname = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => places(
                                            placee: placeType.destination,
                                            id: idFromSecondPage),
                                      ));

                                  setState(() {
                                    dsname = dsname;
                                  });
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text('Please choose Source Area'),
                                    ),
                                  );
                                }
                              },
                              child: Row(
                                children: [
                                  Image.asset(
                                    'assets/images/bus.png',
                                    width: MediaQuery.of(context).size.width *
                                        0.08,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 1.4,
                                    child: Text(
                                      dsname,
                                      textScaleFactor:
                                          dsname.contains('Enter Destination')
                                              ? 1.1
                                              : 1.4,
                                      style: TextStyle(
                                        color:
                                            dsname.contains('Enter Destination')
                                                ? Colors.grey
                                                : Colors.black,
                                        fontFamily: 'poppinr',
                                        fontWeight:
                                            dsname.contains('Enter Destination')
                                                ? FontWeight.normal
                                                : FontWeight.bold,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const Divider(
                              height: 25,
                            ),
                            Row(
                              children: [
                                Image.asset(
                                  'assets/images/calendar.png',
                                  width:
                                      MediaQuery.of(context).size.width * 0.07,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text(
                                  'SELECT DATE',
                                  textScaleFactor: 1.1,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontFamily: 'poppinr',
                                  ),
                                ),
                                const Spacer(),
                                const Text(
                                  'TODAY',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text(
                                  'TOMORROW',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7)),
                                fixedSize: const Size(400, 55),
                                backgroundColor: const Color(0xff054CDC),
                              ),
                              child: const Text(
                                'Search',
                                textScaleFactor: 2,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                          left: 290,
                          top: 25,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                String temp = scname;
                                scname = dsname;
                                dsname = temp;
                              });
                            },
                            child: Container(
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black,
                                    blurRadius: 4,
                                    blurStyle: BlurStyle.outer,
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.swap_vertical_circle,
                                size: 50,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.black,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_add_alt_1),
            label: 'My Bookings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.support_agent),
            label: 'Help',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_outlined),
            label: 'My Account',
          ),
        ],
        selectedItemColor: Colors.black,
      ),
    );
  }
}
