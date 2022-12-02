import 'dart:io';

import 'package:example/Util/MessageUtil.dart';
import 'package:flutter/material.dart';
import 'package:sform/SForm/SForm.dart';
import 'package:sform/SForm/SForm_row.dart';
import 'package:sform/SForm/SForm_upload.dart';
import 'package:image_picker/image_picker.dart';


class SFormUpload extends StatelessWidget {
  SFormUpload({Key? key}) : super(key: key);

  final GlobalKey _formSelectKey = GlobalKey<SFormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("静态示例"),
        actions: [
          TextButton(
              onPressed: (){
                //校验
                List errors = (_formSelectKey.currentState as SFormState).validate();
                if (errors.isNotEmpty) {
                  showSnackBar(context, errors.first);
                  return;
                }
                Map<String , dynamic> formData = (_formSelectKey.currentState as SFormState).formData();
                showSnackBar(context, formData.toString());
              },
              child: const Text("提交验证" , style: TextStyle(color: Colors.white, fontSize: 16),)
          )
        ],
      ),
      body: ListView(
        children: [
          SForm.builder(
            key: _formSelectKey,
            rows: rows,
          )
        ],
      ),
    );
  }


  List<SFormRow> rows = [
    SFormRow.Upload(
      name: "upload",
      title: "常规文件上传",
      multiple: false,
        onTap: (row) async {
          Map<String , dynamic> res = await getImage();
          return res["filePath"];
        }
    ),
    SFormRow.Upload(
      name: "uploadImage",
      title: "常规文件上传",
      multiple: true,
      multipleLimit: 5,
      uploadType: SFormUploadType.images,
      onTap: (row) async {
        Map<String , dynamic> res = await getImage();
        return res["filePath"];
      }
    ),

  ];

  static Future<Map<String , dynamic>> getImage() async {
    Map<String , dynamic> res = {
      "filePath" : "",
      "success": false,
    };
    try {
      final _picker = ImagePicker();
      final pickedFile = await _picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        File file =  File(pickedFile.path);
        /// 此处可以使用自己的上传方式 返回地址等
        res["filePath"] = file.path;
        res["fileType"] = file.path;
        res["success"] = true;
        return res;
      } else {
        res["success"] = false;
        return res;
      }
    } catch (e) {
      print('Pick image error: $e');
      res["success"] = false;
      return res;
    }

  }

}
