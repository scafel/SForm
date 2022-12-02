import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sform/SForm/SForm_common.dart';
import 'package:sform/SForm/SForm_row.dart';
import 'package:sform/Util/Config.dart';

/// 单行文本输入框
///
///
enum SFormTextType {
  int ,
  double,
  en,
  @Deprecated("这里有一个bug 代码会报错 mac会输不进去值")
  zh,
  text,
}

class SFormText extends StatefulWidget {
  const SFormText({Key? key, required this.row}) : super(key: key);

  final SFormRow row;


  @override
  State<SFormText> createState() => _SFormTextState();
}

class _SFormTextState extends State<SFormText> {

  final TextEditingController _controller = TextEditingController();

  SFormRow get row => widget.row;
  bool get _enabled => row.enabled;

  TextStyle? get _valueStyle => row.rowConfig?.valueStyle ?? SFormConfig.rowConfig.valueStyle;
  Color? get _disableColor => row.rowConfig?.disableColor ?? SFormConfig.rowConfig.disableColor;
  TextStyle? get _placeholderStyle => row.rowConfig?.placeholderStyle ?? SFormConfig.rowConfig.placeholderStyle;

  @override
  void initState() {
    super.initState();
    _controller.text = row.value;
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
    Widget child =  rowTextField(context);
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


  Widget rowTextField(BuildContext context){
    return CupertinoTextField(
      obscureText: row.obscureText,
      controller: _controller,
      clearButtonMode: _enabled ? row.clearButtonModel ?? OverlayVisibilityMode.never : OverlayVisibilityMode.never,
      enabled: _enabled,
      decoration: const BoxDecoration(color: Colors.transparent),
      textAlign: row.textAlign,
      placeholder: row.placeholder,
      keyboardType: row.keyboardType,
      maxLength: row.maxlength,
      style: !_enabled ? _valueStyle?.copyWith(color: _disableColor) : _valueStyle,
      placeholderStyle: _placeholderStyle,
      readOnly: !_enabled ,
      onChanged: (value) {
        row.value = value;
        if (row.onChange != null){row.onChange!(row);}
      },
      inputFormatters: inputFormatters(),
      scribbleEnabled: false,
      textInputAction: TextInputAction.next,
    );
  }

  List<TextInputFormatter> inputFormatters () {
    List<TextInputFormatter> res = [];
    switch(row.textType){
      case SFormTextType.int:
        res.add(FilteringTextInputFormatter.allow(RegExp('[0-9]')));
        break;
      case SFormTextType.en:
        res.add(FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')));
        break;
      case SFormTextType.double:
        res.add(FilteringTextInputFormatter.allow(RegExp('[0-9.]')));
        break;
      case SFormTextType.zh:
        res.add(FilteringTextInputFormatter.allow(RegExp(r'[\u4e00-\u9fa5]', unicode: true)));
        break;
      default:break;
    }
    return res;
  }
}
