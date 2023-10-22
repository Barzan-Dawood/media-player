
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class PlayeController extends GetxController{

 final audioQuery = OnAudioQuery();
 final audioPlayer = AudioPlayer();
   var playIndex = 0.obs;
   var isPlaye = false.obs;
   var durtion = "".obs;
   var postion = "".obs;
   var max = 0.0.obs;
   var value = 0.0.obs;

 @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    checkPermission();

  }

  updatTimer(){
    audioPlayer.durationStream.listen((event) { 
      durtion.value = event.toString().split(".")[0];
      max.value = event!.inSeconds.toDouble();
    });
    audioPlayer.positionStream.listen((event) {
      postion.value = event.toString().split(".")[0];
      value.value = event.inSeconds.toDouble();
     });
  }

   changeDtoP(second){
    var durtion = Duration(seconds: second);
     audioPlayer.seek(durtion);
   }

  playSong(String? uri , index){
     playIndex.value = index;
    try{
      audioPlayer.setAudioSource(
      AudioSource.uri(Uri.parse(uri!)),
    );
       audioPlayer.play();
       isPlaye(true);
       updatTimer();
    } on Exception catch(e){
      print(e.toString());
    }
  }

  checkPermission()async{
    var pern = await Permission.storage.request();
    if(pern.isGranted){
      return audioQuery.querySongs(
        
      );
    }
    else{
      checkPermission();
    }
  }

}