import 'package:example/Util/MessageUtil.dart';
import 'package:flutter/material.dart';
import 'package:sform/SForm/SForm.dart';
import 'package:sform/SForm/SForm_date.dart';
import 'package:sform/SForm/SForm_row.dart';

class SFormDatePage extends StatelessWidget {
  SFormDatePage({Key? key}) : super(key: key);

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
    SFormRow.Date(
      name: "date",
      title: "date",
      rowLayout: RowLayout.ud
    ),
    SFormRow.Date(
      name: "datetime",
      title: "datetime",
      dateFormat: "Y-m-d H:i:s",
      dateType: SFormDateType.datetime
    ),
    SFormRow.Date(
        name: "year",
        title: "year",
        dateFormat: "Y",
        dateType: SFormDateType.year
    ),
    SFormRow.Date(
        name: "month",
        title: "month",
        dateFormat: "Y-m",
        dateType: SFormDateType.month
    ),
    SFormRow.Date(
        name: "dateRange",
        title: "dateRange",
        dateType: SFormDateType.daterange
    ),
    SFormRow.Date(
        name: "monthrange",
        title: "monthrange",
        dateFormat: "Y-m",
        dateType: SFormDateType.monthrange
    ),
    SFormRow.Date(
        name: "datetimerange",
        title: "datetimerange",
        dateFormat: "Y-m-d H:i:s",
        dateType: SFormDateType.datetimerange
    ),
    SFormRow.Date(
        name: "dates",
        title: "dates",
        dateType: SFormDateType.dates
    ),
    SFormRow.Date(
        name: "week",
        title: "week",
        dateType: SFormDateType.week
    ),
  ];
}
