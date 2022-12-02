import 'package:example/Util/MessageUtil.dart';
import 'package:flutter/material.dart';
import 'package:sform/SForm/SForm.dart';
import 'package:sform/SForm/SForm_row.dart';
import 'package:sform/SForm/SForm_text.dart';


class SFormTextPage extends StatelessWidget {
  SFormTextPage({Key? key}) : super(key: key);

  final GlobalKey _formTextKey = GlobalKey<SFormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("静态示例"),
        actions: [
          TextButton(
              onPressed: (){
                //校验
                List errors = (_formTextKey.currentState as SFormState).validate();
                if (errors.isNotEmpty) {
                  showSnackBar(context, errors.first);
                  return;
                }
                Map<String , dynamic> formData = (_formTextKey.currentState as SFormState).formData();
                showSnackBar(context, formData.toString());
              },
              child: const Text("提交验证" , style: TextStyle(color: Colors.white, fontSize: 16),)
          )
        ],
      ),
      body: ListView(
        children: [
          SForm.builder(
            key: _formTextKey,
            rows: rows,
          )
        ],
      ),
    );
  }


  List<SFormRow> rows = [
    SFormRow.Text(
        name: "allText",
        title: "常规输入框"
    ),
    SFormRow.Text(
      rowLayout: RowLayout.rl,
      name: "allText",
      title: "常规输入框",
    ),
    SFormRow.Text(
      rowLayout: RowLayout.du,
      name: "allText",
      title: "常规输入框",
    ),
    SFormRow.Text(
      rowLayout: RowLayout.ud,
      name: "allText",
      title: "常规输入框常规输入框常规输入框常规输入框常规输入框常规输入框常规输入框常规输入框常规输入框常规输入框常规输入框常规输入框常规输入框常规输入框常规输入框常规输入框常规输入框常规输入框常规输入框",
    ),
    SFormRow.Text(
        name: "reText",
        title: "必填输入框",
        requireStar: true,
        require: true,
        requireMsg: "必填输入框 必填 不能为空"
    ),
    SFormRow.Text(
        name: "preText",
        prefixWidget: (row){
          return Icon( Icons.person);
        }
    ),
    SFormRow.Text(
        name: "preText",
        suffixWidget: (row){
          return Icon( Icons.last_page);
        }
    ),
    SFormRow.Text(
        name: "preText",
        prefixWidget: (row){
          return Icon( Icons.add);
        },
        suffixWidget: (row){
          return Icon( Icons.add);
        }
    ),
    SFormRow.Text(
        name: "preText",
        title: "密码框",
        requireStar: true,
        require: true,
        obscureText: true,
        prefixWidget: (row){
          return Icon( Icons.add);
        },
        suffixWidget: (row){
          return Icon( Icons.add);
        }
    ),
    SFormRow.Text(
        name: "preText",
        title: "只能输入英文",
        textType: SFormTextType.en,
        requireStar: true,
        require: true,
        prefixWidget: (row){
          return Icon( Icons.add);
        },
        suffixWidget: (row){
          return Icon( Icons.add);
        }
    ),
    SFormRow.Text(
        name: "preText",
        title: "只能输入数字",
        textType: SFormTextType.int,
        requireStar: true,
        require: true,
        prefixWidget: (row){
          return Icon( Icons.add);
        },
        suffixWidget: (row){
          return Icon( Icons.add);
        }
    ),
    SFormRow.Text(
        name: "preText",
        title: "不可编辑",
        enabled: false,
        prefixWidget: (row){
          return Icon( Icons.add);
        },
        suffixWidget: (row){
          return Icon( Icons.add);
        }
    ),
    SFormRow.Text(
        name: "preText",
        title: "限制长度",
        maxlength: 10,
        prefixWidget: (row){
          return Icon( Icons.add);
        },
        suffixWidget: (row){
          return Icon( Icons.add);
        }
    ),
  ];
}
