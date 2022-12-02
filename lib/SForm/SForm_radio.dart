import 'package:sform/SForm/SForm_common.dart';
import 'package:sform/SForm/SForm_row.dart';
import "package:flutter/material.dart";
import 'package:sform/Util/Config.dart';

/// 单选框
///
///



class SFormRadio extends  StatefulWidget {
  const SFormRadio({Key? key, required this.row}) : super(key: key);

  final SFormRow row;


  @override
  State<SFormRadio> createState() => _SFormRadioState();
}

class _SFormRadioState extends State<SFormRadio> {

  SFormRow get row => widget.row;
  bool get _enabled => row.enabled;

  TextStyle? get _valueStyle => row.rowConfig?.valueStyle ?? SFormConfig.rowConfig.valueStyle;
  Color? get _disableColor => row.rowConfig?.disableColor ?? SFormConfig.rowConfig.disableColor;
  TextStyle? get _placeholderStyle => row.rowConfig?.placeholderStyle ?? SFormConfig.rowConfig.placeholderStyle;
  String value = "";

  @override
  void initState() {
    super.initState();
    row.options?.forEach((element) {
      if(element.selected){
        value = element.value.toString();
      }
    });
    if (row.value.isNotEmpty){
      row.options?.forEach((option) {
        option.selected = false;
        if(option.value == int.parse(row.value)){
          option.selected = true;
        }
      });
      value = row.value;
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
          minWidth: 100
        ),
        child: layoutWidget(context),
      ),
    );
  }

  Widget layoutWidget(BuildContext context){
    Widget child = radioList() ;
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


  Widget radioList(){
    List<Widget> children = [];
    List<SFormSelectOption> options = row.options!;
    for ( int i = options.length -1; i >= 0  ; i-- ){
      SFormSelectOption option = options[i];
      children.add(SizedBox(
        width: option.width,
        child: InkWell(
          child: Row(
            children: [
              Radio(
                  value: (option.value).toString(),
                  groupValue: value,
                  onChanged: (String? v){
                    mounted?setState((){
                      value = v!;
                    }):null;
                    row.value = option.value.toString();
                  }
              ),
              SizedBox(
                width: option.width! - 40,
                child: Text(
                  option.title ,
                  style: TextStyle(
                      overflow: TextOverflow.clip
                  ),
                ),
              )
            ],
          ),
          onTap: (){
            mounted?setState((){
              value = option.value.toString();
            }):null;
            row.value = option.value.toString();
          },
        ),
      ));
    }
    switch(row.optionLayout){
      case RowLayout.ud:
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        );
        break;
      case RowLayout.du:
        return Column(
          children: children,
        );
        break;
      case RowLayout.lr:
        return Wrap(
          direction: Axis.horizontal,
          spacing: 5,
          runSpacing: 5,
          children: children,
        );
        break;
      case RowLayout.rl:
        return Wrap(
          direction: Axis.horizontal,
          spacing: 5,
          runSpacing: 5,
          children: children,
        );
        break;
    }
  }
}
