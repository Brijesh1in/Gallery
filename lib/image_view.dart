import 'dart:io';
import 'package:flutter/material.dart';
import 'package:matrix_gesture_detector/matrix_gesture_detector.dart';
import 'package:vector_math/vector_math_64.dart';
//import 'package:zoomable_image/zoomable_image.dart';
class ImageView extends StatefulWidget{
  final File img;
  ImageView(this.img);
  @override
  _ImageViewState createState() => _ImageViewState(img);
}

class _ImageViewState extends State<ImageView> {

  File img;
  double _scale = 1.0;
  double _prev = 1.0;
  _ImageViewState(this.img);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
//          child: GestureDetector(
//
//            onScaleStart: (ScaleStartDetails details){
//
//              setState(() {
//                _scale = _prev;
//              });
//            },
//            onScaleUpdate: (ScaleUpdateDetails details){
//              setState(() {
//                _scale = _prev * details.scale;
//              });
//              print(_scale);
//            },
//            onScaleEnd: (ScaleEndDetails details){
//
//              setState(() {
//                _prev = _scale;
//              });
//            },
//            child : Transform(
//              alignment : FractionalOffset.center,
//              transform: Matrix4.diagonal3(Vector3(_scale , _scale , _scale)),
//              child: Image.file(img),
//            )
//
//          ),
          child: ZoomableWidget(child: Image.file(img)),
        );
  }
}

//class ZoomableWidget extends StatefulWidget {
//  final Widget child;
//
//  const ZoomableWidget({Key key, this.child}) : super(key: key);
//  @override
//  _ZoomableWidgetState createState() => _ZoomableWidgetState();
//}
//
//class _ZoomableWidgetState extends State<ZoomableWidget> {
//  Matrix4 matrix = Matrix4.identity();
//
//  @override
//  Widget build(BuildContext context) {
//    return MatrixGestureDetector(
//      onMatrixUpdate: (Matrix4 m, Matrix4 tm, Matrix4 sm, Matrix4 rm) {
//        setState(() {
//          matrix = m;
//        });
//      },
//      child: Transform(
//        transform: matrix,
//        child: widget.child,
//      ),
//    );
//  }
//}

class ZoomableWidget extends StatefulWidget {
  final Widget child;
  
  const ZoomableWidget({Key key, this.child}) : super(key: key);
  @override
  _ZoomableWidgetState createState() => _ZoomableWidgetState();
}

class _ZoomableWidgetState extends State<ZoomableWidget> {
  Matrix4 matrix = Matrix4.identity();
  Matrix4 zerada =  Matrix4.identity();
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: (){
        setState(() {
          matrix = zerada;
        });
      },
      child: MatrixGestureDetector(
        shouldRotate: false,
        onMatrixUpdate: (Matrix4 m, Matrix4 tm, Matrix4 sm, Matrix4 rm) {
          setState(() {
            matrix = m;
          });
        },
        child: Transform(
          transform: matrix,
          child: widget.child,
        ),
      ),
    );
  }
}

