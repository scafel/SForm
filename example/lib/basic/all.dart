import 'package:example/Util/MessageUtil.dart';
import 'package:flutter/material.dart';
import 'package:sform/SForm/SForm.dart';
import 'package:sform/SForm/SForm_row.dart';
import 'package:sform/SForm/SForm_select.dart';

class SFormAll extends StatefulWidget {
  const SFormAll({Key? key}) : super(key: key);

  @override
  State<SFormAll> createState() => _SFormAllState();
}

class _SFormAllState extends State<SFormAll> {

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
    SFormRow.Select(
        name: "singleSelectNormal",
        title: "常规单选框",
        options: [
          SFormSelectOption(title: "name", value: 1 , selected: true),
          SFormSelectOption(title: "password", value: 2),
          SFormSelectOption(title: "pasd", value:3),
          SFormSelectOption(title: "pasd", value:4),
          SFormSelectOption(title: "pasd", value:5),
          SFormSelectOption(title: "pasd", value:6),
          SFormSelectOption(title: "pasd", value:7),
          SFormSelectOption(title: "pasd", value:8),
        ],
        enabled: true,
        onChange: (row){
          print(123);
        }
    ),
    SFormRow.Select(
      name: "multipleSelectNormal",
      title: "常规多选框",
      require: true,
      options: [
        SFormSelectOption(title: "name", value: 1 ),
        SFormSelectOption(title: "password", value: 2 ),
        SFormSelectOption(title: "pasd", value:3),
        SFormSelectOption(title: "pasd", value:4),
        SFormSelectOption(title: "pasd", value:5),
        SFormSelectOption(title: "pasd", value:6),
        SFormSelectOption(title: "pasd", value:7),
        SFormSelectOption(title: "pasd", value:8),
      ],
      enabled: true,
      pickerOption: SFormPickerOption(
          cancelTitle: "取消",
          confirmTitle: "确认"
      ),
      multiple: true,
    ),
    SFormRow.Text(
        name: "allText",
        title: "常规输入框"
    ),
    SFormRow.Text(
      rowLayout: RowLayout.rl,
      name: "allText",
      title: "常规输入框",
    ),
    SFormRow.TextArea(
        name: "allText",
        title: "常规输入框"
    ),
    SFormRow.TextArea(
      rowLayout: RowLayout.rl,
      name: "allText",
      title: "常规输入框",
    ),
  ];
}
