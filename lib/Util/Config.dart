import 'package:flutter/material.dart';

/// 子项构成结构方式
enum SFormWidgetType { column, sliver, builder, separated }

/// 表单项类型
enum SFormRowType { text, select , radio , date , checkbox , cascader , upload , textarea , extendField}

class SFormConfig{

  /// 表单项的长度
  static int rowLength = 0;
  static SFormWidgetType widgetType = SFormWidgetType.column;
  static double width = 0.0;
  static Divider divider = const Divider(height: 1,);
  static SFormRowConfig rowConfig = SFormRowConfig(
    padding: EdgeInsets.zero,
    titleStyle: const TextStyle(
      fontSize: 15,
      color: Colors.black87,
      overflow: TextOverflow.ellipsis
    ),
    valueStyle: const TextStyle(
        fontSize: 15,
        color: Colors.black87,
        overflow: TextOverflow.ellipsis
    ),
    placeholderStyle:const TextStyle(fontSize: 15, color: Color.fromARGB(76, 60, 60, 67)),
    disableColor: Colors.black54,
    decoration: BoxDecoration(),
    height: 58.0
  );



}


class SFormRowConfig {
  EdgeInsets? padding;
  TextStyle? titleStyle;
  TextStyle? valueStyle;
  TextStyle? placeholderStyle;
  Color? disableColor;
  BoxDecoration? decoration;
  double? height;

  SFormRowConfig({
    this.padding,
    this.titleStyle,
    this.valueStyle,
    this.placeholderStyle,
    this.disableColor,
    this.decoration,
    this.height = 58.0
  });
}