import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:snapchat_ui/data/discover_json.dart';
import 'package:snapchat_ui/data/spotlight_json.dart';
import 'package:snapchat_ui/theme/colors.dart';

import 'package:snapchat_ui/data/stories_json.dart';
import 'package:snapchat_ui/pages/spotlight_detail_page.dart';





class SpotlightPage extends StatefulWidget {
  @override
  _SpotlightPageState createState() => _SpotlightPageState();
}

class _SpotlightPageState extends State<SpotlightPage> {

  int current = 0;
  // final List<String> thumbnailImages = [
  //
  //   'assets/avataaars.png',
  //   'assets/friends.PNG',
  //   'assets/avataaars.png',
  //   'assets/friends.PNG'
  //
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      appBar: getAppBar(),
      body: getBody(),
    );
  }

  Widget getBody() {

    PageController controller = PageController(initialPage: 2);

    List<Widget> spotlights = [

      Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SpotlightDetailPage(
          videoUrl: spotlight_data[1]['videoUrl'],
        ),
        //alignment: Alignment.bottomCenter,
      ),

      Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
          child: SpotlightDetailPage(
            videoUrl: spotlight_data[2]['videoUrl'],
          ),
          //alignment: Alignment.bottomCenter,
      ),
      Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SpotlightDetailPage(
          videoUrl: spotlight_data[3]['videoUrl'],
        ),
        //alignment: Alignment.bottomCenter,
      ),

      Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SpotlightDetailPage(
          videoUrl: spotlight_data[4]['videoUrl'],
        ),
      ),

      Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SpotlightDetailPage(
          videoUrl: spotlight_data[5]['videoUrl'],
        ),
        //alignment: Alignment.bottomCenter,
      ),

      Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SpotlightDetailPage(
          videoUrl: spotlight_data[6]['videoUrl'],
        ),
        //alignment: Alignment.bottomCenter,
      ),
      //
      Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SpotlightDetailPage(
          videoUrl: spotlight_data[8]['videoUrl'],
        ),
        //alignment: Alignment.bottomCenter,
      ),
      //
      Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SpotlightDetailPage(
          videoUrl: spotlight_data[7]['videoUrl'],
        ),
        //alignment: Alignment.bottomCenter,
      ),

      Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SpotlightDetailPage(
          videoUrl: spotlight_data[9]['videoUrl'],
        ),
        //alignment: Alignment.bottomCenter,
      ),

      Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SpotlightDetailPage(
          videoUrl: spotlight_data[10]['videoUrl'],
        ),
        //alignment: Alignment.bottomCenter,
      ),
      //
      Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SpotlightDetailPage(
          videoUrl: spotlight_data[11]['videoUrl'],
        ),
        //alignment: Alignment.bottomCenter,
      ),

      Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SpotlightDetailPage(
          videoUrl: spotlight_data[12]['videoUrl'],
        ),
        //alignment: Alignment.bottomCenter,
      ),

      Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SpotlightDetailPage(
          videoUrl: spotlight_data[13]['videoUrl'],
        ),
        //alignment: Alignment.bottomCenter,
      ),

      Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SpotlightDetailPage(
          videoUrl: spotlight_data[14]['videoUrl'],
        ),
        //alignment: Alignment.bottomCenter,
      ),


      // Container(
      //   height: MediaQuery.of(context).size.height,
      //   width: MediaQuery.of(context).size.width,
      //   color: Colors.blue,
      //   child: Center(
      //     child: Text('hi'),
      //   ),
      // ),


    ];
    return Scaffold(
      body: Container(
        child: PageView(
          scrollDirection: Axis.vertical,
          children: spotlights,
          controller: controller,
          reverse:true,
        ),
      ),
    );

  }

  Widget getAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white60,
      title: Row(
       // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: black.withOpacity(0.1)),
                child: Image.asset('assets/avataaars.png'),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: black.withOpacity(0.1)),
                child: Icon(
                  Feather.search,
                  color: Colors.white,
                  size: 23,
                ),
              )
            ],
          ),
          Container(
            width: 20,
          ),
          Center(

              child: Text(
                "Spotlight",
                style: TextStyle(
                    fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
