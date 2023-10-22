
// ignore_for_file: unnecessary_const, unused_local_variable, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_players/controllers/player_controoler.dart';
import 'package:music_players/view/players.dart';
 import 'package:on_audio_query/on_audio_query.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
   var controller = Get.put(PlayeController());
  @override
  Widget build(BuildContext context) {
     
    return Scaffold(
     
      appBar: AppBar(
        title: const Text("Music Player"),centerTitle: true,
        leading: IconButton(onPressed: (){
          if(Get.isDarkMode){
              Get.changeTheme(ThemeData.light());
          }
          else{
            Get.changeTheme(ThemeData.dark());
          }
        }, icon: const Icon(Icons.dark_mode)),
        actions: [

          // IconButton(onPressed: (){
            
          // }, icon: const Icon(Icons.search)),
        ],
      ),
      body: FutureBuilder<List<SongModel>>(
        future: controller.audioQuery.querySongs(
           ignoreCase: true,
        orderType: OrderType.ASC_OR_SMALLER,
        sortType: null,
        uriType: UriType.EXTERNAL
        ), 
        builder: (BuildContext context , snapshot){
             if(snapshot.data == null){
              return const Center(child: CircularProgressIndicator());
             }
             else{
                return  Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: snapshot.data!.length,
          itemBuilder: (BuildContext context , int index){
             return Container(
              margin: const EdgeInsets.only(bottom: 5),
               child:   Obx(
                ()=> ListTile(
                   
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  tileColor: Colors.purple,
                  title: Text("${snapshot.data![index].displayNameWOExt}",
                   textAlign: TextAlign.center,
                             overflow: TextOverflow.ellipsis,
                             maxLines: 2,
                  style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                  subtitle: Text("${snapshot.data![index].artist}",
                   textAlign: TextAlign.center,
                             overflow: TextOverflow.ellipsis,
                             maxLines: 1,
                  ),
                  leading: QueryArtworkWidget(
                    id: snapshot.data![index].id,
                    type: ArtworkType.AUDIO,
                    nullArtworkWidget: const Icon(Icons.music_note,color: Color.fromARGB(255, 19, 132, 23),size: 30),
                    ),
                  trailing: controller.playIndex.value == index && controller.isPlaye.value?
                   IconButton(onPressed: (){
                     Get.to(()=>   Players(listData: snapshot.data!),
                     transition: Transition.downToUp,
                    );    
                   }, icon: const Icon(Icons.play_arrow,color: Colors.green,size: 50)) : null,
                 
                  onTap: (){
                    Get.to(()=>   Players(listData: snapshot.data!),
                     transition: Transition.downToUp,
                    );
                  controller.playSong(snapshot.data![index].uri , index);
                  },
                            
                 ),
               ),
            
             );
             
        }
         
        ),
        );
             }
            
        })
    );
  }

}
 