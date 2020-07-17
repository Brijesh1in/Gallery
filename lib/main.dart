import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gallery/Permission.dart';
import 'package:gallery/image_view.dart';
import 'package:permission_handler/permission_handler.dart';
import 'device_size_config.dart';
import 'cell.dart';
import 'permission_temp.dart';
import 'package:photo_manager/photo_manager.dart';
import 'dart:io';
import 'test.dart';

int totImages = 0;
var listOfAllImages;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
  runApp(Gallery());

}
class Gallery extends StatefulWidget {
  @override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {

  File img;
  void getList() async{

    List<AssetPathEntity> list = await PhotoManager.getAssetPathList();
    totImages = list[0].assetCount;
    print(totImages);
    print(list);
    final assetList = list[0].getAssetListRange(start: 0, end: totImages);
    assetList.then((data){
//      print(data[2].file.then((onValue){
//
//        if(onValue!=null){
//
//          setState(() {
//            img = onValue;
//          });
//        }
//      }));

      if(data!=null){

       listOfAllImages = data;
      }

    });


  }

  @override
  void initState() {

    super.initState();
    getList();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //title: 'Gallery',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Color(0xFF031736),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget{

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Future<File> getFutureImageFile(int index) async{

    return await listOfAllImages[index].file;
  }
  File getImageFile(int index){

    Future<File> img = getFutureImageFile(index);
    File finalImg;
    img.then((onValue){

      finalImg = onValue;
    });
    return finalImg;
  }
  @override
  Widget build(BuildContext context) {

    SizeConfig.init(context);
    return Scaffold(

      drawer: Drawer(

        child: ListView(

          children: <Widget>[

            Text('On3'),
            Text('2'),
          ],
        ),
      ),
      body: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            title: Text('Gallery'),
            expandedHeight: SizeConfig.blockHeight * 30.0,
            //backgroundColor: Colors.red,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset('images/test.jpg',fit: BoxFit.fill,)
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(10),
              ),
            ),
          ),
          SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 5.0,
                crossAxisSpacing: 5.0,
                childAspectRatio: 1.0),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Cell(index , listOfAllImages);
              },
              childCount: totImages,
            ),
          ),

          ],
      ),
    );
  }
}

//import 'package:flutter/material.dart';
//import 'dart:async';
//
//import 'package:multi_image_picker/multi_image_picker.dart';
//
//void main() => runApp(new MyApp());
//
//class MyApp extends StatefulWidget {
//  @override
//  _MyAppState createState() => new _MyAppState();
//}
//
//class _MyAppState extends State<MyApp> {
//  List<Asset> images = List<Asset>();
//  String _error;
//
//  @override
//  void initState() {
//    super.initState();
//  }
//
//  Widget buildGridView() {
//    if (images != null)
//      return GridView.count(
//        crossAxisCount: 3,
//        children: List.generate(images.length, (index) {
//          Asset asset = images[index];
//          return AssetThumb(
//            asset: asset,
//            width: 300,
//            height: 300,
//          );
//        }),
//      );
//    else
//      return Container(color: Colors.white);
//  }
//
//  Future<void> loadAssets() async {
//    setState(() {
//      images = List<Asset>();
//    });
//
//    List<Asset> resultList;
//    String error;
//
//    try {
//      resultList = await MultiImagePicker.pickImages(
//        maxImages: 300,
//      );
//    } on Exception catch (e) {
//      error = e.toString();
//    }
//
//    // If the widget was removed from the tree while the asynchronous platform
//    // message was in flight, we want to discard the reply rather than calling
//    // setState to update our non-existent appearance.
//    if (!mounted) return;
//
//    setState(() {
//      images = resultList;
//      if (error == null) _error = 'No Error Dectected';
//    });
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return new MaterialApp(
//      home: new Scaffold(
//        appBar: new AppBar(
//          title: const Text('Plugin example app'),
//        ),
//        body: Column(
//          children: <Widget>[
//            Center(child: Text('Error: $_error')),
//            RaisedButton(
//              child: Text("Pick images"),
//              onPressed: loadAssets,
//            ),
//            Expanded(
//              child: buildGridView(),
//            )
//          ],
//        ),
//      ),
//    );
//  }
//}