/// form组件主入口
///
///
import 'package:flutter/material.dart';
import 'package:sform/SForm/SForm_method.dart';
import 'package:sform/SForm/SForm_row.dart';
import 'package:sform/Util/Config.dart';


class SForm extends StatefulWidget {
  const SForm({
    Key? key,
    required this.rows,
    this.widgetType = SFormWidgetType.column,
    this.divider = const Divider(height: 1,),
    this.width,
    this.decoration,
    this.rowConfig,
  }) : assert( divider != null , "if widgetType == SFormWidgetType.separated, divider must be null"),
       assert( widgetType != SFormWidgetType.separated , "if widgetType == SFormWidgetType.separated, divider must be null"),
        super(key: key);


  final List<SFormRow> rows;
  final SFormWidgetType widgetType;
  final Divider? divider;
  final double? width;
  final BoxDecoration? decoration;
  final SFormRowConfig? rowConfig;


  const SForm.column({
    Key? key,
    required this.rows,
    this.widgetType = SFormWidgetType.column,
    this.divider = const Divider(height: 1,),
    this.width,
    this.decoration,
    this.rowConfig,
  }) : super(key: key);

  const SForm.sliver({
    Key? key,
    required this.rows,
    this.widgetType = SFormWidgetType.sliver,
    this.divider = const Divider(height: 1,),
    this.width,
    this.decoration,
    this.rowConfig,
  }) : super(key: key);

  const SForm.builder({
    Key? key,
    required this.rows,
    this.widgetType = SFormWidgetType.builder,
    this.divider = const Divider(height: 1,),
    this.width,
    this.decoration,
    this.rowConfig,
  }) : super(key: key);

  const SForm.separated({
    Key? key,
    required this.rows,
    this.widgetType = SFormWidgetType.separated,
    this.width,
    this.decoration,
    this.divider,
    this.rowConfig,
  }) : super(key: key);


  @override
  State<SForm> createState() => SFormState();
}

class SFormState extends State<SForm>{

  get rows => widget.rows;
  get widgetType => widget.widgetType;
  get divider => widget.divider;
  get width => widget.width??0.0;
  get decoration => widget.decoration;
  get rowConfig => widget.rowConfig??SFormConfig.rowConfig;

  @override
  void initState() {
    super.initState();
    SFormConfig.rowLength = rows.length;
    SFormConfig.widgetType = widgetType;
    SFormConfig.width = width;
    SFormConfig.divider = divider;
    SFormConfig.rowConfig = rowConfig;
  }


  /// 验证表单
  List validate() {
    FocusScope.of(context).requestFocus(FocusNode());
    List errors = formValidationErrors(rows);
    return errors;
  }

  Map<String , dynamic> formData(){
    FocusScope.of(context).requestFocus(FocusNode());
    Map<String , dynamic> data = {};
    rows.forEach((SFormRow row) {
      row.name !=null ?data[row.name!] = row.value:null;
    });
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return width < 1.0 ? Container(
      child: widgetTypeWidget,
    ):Container(
      width: width,
      decoration: decoration,
      child: widgetTypeWidget,
    );
  }


  Widget get widgetTypeWidget {
    switch(widgetType){
      case SFormWidgetType.builder:
        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: ListView.builder(
            itemCount: rows.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) => SFormItem(row: rows[index] ),
          ),
        );
        break;
      case SFormWidgetType.sliver:
        return SliverList(
          delegate:
          SliverChildBuilderDelegate((BuildContext context, int index) {
            return GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
              child: SFormItem(row: rows[index] ),
            );
          }, childCount: rows.length)
        );
        break;
      case SFormWidgetType.separated:
        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: ListView.separated(
            itemCount: rows.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index)  => SFormItem(row: rows[index] ),
            separatorBuilder: (BuildContext context, int index) {
              return index % 2 == 0 ?
              Divider(color: Theme.of(context).backgroundColor,):
              Divider(color: Theme.of(context).dividerColor,);
            },
          ),
        );
        break;
      case SFormWidgetType.column:
      default:
        List<Widget> columnChildren = [];
        rows.forEach( (e) {
          columnChildren.add(SFormItem(row: e , divider: divider,));
        });
        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: Column(
            children: columnChildren,
          ),
        );
    }
  }

}
