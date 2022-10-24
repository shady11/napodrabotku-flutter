import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ishtapp/datas/youtube_model.dart';
import 'package:ishtapp/datas/pref_manager.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:easy_localization/easy_localization.dart';

class SchoolTabDetails extends StatefulWidget {
  final int playList;
  List<String> titles = [
    'searching_work'.tr(),
    'artificial_intelligence'.tr(),
    'machine_learning'.tr(),
    'neural_networks'.tr(),
    'data_science'.tr(),
    'cyber_security'.tr(),
    'software_design'.tr()
  ];

  SchoolTabDetails(this.playList);

  @override
  _SchoolTabDetailsState createState() => _SchoolTabDetailsState();
}

class _SchoolTabDetailsState extends State<SchoolTabDetails> {

  YoutubePlayerController _ytbPlayerController;
  List<YoutubeModel> videosList = [];

  @override
  void initState() {
    super.initState();

    if (Prefs.getString(Prefs.LANGUAGE) == 'ru') {
      switch (widget.playList) {
        case 0:
          if (Prefs.getString(Prefs.ROUTE) != "PRODUCT_LAB") {
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
          break;
        case 1:
          videosList = [
            YoutubeModel(id: 1, youtubeId: 'snysEgofUc0'),
            YoutubeModel(id: 2, youtubeId: '7oTlkD4Y7P0'),
            YoutubeModel(id: 3, youtubeId: 'ngcP9YCAHw0'),
            YoutubeModel(id: 4, youtubeId: 'YI-E1ABj3es'),
            YoutubeModel(id: 5, youtubeId: 'HLkHwqxMMCM'),
            YoutubeModel(id: 6, youtubeId: 'bfrHFEW9jFE'),
            YoutubeModel(id: 7, youtubeId: '7_TCtj6cwZs'),
            YoutubeModel(id: 8, youtubeId: 'tOChkr3YIq4'),
            YoutubeModel(id: 9, youtubeId: 'ttkUbj148F0'),
            YoutubeModel(id: 10, youtubeId: 'Xtgex3lrW8c'),
            YoutubeModel(id: 11, youtubeId: 'Y8hwNT7EivI'),
            YoutubeModel(id: 12, youtubeId: 'YIwlKCfCJgc'),
            YoutubeModel(id: 13, youtubeId: '3TEHwCUDVLI'),
            YoutubeModel(id: 14, youtubeId: 'YvmsoEpnHOM'),
            YoutubeModel(id: 15, youtubeId: 'zfJLxxNBPSE'),
            YoutubeModel(id: 16, youtubeId: 'qHsRZahDYbU'),
          ];
          break;
        case 2:
          videosList = [
            YoutubeModel(id: 1, youtubeId: '5JiXlAkU-9M'),
            YoutubeModel(id: 2, youtubeId: 'Qy1wbWTfw34'),
            YoutubeModel(id: 3, youtubeId: 'z3IC1UteSao'),
            YoutubeModel(id: 4, youtubeId: 'mf36WN6W-zc'),
            YoutubeModel(id: 5, youtubeId: 'Cb7-8nxf5wM'),
            YoutubeModel(id: 6, youtubeId: '55ItZg7zkkM'),
          ];
          break;
        case 3:
          videosList = [
            YoutubeModel(id: 1, youtubeId: '8oVxFkOWp_M'),
            YoutubeModel(id: 2, youtubeId: 'imlMSCw4kbQ'),
            YoutubeModel(id: 3, youtubeId: '2yWBNfZN5v8'),
            YoutubeModel(id: 4, youtubeId: 'Lp8OaZjweo8'),
            YoutubeModel(id: 5, youtubeId: 'FEmbT8gJh1c'),
            YoutubeModel(id: 6, youtubeId: '1ViUN3cds7Y'),
            YoutubeModel(id: 7, youtubeId: 'HmW0Wvd-8HI'),
            YoutubeModel(id: 8, youtubeId: 'oQ9VTMc_7Sk'),
            YoutubeModel(id: 9, youtubeId: 'Xf5BpUN3ds4'),
            YoutubeModel(id: 10, youtubeId: 'roDitV2Xr-s'),
            YoutubeModel(id: 11, youtubeId: 'neIGMTNHmWM'),
            YoutubeModel(id: 12, youtubeId: '9MjxBr2xeb0'),
            YoutubeModel(id: 13, youtubeId: 'HH_BHqMejJI'),
            YoutubeModel(id: 14, youtubeId: 'xpBLy2VHr6w'),
            YoutubeModel(id: 15, youtubeId: '4ZiZmQk3n-g'),
            YoutubeModel(id: 16, youtubeId: '5Wh1WV_cV1g'),
          ];
          break;
        case 4:
          videosList = [
            YoutubeModel(id: 1, youtubeId: '2vcPhHjmnmo'),
            YoutubeModel(id: 2, youtubeId: '_xsTGPKdHDw'),
            YoutubeModel(id: 3, youtubeId: 'f6EI4xvRs2I'),
            YoutubeModel(id: 4, youtubeId: 'Z1JSPD1qd-0'),
            YoutubeModel(id: 5, youtubeId: 'QCbrdw6OaBk'),
            YoutubeModel(id: 6, youtubeId: 'SK-POkScHWg'),
            YoutubeModel(id: 7, youtubeId: 'HDTpESDbrVs'),
            YoutubeModel(id: 8, youtubeId: '2EC09E2C1jM'),
            YoutubeModel(id: 9, youtubeId: 'fxbFx42w6Vg'),
            YoutubeModel(id: 10, youtubeId: 'n53ePj0NOcE'),
            YoutubeModel(id: 11, youtubeId: '-robfzZwWuI'),
            YoutubeModel(id: 12, youtubeId: 'vv08PYzqZ7k'),
            YoutubeModel(id: 13, youtubeId: 'unQqeyB6c6U'),
            YoutubeModel(id: 14, youtubeId: 'EQfZ_ekL3fg'),
            YoutubeModel(id: 15, youtubeId: 'BH2D4Y3tZ70'),
            YoutubeModel(id: 16, youtubeId: 'vcrh_kSoG6o'),
          ];
          break;
        case 5:
          videosList = [
            YoutubeModel(id: 1, youtubeId: 'FnKMMotydpA'),
            YoutubeModel(id: 2, youtubeId: 'b-LepZ5cWzM'),
            YoutubeModel(id: 3, youtubeId: 'cQ4zVrzhQy8'),
            YoutubeModel(id: 4, youtubeId: 'HT8IXHC9y2Y'),
            YoutubeModel(id: 5, youtubeId: 'x-MHb-jQcQY'),
            YoutubeModel(id: 6, youtubeId: 'y_w7esmw9RE'),
            YoutubeModel(id: 7, youtubeId: 'wtIbaMQU0Mg'),
            YoutubeModel(id: 8, youtubeId: 'En8Ph28SE4U'),
            YoutubeModel(id: 9, youtubeId: 'UJgbn9NQM9s'),
            YoutubeModel(id: 10, youtubeId: 'nk7_28NLAUE'),
            YoutubeModel(id: 11, youtubeId: 'hZIPBjmG5CU'),
            YoutubeModel(id: 12, youtubeId: '2RtiRwYgRpA'),
            YoutubeModel(id: 13, youtubeId: '84py_5Yb2Ik'),
            YoutubeModel(id: 14, youtubeId: 'vcGN7DDxsM0'),
            YoutubeModel(id: 15, youtubeId: '9B3GkxzNerM'),
            YoutubeModel(id: 16, youtubeId: 'FG7CiiUttcs'),
          ];
          break;
        case 6:
          videosList = [
            YoutubeModel(id: 1, youtubeId: 'mIdA4E4boHU'),
            YoutubeModel(id: 2, youtubeId: 'njKNyDsLGRc'),
            YoutubeModel(id: 3, youtubeId: 'ph99o6jaw1Y'),
            YoutubeModel(id: 4, youtubeId: 'RCbRqpzfqn0'),
            YoutubeModel(id: 5, youtubeId: 'Nw-WKAAPpp8'),
            YoutubeModel(id: 6, youtubeId: 'vRp6WmiWgB0'),
            YoutubeModel(id: 7, youtubeId: 'v3s2RFdDxY8'),
            YoutubeModel(id: 8, youtubeId: '5fjD6nb9h5Q'),
            YoutubeModel(id: 9, youtubeId: 'ZvnWifKHTt0'),
            YoutubeModel(id: 10, youtubeId: '9KNPv_887Ls'),
            YoutubeModel(id: 11, youtubeId: 'TQd3rkF5zfw'),
            YoutubeModel(id: 12, youtubeId: 'qb3LUJF41AM'),
            YoutubeModel(id: 13, youtubeId: '-4mAbqooasI'),
            YoutubeModel(id: 14, youtubeId: 'Mjw-es3Dx60'),
            YoutubeModel(id: 15, youtubeId: 'RQw5QkOQYRA'),
            YoutubeModel(id: 16, youtubeId: 'OEXcvkHIa00'),
          ];
          break;
      }
    } else {
      switch (widget.playList) {
        case 0:
          if (Prefs.getString(Prefs.ROUTE) != "PRODUCT_LAB") {
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
          break;
        case 1:
          videosList = [
            YoutubeModel(id: 1, youtubeId: 'w-BHocWFhak'),
            YoutubeModel(id: 2, youtubeId: '1fgr2H6Jf_A'),
            YoutubeModel(id: 3, youtubeId: 'PQZeec3TKIo'),
            YoutubeModel(id: 4, youtubeId: 'hTuYWB16Oms'),
            YoutubeModel(id: 5, youtubeId: 'I7Wa9YMu4PU'),
            YoutubeModel(id: 6, youtubeId: '9e4XGu2drGQ'),
            YoutubeModel(id: 7, youtubeId: '9WL0Xz9S94c'),
            YoutubeModel(id: 8, youtubeId: 'jRNfxEGAH7E'),
            YoutubeModel(id: 9, youtubeId: '5zIPQCI66u8'),
            YoutubeModel(id: 10, youtubeId: '-uCZaIGRuNA'),
            YoutubeModel(id: 11, youtubeId: 'kwccYXHFVKM'),
            YoutubeModel(id: 12, youtubeId: 'pkcFxxZ928I'),
            YoutubeModel(id: 13, youtubeId: 'CpnTueP1AaQ'),
            YoutubeModel(id: 14, youtubeId: 'GQJjh3btJNo'),
            YoutubeModel(id: 15, youtubeId: 'Oq0UycoyKsI'),
            YoutubeModel(id: 16, youtubeId: 'Bull2Mjzxq0'),
          ];
          break;
        case 2:
          videosList = [
            YoutubeModel(id: 1, youtubeId: '62UdUyHFP1o'),
            YoutubeModel(id: 2, youtubeId: '6hy__6fjz_Y'),
            YoutubeModel(id: 3, youtubeId: 'bsFtpwLqra4'),
            YoutubeModel(id: 4, youtubeId: 'IAOXijc7EoE'),
            YoutubeModel(id: 5, youtubeId: 'GMRU9NUiiw0'),
            YoutubeModel(id: 6, youtubeId: 'YHKIVr_8FG8'),
            YoutubeModel(id: 7, youtubeId: 'Y76RKiordFg'),
            YoutubeModel(id: 8, youtubeId: 'XU8KqJwJkNM'),
            YoutubeModel(id: 9, youtubeId: 'B0Ga3OU514E'),
            YoutubeModel(id: 10, youtubeId: '8Iq4mvwMN8k'),
            YoutubeModel(id: 11, youtubeId: 'Wljn1FLZ7Vg'),
            YoutubeModel(id: 12, youtubeId: 'r1u3V3QrkBE'),
            YoutubeModel(id: 13, youtubeId: 'BzRrkPGqAKw'),
            YoutubeModel(id: 14, youtubeId: 'nUwWZue1-GA'),
            YoutubeModel(id: 15, youtubeId: 'NQt6LZwvNEA'),
            YoutubeModel(id: 16, youtubeId: 'Up2aG2ySNuM'),
          ];
          break;
        case 3:
          videosList = [
            YoutubeModel(id: 1, youtubeId: '3U9iY7nTMVc'),
            YoutubeModel(id: 2, youtubeId: 'ENMQpa-tMZQ'),
            YoutubeModel(id: 3, youtubeId: 'jBbJqZoVoyw'),
            YoutubeModel(id: 4, youtubeId: 'Jkry61lK5CU'),
            YoutubeModel(id: 5, youtubeId: 'a2N60Pt7KRY'),
            YoutubeModel(id: 6, youtubeId: 'x8so7-Wj6OU'),
            YoutubeModel(id: 7, youtubeId: 'J4SjBN9NvF4'),
            YoutubeModel(id: 8, youtubeId: '0ChStX_ayw0'),
            YoutubeModel(id: 9, youtubeId: 'Uj4IxUgzygs'),
            YoutubeModel(id: 10, youtubeId: 'ALgJW67BCiU'),
            YoutubeModel(id: 11, youtubeId: 'WB7gIu-IS4E'),
            YoutubeModel(id: 12, youtubeId: 'BWIFBrAtWNc'),
            YoutubeModel(id: 13, youtubeId: 'dicVvCTfu18'),
            YoutubeModel(id: 14, youtubeId: '5__gVMKtYBM'),
            YoutubeModel(id: 15, youtubeId: '6zxGwYmmJ48'),
            YoutubeModel(id: 16, youtubeId: 'F1Md3_DvXb8'),
          ];
          break;
        case 4:
          videosList = [
            YoutubeModel(id: 1, youtubeId: 'qs1phaoiAAk'),
            YoutubeModel(id: 2, youtubeId: '9vUaVKlQkRg'),
            YoutubeModel(id: 3, youtubeId: '0sLWbTTTELQ'),
            YoutubeModel(id: 4, youtubeId: 'aTV310Ii2OA'),
            YoutubeModel(id: 5, youtubeId: 'SS0xxW8EDnU'),
            YoutubeModel(id: 6, youtubeId: 'lw4vPl9AQHI'),
            YoutubeModel(id: 7, youtubeId: '1oA0YqlQe1w'),
            YoutubeModel(id: 8, youtubeId: 'RaHwZfgZzIY'),
            YoutubeModel(id: 9, youtubeId: 'Gnknvp1Y8E8'),
            YoutubeModel(id: 10, youtubeId: '7H01-vTP1yw'),
            YoutubeModel(id: 11, youtubeId: 'ENIxAL3BEvY'),
            YoutubeModel(id: 12, youtubeId: 'jJDm-MhPAcQ'),
            YoutubeModel(id: 13, youtubeId: 'cVEY0RcRqnE'),
            YoutubeModel(id: 14, youtubeId: 'wbf4pQfDW8c'),
            YoutubeModel(id: 15, youtubeId: 'NZNviajhRA8'),
            YoutubeModel(id: 16, youtubeId: '5rROkfS65HA'),
          ];
          break;
        case 5:
          videosList = [
            YoutubeModel(id: 1, youtubeId: 'NzTEZfEzkiU'),
            YoutubeModel(id: 2, youtubeId: 'xp9jiFdcZCU'),
            YoutubeModel(id: 3, youtubeId: 'E7ypPdFCRfQ'),
            YoutubeModel(id: 4, youtubeId: 'YiVhBfRIRI4'),
            YoutubeModel(id: 5, youtubeId: 'nF6SjhD96G4'),
            YoutubeModel(id: 6, youtubeId: 'WBbgDKc3hOw'),
            YoutubeModel(id: 7, youtubeId: 'USbjDsbKDfs'),
            YoutubeModel(id: 8, youtubeId: 'hAlCEMIjuqg'),
            YoutubeModel(id: 9, youtubeId: 'ZDV7vOZ_duw'),
            YoutubeModel(id: 10, youtubeId: '6FuG8EXWx8I'),
            YoutubeModel(id: 11, youtubeId: 'jqsqs2ez7p8'),
            YoutubeModel(id: 12, youtubeId: '307qV__Wg1I'),
            YoutubeModel(id: 13, youtubeId: 't7PP4B7u6bk'),
            YoutubeModel(id: 14, youtubeId: 'qjaWdvmsHIQ'),
            YoutubeModel(id: 15, youtubeId: 'yT3xa6LEkWA'),
            YoutubeModel(id: 16, youtubeId: '2OTLm2xn-EI'),
          ];
          break;
        case 6:
          videosList = [
            YoutubeModel(id: 1, youtubeId: '_CAT-Q4cY8Y'),
            YoutubeModel(id: 2, youtubeId: 'rQX8F04MPD4'),
            YoutubeModel(id: 3, youtubeId: 'vYd6uM5HCYA'),
            YoutubeModel(id: 4, youtubeId: 'XS1n-5Ze5N4'),
            YoutubeModel(id: 5, youtubeId: 'NqaCO68aOUA'),
            YoutubeModel(id: 6, youtubeId: 'col80nHtJ2U'),
            YoutubeModel(id: 7, youtubeId: 'rOsWiJygrmA'),
            YoutubeModel(id: 8, youtubeId: 'H5xeNU9uhaQ'),
            YoutubeModel(id: 9, youtubeId: 'RPDR2dZJ4BQ'),
            YoutubeModel(id: 10, youtubeId: 'qJy5Qtjr368'),
            YoutubeModel(id: 11, youtubeId: 'QfgbCp1xTXA'),
            YoutubeModel(id: 12, youtubeId: 'N7WkB5gjRs4'),
            YoutubeModel(id: 13, youtubeId: 'StudfvRBlXs'),
            YoutubeModel(id: 14, youtubeId: '6NVl7grmLy4'),
            YoutubeModel(id: 15, youtubeId: 'wJUsr0E553U'),
            YoutubeModel(id: 16, youtubeId: 'n92NxvbP2zQ'),
          ];
          break;
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
    return Scaffold(
      appBar: AppBar(title: Text(widget.titles[widget.playList]),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildYtbView(),
            SizedBox(height: 10),
            _buildMoreVideosView(),
          ],
        ),
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
                  height: MediaQuery
                      .of(context)
                      .size
                      .height / 5,
                  margin: EdgeInsets.symmetric(vertical: 7),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        Positioned(
                          child: CachedNetworkImage(
                            imageUrl:
                            "https://img.youtube.com/vi/${videosList[index]
                                .youtubeId}/0.jpg",
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
