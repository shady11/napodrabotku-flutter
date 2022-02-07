import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:ishtapp/components/custom_button.dart';
import 'package:ishtapp/utils/constants.dart';
import 'package:ishtapp/routes/routes.dart';
import 'package:ishtapp/datas/youtube_model.dart';
import 'package:ishtapp/datas/pref_manager.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:easy_localization/easy_localization.dart';


class SchoolTab extends StatefulWidget {
  @override
  _SchoolTabState createState() => _SchoolTabState();
}

class _SchoolTabState extends State<SchoolTab> {

  YoutubePlayerController _ytbPlayerController;

  List<YoutubeModel> videosList = [];

  @override
  void initState() {
    super.initState();

    if(Prefs.getString(Prefs.LANGUAGE) == 'ru') {
      if(Prefs.getString(Prefs.ROUTE) != "PRODUCT_LAB") {
        videosList = [
          YoutubeModel(id: 1, youtubeId: 'gaeMRAKrq24'),
          YoutubeModel(id: 2, youtubeId: 'ckn_ACQV-Zk'),
          YoutubeModel(id: 3, youtubeId: 'lPttGkXzU9g'),
          YoutubeModel(id: 4, youtubeId: 'ZbeHJ6xmDdw'),
          YoutubeModel(id: 5, youtubeId: 'dHXwfwx2Oc4'),
        ];
      } else {
        videosList = [
          YoutubeModel(id: 1, youtubeId: 'pCnylfLS6oY'),
          YoutubeModel(id: 2, youtubeId: 'OSFOMOFSw8I'),
          YoutubeModel(id: 3, youtubeId: 'OcRmQdLZ5J0'),
          YoutubeModel(id: 4, youtubeId: 'xRAP31MJtK4'),
          YoutubeModel(id: 5, youtubeId: 'wDEu7DMfhDI'),
          YoutubeModel(id: 6, youtubeId: 'H5AS5xcoi-w'),
          YoutubeModel(id: 7, youtubeId: 'jsEfhz99UlA'),
          YoutubeModel(id: 8, youtubeId: 'A7DR4g6C3Pc'),
          YoutubeModel(id: 9, youtubeId: 'IJNe4n9qfpg'),
          YoutubeModel(id: 10, youtubeId: 'kRquZIgEEGI'),
          YoutubeModel(id: 11, youtubeId: 'fcI8ErT88Ho'),
          YoutubeModel(id: 12, youtubeId: 'De1bL3RfqNQ'),
          YoutubeModel(id: 13, youtubeId: 'XMmeV9X0r9M'),
          YoutubeModel(id: 14, youtubeId: 'FNKQUOzmuxA'),
          YoutubeModel(id: 15, youtubeId: 'VdqAKKhYggs'),
          YoutubeModel(id: 16, youtubeId: '3CNie-rgpVM'),
          YoutubeModel(id: 17, youtubeId: 'GzEzYSXk_Tg'),
          YoutubeModel(id: 18, youtubeId: 'JFE51Y4diIk'),
        ];
      }
    } else {
      if(Prefs.getString(Prefs.ROUTE) != "PRODUCT_LAB") {
        videosList = [
          YoutubeModel(id: 1, youtubeId: 'nuz9xfcrZd4'),
          YoutubeModel(id: 2, youtubeId: '2EmR3v81X2M'),
          YoutubeModel(id: 3, youtubeId: 'A-AmIuAZhek'),
          YoutubeModel(id: 4, youtubeId: 'G1Cb7xqjpFg'),
          YoutubeModel(id: 5, youtubeId: 'vamUDA7p3LU'),
        ];
      } else {
        videosList = [
          YoutubeModel(id: 1, youtubeId: 'np5-CHHDqvs'),
          YoutubeModel(id: 2, youtubeId: 'fdyXypMmNlc'),
          YoutubeModel(id: 3, youtubeId: 'vQ2rU71Kdnk'),
          YoutubeModel(id: 4, youtubeId: 'VNibKv4ZQIM'),
          YoutubeModel(id: 5, youtubeId: 'xrHB_vSkTb0'),
          YoutubeModel(id: 6, youtubeId: 'cWhELvLT9QY'),
          YoutubeModel(id: 7, youtubeId: 'O35dblVWxHM'),
          YoutubeModel(id: 8, youtubeId: 'SyCQq3eQjvM'),
          YoutubeModel(id: 9, youtubeId: '0MpO1KGdEaA'),
          YoutubeModel(id: 10, youtubeId: 'JNug9QyMEaM'),
          YoutubeModel(id: 11, youtubeId: 'P5SPkdxQVXo'),
          YoutubeModel(id: 12, youtubeId: 'oJZMet7Ft_s'),
          YoutubeModel(id: 13, youtubeId: 'mnbwjGtVjsk'),
          YoutubeModel(id: 14, youtubeId: 'rRI1NwUmj04'),
          YoutubeModel(id: 15, youtubeId: '6YQ-MNvy6Mo'),
          YoutubeModel(id: 16, youtubeId: 'i_6fIZ6vCsI'),
          YoutubeModel(id: 17, youtubeId: '3PzUaSUeMKU'),
          YoutubeModel(id: 18, youtubeId: 'y3tVLsMNDdU'),
          YoutubeModel(id: 19, youtubeId: 'sNg7lq0gxm0'),
          YoutubeModel(id: 20, youtubeId: 'JFE51Y4diIk'),
        ];
      }
    }

    _setOrientation([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _ytbPlayerController = YoutubePlayerController(
          initialVideoId: videosList[0].youtubeId,
          params: YoutubePlayerParams(
            showFullscreenButton: true,
          ),
        );
      });
    });
  }

  @override
  void dispose() {
    super.dispose();

    _setOrientation([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    _ytbPlayerController.close();
  }

  _setOrientation(List<DeviceOrientation> orientations) {
    SystemChrome.setPreferredOrientations(orientations);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildYtbView(),
          SizedBox(height: 30),
          // _buildMoreVideoTitle(),
          _buildMoreVideosView(),
        ],
      ),
    );
  }

  _buildYtbView() {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: _ytbPlayerController != null
          ? YoutubePlayerIFrame(controller: _ytbPlayerController)
          : Center(child: CircularProgressIndicator()),
    );
  }

  _buildMoreVideoTitle() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 10, 182, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "More videos",
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
        ],
      ),
    );
  }

  _buildMoreVideosView() {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: ListView.builder(
            itemCount: videosList.length,
            physics: AlwaysScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  final _newCode = videosList[index].youtubeId;
                  _ytbPlayerController.load(_newCode);
                  _ytbPlayerController.stop();
                },
                child: Container(
                  height: MediaQuery.of(context).size.height / 5,
                  margin: EdgeInsets.symmetric(vertical: 7),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        Positioned(
                          child: CachedNetworkImage(
                            imageUrl:
                            "https://img.youtube.com/vi/${videosList[index].youtubeId}/0.jpg",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
