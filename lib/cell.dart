import 'dart:io';
import 'dart:typed_data';
import 'package:image/image.dart' as DartImage;
import 'package:flutter/material.dart';
import 'device_size_config.dart';

class Cell extends StatefulWidget {

  final int index;
  final List list;
  Cell(this.index, this.list);
  @override
  _CellState createState() => _CellState(index , list);
}

class _CellState extends State<Cell> {

  final int index;
  List list;
  File img;
  _CellState(this.index , this.list);

  void getImageFile(int index){
    Future<File> imgg = getFutureImageFile(index);
    imgg.then((onValue){
      
      setState(() {
        img = onValue;
      });
    });
  }
  Future<File> getFutureImageFile(int index) async{
  
    return await list[index].file;
  }
  @override
  void setState(var fn){
    
    if(mounted){
    
      super.setState(fn);
    }
  }
  DartImage.Image getThumbnail(File imgFile){

    DartImage.Image image = DartImage.decodeImage(imgFile.readAsBytesSync());

    // Resize the image to a 120x? thumbnail (maintaining the aspect ratio).
    DartImage.Image thumbnail = DartImage.copyResize(image, width: 120);
    return thumbnail;
  }
  @override
  Widget build(BuildContext context) {
    
    getImageFile(index);
    return Container(
      // borderRadius: BorderRadius.circular(10),
//      child: (img==null) ? Image.asset('images/1.jpg' , height: SizeConfig.blockHeight*30 , width: SizeConfig.blockWidth*30,) :
//              Image.file(getThumbnail(img)),
  
      decoration: BoxDecoration(
        image: DecorationImage(
          image: img == null
            ? AssetImage('images/1.jpg')
            : FileImage(img),
          fit: BoxFit.cover)),

    );
  }
}
