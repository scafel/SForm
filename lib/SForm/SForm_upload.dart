import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sform/Util/Config.dart';
import 'package:sform/SForm/SForm_common.dart';
import 'package:sform/SForm/SForm_row.dart';


/// 文件上传
///
///


enum SFormUploadType {
  file,
  images,
  video,
  audio,
}

class SFormUpload extends StatefulWidget {
  const SFormUpload({Key? key, required this.row}) : super(key: key);

  final SFormRow row;

  @override
  State<SFormUpload> createState() => _SFormUploadState();
}

class _SFormUploadState extends State<SFormUpload> {

  SFormRow get row => widget.row;


  String value = "";
  List<String> values = [];

  @override
  void initState() {
    super.initState();
    if(row.multiple!){
      for (int i = 0 ; i < row.multipleLimit! ; i++) {
        values.add("");
      }
    }else{
      row.multipleLimit = 1;
      values.add("");
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = SFormConfig.rowConfig.height??50;
    return Container(
      padding: SFormConfig.rowConfig.padding ?? const EdgeInsets.fromLTRB(10, 2, 10, 2),
      decoration: SFormConfig.rowConfig.decoration,
      child: Container(
        constraints: BoxConstraints(
          minHeight: height,
        ),
        child: layoutWidget(context),
      ),
    );
  }

  Widget layoutWidget(BuildContext context){
    Widget child =  uploadField(context);
    switch(row.rowLayout){
      case RowLayout.ud:
        return layoutWidgetUD(row , child);
        break;
      case RowLayout.du:
        return layoutWidgetDU(row , child);
        break;
      case RowLayout.lr:
        return layoutWidgetLR(row , child);
        break;
      case RowLayout.rl:
        return layoutWidgetRL(row , child);
        break;
    }
  }

  Widget uploadField(BuildContext context) {
    List<Widget> children = [];
    switch(row.uploadType){
      case SFormUploadType.images:
        for (int i = 0 ; i < row.multipleLimit! ; i++) {
          children.add(InkWell(
            child: Container(
              width: 100,
              height: 100,
              child: Image.network(
                values[i],
                errorBuilder: (BuildContext, Object, StackTrace? s){
                  return Container(
                    width: 50,
                    height: 50,
                    color: Colors.grey,
                  );
                },
              ),
            ),
            onTap: (){
              row.onTap != null ? row.onTap!(row).then( (value){
                mounted?setState((){
                  values[i] = value.toString();
                }):null;
              }):null;
            },
          ));
        }
        return Wrap(
          direction: Axis.horizontal,
          spacing: 5,
          runSpacing: 5,
          children: children,
        );
        break;
      case SFormUploadType.video:
        for (int i = 0 ; i < row.multipleLimit! ; i++) {
          children.add(InkWell(
            child: Container(
              child: Text(values[i].isEmpty ? "点击上传" : values[i]),
            ),
            onTap: (){
              row.onTap != null ? row.onTap!(row).then( (value){
                mounted?setState((){
                  values[i] = value.toString();
                }):null;
              }):null;
            },
          ));
        }
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        );
        break;
      case SFormUploadType.audio:
        for (int i = 0 ; i < row.multipleLimit! ; i++) {
          children.add(InkWell(
            child: Container(
              child: Text(values[i].isEmpty ? "点击上传" : values[i]),
            ),
            onTap: (){
              row.onTap != null ? row.onTap!(row).then( (value){
                mounted?setState((){
                  values[i] = value.toString();
                }):null;
              }):null;
            },
          ));
        }
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        );
        break;
      case SFormUploadType.file:
      default:
        for (int i = 0 ; i < row.multipleLimit! ; i++) {
          children.add(InkWell(
            child: Container(
              child: Text(values[i].isEmpty ? "点击上传" : values[i]),
            ),
            onTap: (){
              row.onTap != null ? row.onTap!(row).then( (value){
                mounted?setState((){
                  values[i] = value.toString();
                }):null;
              }):null;
            },
          ));
        }
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        );
        break;

    }
  }
}