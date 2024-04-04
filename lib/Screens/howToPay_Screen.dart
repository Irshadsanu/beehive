import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../constants/my_colors.dart';
import '../constants/my_functions.dart';
import '../constants/text_style.dart';
import '../providers/home_provider.dart';
import 'home_screen.dart';

class HowToPayScreen extends StatefulWidget {
String videoId,description,loginUserPhone;
String loginUsername,loginUserID,subScriberType;
String zakathAmount,deseaseName,sponsorCategory,sponsorCount,sponsorItemOnePrice,foodkitPrice,footkitCount;
String equipmentAmount,sponsorPatientAmonut,foodkitAmount;
   HowToPayScreen({Key? key,required this .videoId,
     required this .description,
     required this.loginUsername,
     required this.loginUserID,required this.subScriberType,required this.loginUserPhone,
     required this.zakathAmount,required this.deseaseName,required this.foodkitAmount,required this.sponsorCategory,
     required this.sponsorPatientAmonut,required this.equipmentAmount,required this.footkitCount
     ,required this.sponsorItemOnePrice,required this.foodkitPrice,required this.sponsorCount,}) : super(key: key);

  @override
  State<HowToPayScreen> createState() => _HowToPayScreenState();
}

class _HowToPayScreenState extends State<HowToPayScreen> {
    YoutubePlayerController? videoController;
    late PlayerState _playerState;
    late YoutubeMetaData _videoMetaData;
    double _volume = 100;
    bool _muted = false;
    bool _isPlayerReady = false;
@override
  void  initState() {
  super.initState();

  print("dmmkdddd"+widget. videoId);
  videoController = YoutubePlayerController(

    initialVideoId:widget.videoId,
    flags: const YoutubePlayerFlags(
      autoPlay: false,
      hideControls: false,
      endAt: 0,
      // mute: true,
      showLiveFullscreenButton: false,
      // loop: true
    ),
  )..addListener(listener);

 setState(() {
   videoController!.addListener(() {
     if (videoController!.value.isFullScreen) {
       SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
     } else {
       SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
       SystemChrome.setPreferredOrientations([
         DeviceOrientation.portraitUp,
       ]);
     }
   });
 });

}

    void listener() {
      if (_isPlayerReady && mounted && !videoController!.value.isFullScreen) {
        setState(() {
          _playerState = videoController!.value.playerState;
          _videoMetaData = videoController!.metadata;
        });
      }
    }
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var width = queryData.size.width;
    var height = queryData.size.height;
    HomeProvider homeProvider =
    Provider.of<HomeProvider>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        appBar:  PreferredSize(
          preferredSize: const Size.fromHeight(84),
          child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            elevation: 5,
            shape: const RoundedRectangleBorder(borderRadius:BorderRadius.only(bottomRight: Radius.circular(17),bottomLeft: Radius.circular(17)) ),
            flexibleSpace: Container(
              height: height*0.12,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(17),bottomLeft: Radius.circular(17))
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: 33),
                    InkWell(
                        onTap: (){
                          callNextReplacement(HomeScreenNew(loginUserID: widget.loginUserID,
                            loginUsername: widget.loginUsername,
                            subScriberType: widget.subScriberType,loginUserPhone: widget.loginUserPhone,
                            zakathAmount: widget.zakathAmount,sponsorPatientAmonut: widget.sponsorPatientAmonut,
                            sponsorItemOnePrice: widget.sponsorItemOnePrice,
                            sponsorCount: widget.sponsorCount,sponsorCategory: widget.sponsorCategory,footkitCount:widget.footkitCount,deseaseName: widget.deseaseName,
                            foodkitPrice:widget.foodkitPrice ,equipmentAmount:widget.equipmentAmount ,foodkitAmount:widget. foodkitAmount,
                          ), context);
                        },
                        child: Icon(Icons.arrow_back_ios_outlined,color: cl323A71,)),
                    SizedBox(width: 22),

                    Text('How To Pay',style: wardAppbarTxt),

                  ],),
              ),
            ),

          ),
        ),
        body: Consumer<HomeProvider>(
          builder: (context,value,child) {
            return SingleChildScrollView(
              // physics: const NeverScrollableScrollPhysics(),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.only(left: 15,right: 15),
                    child: SizedBox(

                      height: 400,

                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: YoutubePlayer(
                            controller: videoController!,
                            showVideoProgressIndicator: true,
                          ),),
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(left: 20,right: 15,top: 15),
                    child: RichText(text: TextSpan(children: [
                      // TextSpan(text: "How to pay ",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,color: Colors.black)),
                      TextSpan(text:widget.description,style: const TextStyle(fontWeight: FontWeight.w500,fontSize: 14,color: Colors.black)),

                    ])),
                  ),

                ],
              ),
            );
          }
        ),
      ),
    );
  }
  @override
  void dispose() {
  setState(() {
    videoController!.dispose();
    videoController=null;
  });

    super.dispose();
  }
}
