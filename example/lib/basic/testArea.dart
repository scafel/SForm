import 'package:example/Util/MessageUtil.dart';
import 'package:flutter/material.dart';
import 'package:sform/SForm/SForm.dart';
import 'package:sform/SForm/SForm_row.dart';

class SFormTextAreaPage extends StatelessWidget {
  SFormTextAreaPage({Key? key}) : super(key: key);

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
    SFormRow.TextArea(
        name: "allText",
        title: "常规输入框"
    ),
    SFormRow.TextArea(
      rowLayout: RowLayout.rl,
      name: "allText",
      title: "常规输入框",
    ),
    SFormRow.TextArea(
      rowLayout: RowLayout.du,
      name: "allText",
      title: "常规输入框",
    ),
    SFormRow.TextArea(
      rowLayout: RowLayout.ud,
      name: "allText",
      title: "常规输入框常规输入框常规输入框常规输入框常规输入框常规输入框常规输入框常规输入框常规输入框常规输入框常规输入框常规输入框常规输入框常规输入框常规输入框常规输入框常规输入框常规输入框常规输入框",
    ),
    SFormRow.TextArea(
        name: "reText",
        title: "必填输入框",
        requireStar: true,
        require: true,
        requireMsg: "必填输入框 必填 不能为空"
    ),
    SFormRow.TextArea(
        name: "preText",
        prefixWidget: (row){
          return Icon( Icons.person);
        }
    ),
    SFormRow.TextArea(
        name: "preText",
        suffixWidget: (row){
          return Icon( Icons.last_page);
        }
    ),
    SFormRow.TextArea(
        name: "preText",
        prefixWidget: (row){
          return Icon( Icons.add);
        },
        suffixWidget: (row){
          return Icon( Icons.add);
        }
    ),
    SFormRow.TextArea(
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
    SFormRow.TextArea(
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
