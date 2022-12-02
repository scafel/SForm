import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sform/SForm/SForm_common.dart';
import 'package:sform/SForm/SForm_row.dart';
import 'package:sform/Util/Config.dart';

/// 多行文本输入框
///
///
///
class SFormTextArea extends StatefulWidget {
  const SFormTextArea({Key? key, required this.row}) : super(key: key);

  final SFormRow row;


  @override
  State<SFormTextArea> createState() => _SFormTextAreaState();
}

class _SFormTextAreaState extends State<SFormTextArea> {

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
        padding: EdgeInsets.fromLTRB(0 , 5, 0, 5),
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
      controller: _controller,
      clearButtonMode: _enabled ? row.clearButtonModel ?? OverlayVisibilityMode.never : OverlayVisibilityMode.never,
      enabled: _enabled,
      decoration: const BoxDecoration(color: Colors.transparent),
      textAlign: row.textAlign,
      placeholder: row.placeholder,
      keyboardType:TextInputType.multiline,
      maxLines: 4,
      minLines: 1,
      maxLength: row.maxlength,
      style: !_enabled ? _valueStyle?.copyWith(color: _disableColor) : _valueStyle,
      placeholderStyle: _placeholderStyle,
      readOnly: !_enabled ,
      onChanged: (value) {
        row.value = value;
        if (row.onChange != null){row.onChange!(row);}
      },
      textInputAction: TextInputAction.next,
    );
  }
}
