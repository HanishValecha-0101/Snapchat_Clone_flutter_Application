import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:snapchat_ui/theme/colors.dart';
import 'package:fluttermoji/fluttermoji.dart';
import 'package:snapchat_ui/pages/profile_page.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {

  var location = 'Ulhasnagar';
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(19.218054,73.16308),
     // 37.42796133580664, -122.085749655962),
    //target: LatLng(11.5760029, 104.845914),
    zoom: 15.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: getFooter(),
      body: getBody(),
    );
  }

  Widget getFooter() {
    return Padding(
      padding: const EdgeInsets.only(left: 30, top: 60),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: (){
                      //Navigator.push(context, MaterialPageRoute(builder: ProfilePage())),
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProfilePage()),
                      );
                    },
                    child:Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black.withOpacity(0.3)),
                      child: Icon(
                        Entypo.user,
                        color: primary,
                        size: 23,
                      ),
                    )

                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black.withOpacity(0.3)),
                    child: Icon(
                      Feather.search,
                      color: Colors.white,
                      size: 23,
                    ),
                  )
                ],
              ),
              Container(
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: darkGrey.withOpacity(0.30),
                        spreadRadius: 20,
                        blurRadius: 40,
                        // changes position of shadow
                      ),
                ]),
                child: Column(
                  children: [
                    Text(
                      location,
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.cloud,
                          color: Colors.white,
                          size: 15,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "25 c",
                          style: TextStyle(color: Colors.white, fontSize: 13),
                        )
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                width: 5,
              ),
              // ElevatedButton.icon(
              //   onPressed: () => FirebaseAuth.instance.signOut(),
              //   icon: Icon(Icons.settings),
              //   label: Text('Sign Out'),
              // )
             Icon(
                 Icons.settings,
               color: Colors.black26,
               size: 32,
             ),

            ],
          ),

          //bottom row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 70,
                width: 80,
                child: Stack(
                  children: [
                    Positioned(
                      left: 3,
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.white),
                        child: Center(
                          child: Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey.withOpacity(0.5)),
                             child: Image.asset("assets/avataaars.png"),
                            // Icon(
                            //   Entypo.user,
                            //   color: Colors.grey,
                            //   size: 30,
                            // ),

                            //   child: Image.asset("assets/bitmoji.png",width: 10,height:
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            "My Bitmoji",
                            style: TextStyle(
                                fontSize: 11, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
             Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                    color: darkGrey.withOpacity(0.20),
                    spreadRadius: 20,
                    blurRadius: 40,
                    // changes position of shadow
                  ),
                ],
                    shape: BoxShape.circle, color: Colors.white),
                child: Center(
                  child: Icon(
                    FontAwesome.location_arrow,
                    size: 20,
                  ),
                ),

              ),
              Container(
                height: 70,
                width: 70,
                child: Stack(
                  children: [
                    Positioned(
                      left: 3,
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.white),
                        child: Center(
                          child: Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey.withOpacity(0.5)),
                            child: Center(
                              child: Image.asset("assets/friends.PNG"),
                              //Icon(
                              //   Entypo.user,
                              //   color: Colors.grey,
                              //   size: 30,
                              // ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 5, bottom: 5, left: 12, right: 12),
                          child: Text(
                            "Friends",
                            style: TextStyle(
                                fontSize: 11, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
    //
    // Future<void> _goToTheLake() async {
    //   final GoogleMapController controller = await _controller.future;
    //   controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
    // }
  Widget getBody() {
    return GoogleMap(
      mapType: MapType.normal,
      myLocationButtonEnabled: false,
      initialCameraPosition: _kGooglePlex,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
    );
  }
}

// class FluttermojiCircleAvatar {
// }
