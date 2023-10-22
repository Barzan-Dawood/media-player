
// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations, unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_players/controllers/player_controoler.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Players extends StatefulWidget {
  const Players({super.key, required this.listData});

   final List<SongModel> listData;

  @override
  State<Players> createState() => _PlayersState();
}

class _PlayersState extends State<Players> {
  @override
  Widget build(BuildContext context) {
    var controller = Get.find<PlayeController>();
    return Scaffold(
      backgroundColor: Colors.purple,
      appBar: AppBar(title: Text("player"),centerTitle: true,),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Obx(
              ()=> Expanded(
                child: Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  width: 280,
                  height: 280,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                 
                  ),
                  alignment: Alignment.center,
                  child: QueryArtworkWidget(
                    id: widget.listData[controller.playIndex.value].id,
                   type: ArtworkType.AUDIO,
                   artworkHeight: double.infinity,
                   artworkWidth: double.infinity,
                   nullArtworkWidget: const Icon(Icons.music_note),
                   ),
                )
              
                 ),
            ),
            const SizedBox(height: 12),  
                Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                  color: Colors.white24,
                ),
                child:   Obx(
                  ()=> Column(
                    children: [
                          Text(
                            "${widget.listData[controller.playIndex.value].displayNameWOExt}",
                             textAlign: TextAlign.center,
                             overflow: TextOverflow.ellipsis,
                             maxLines: 2,
                             style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                      SizedBox(height: 10),
                          Text("${widget.listData[controller.playIndex.value].artist}",
                             textAlign: TextAlign.center,
                             overflow: TextOverflow.ellipsis,
                             maxLines: 1,
                             style: TextStyle(fontWeight: FontWeight.bold),),
                      SizedBox(height: 12),
                          Obx(
                   ()=> Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("${controller.postion.value}"),
                      Expanded(
                        child: Slider(
                          value:controller.value.value,
                          min: Duration(seconds: 0).inSeconds.toDouble(),
                          max: controller.max.value,
                          inactiveColor: Colors.grey,
                           onChanged: (val){
                               controller.changeDtoP(val.toInt());
                               val = val;
                           },
                           
                             
                           ),
                          ),
                       Text("${controller.durtion.value}"),
                    ],
                   ),
                                 ),
                  SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(onPressed: (){
                  controller.playSong(
                     widget.listData[controller.playIndex.value - 1].uri,
                    controller.playIndex.value - 1,
                    
                    );
                      },
                       icon: Icon(Icons.skip_previous_rounded,size: 30,)),
                    
                      Obx(
                        () => CircleAvatar(
                          radius: 35,
                          backgroundColor: Colors.deepPurple,
                          
                          child: IconButton(onPressed: (){
                             if(controller.isPlaye.value){
                              controller.audioPlayer.pause();
                              controller.isPlaye(false);
                             }
                             else{
                              controller.audioPlayer.play();
                              controller.isPlaye(true);
                             }
                          },
                           icon: controller.isPlaye.value ? 
                            Icon(Icons.pause,color: Colors.white,size: 55) : 
                            Icon(Icons.play_arrow_rounded,color: Colors.white,size: 55)
                            
                            ) ,
                        ),
                      ),
                     
                      IconButton(onPressed: (){
                        controller.playSong(
                     widget.listData[controller.playIndex.value+1].uri,
                    controller.playIndex.value + 1,
                    
                    );
                      },
                       icon: Icon(Icons.skip_next_rounded,size: 30)),
                  
                    ],
                  ),
                  
                    ],
                  ),
                ),
                
                
              )
              
               ),
          ],
        ),        
        ),
    );
  }
}