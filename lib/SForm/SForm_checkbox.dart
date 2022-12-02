import 'package:sform/SForm/SForm_common.dart';
import 'package:sform/SForm/SForm_row.dart';
import "package:flutter/material.dart";
import 'package:sform/Util/Config.dart';

/// 复选框
///
///


class SFormCheckBox extends StatefulWidget {
  const SFormCheckBox({Key? key, required this.row}) : super(key: key);

  final SFormRow row;

  @override
  State<SFormCheckBox> createState() => _SFormCheckBoxState();
}

class _SFormCheckBoxState extends State<SFormCheckBox> {

  SFormRow get row => widget.row;
  bool get _enabled => row.enabled;

  Color? get _disableColor => row.rowConfig?.disableColor ?? SFormConfig.rowConfig.disableColor;
  List<String> values = [];

  @override
  void initState() {
    super.initState();
    row.options?.forEach((element) {
      if(element.selected){
        values.add(element.value.toString());
      }
    });
    if (row.value.isNotEmpty){
      values.clear();
      row.value.split(",").forEach((element) {
        row.options?.forEach((option) {
          option.selected = false;
          if(option.value == int.parse(element) && option.disabled == false){
            option.selected = true;
          }
        });
        values.add(element);
      });
    }
    row.value = values.toString().replaceAll("[", "").replaceAll("]", "");
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
    Widget child = checkBoxList() ;
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

  Widget checkBoxList(){
    List<Widget> children = [];
    List<SFormSelectOption> options = row.options!;
    for ( int i = options.length -1; i >= 0  ; i-- ){
      SFormSelectOption option = options[i];
      children.add(SizedBox(
        width: option.width,
        child: InkWell(
          child: Row(
            children: [
              Checkbox(
                value: option.disabled ?  false : values.indexOf(option.value.toString()) != -1,
                onChanged: (bool? checked) {
                  if( !option.disabled ){
                    mounted?setState((){
                      values.indexOf(option.value.toString()) != -1 ? values.remove(option.value.toString()) : values.add(option.value.toString());
                      row.value = values.toString().replaceAll("[", "").replaceAll("]", "");
                    }):null;
                  }
                },
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
            if(!option.disabled){
              mounted?setState((){
                values.indexOf(option.value.toString()) != -1 ? values.remove(option.value.toString()) : values.add(option.value.toString());
                row.value = values.toString().replaceAll("[", "").replaceAll("]", "");
              }):null;
            }
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
