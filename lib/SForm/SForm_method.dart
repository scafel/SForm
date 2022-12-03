import 'package:sform/sform.dart';

/// 关于表单中的常用方法
///
///


List formValidationErrors(List<SFormRow> rows){
  List errors = [];
  for (var row in rows) {
    if (row.validator != null) {
      bool isSuccess = row.validator!(row) as bool;
      if (!isSuccess) {
        errors.add(row.requireMsg.isNotEmpty?row.requireMsg : "${row.title?.replaceAll("*", "")} 不能为空");
      }
    } else {
      if (row.require == true && row.value.isEmpty) {
        errors.add(row.requireMsg.isNotEmpty?row.requireMsg : "${row.title?.replaceAll("*", "")} 不能为空");
      }
    }
  }
  return errors;
}

