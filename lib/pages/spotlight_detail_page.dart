import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:snapchat_ui/theme/colors.dart';
import 'package:video_player/video_player.dart';

class SpotlightDetailPage extends StatefulWidget {
  final String videoUrl;

  const SpotlightDetailPage({Key key, this.videoUrl}) : super(key: key);
  @override
  _SpotlightDetailPageState createState() => _SpotlightDetailPageState();
}

class _SpotlightDetailPageState extends State<SpotlightDetailPage> {
  VideoPlayerController _controller;
  var liked = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = VideoPlayerController.asset(widget.videoUrl);

    _controller.addListener(() {
      setState(() {});
    });
    // _controller.setLooping(true);
    _controller.initialize().then(
          (_) => setState(() {}),
    );
    _controller.play();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      //appBar: getAppBar(),
      body: getBody(),
    );
  }

  Widget getBody() {
    return InkWell(

      onTap: () {
        // Wrap the play or pause in a call to `setState`. This ensures the
        // correct icon is shown
        setState(() {
          // If the video is playing, pause it.
          if (_controller.value.isPlaying) {
            _controller.pause();
          } else {
            // If the video is paused, play it.
            _controller.play();
          }
        });
      },


      child: Stack(
        children: [
          Container(

            child:Container(

              child: ClipRRect(
                  borderRadius: BorderRadius.circular(2),
                  child: VideoPlayer(_controller)),
            ),

          ),

          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  black.withOpacity(0.6),
                  black.withOpacity(0),
                ], end: Alignment.topCenter, begin: Alignment.bottomCenter)),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 15, bottom: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  width: 40,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [


                    GestureDetector(
                      onDoubleTap: (){
                        setState(() {
                          if(liked){
                            liked = false;
                          }else{
                            liked = true;
                          }
                        });
                    },
                      child: Container(

                        height: 20,
                        width: 30,
                        child:Icon(
                      // NEW from here...
                      liked ? Icons.favorite_sharp : Icons.favorite,
                      color: liked ? Colors.red : Colors.white,
                      semanticLabel: liked ? 'Like' : 'Unlike',
                          size: 30,
                    ),
                 ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      width: 30,
                      height: 40,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: white.withOpacity(0.1)),
                      child: Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),


                    SizedBox(
                      height: 30,
                    ),

                    Container(
                      width: 30,
                      height: 40,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: white.withOpacity(0.1)),
                      child: Icon(
                        Entypo.dots_three_horizontal,
                        color: white,
                        size: 20,
                      ),
                    )
                  ],
                ),

              ],
            ),
          )
        ],
      ),
    );
  }


}
