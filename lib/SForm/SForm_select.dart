import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sform/Util/Config.dart';
import 'package:sform/SForm/SForm_common.dart';
import 'package:sform/SForm/SForm_row.dart';

/// 选项打开的样式
enum SFormSelectOpenType {
  normal,
  picker,
  page
}

class SFormSelect extends StatefulWidget {
  const SFormSelect({Key? key, required this.row}) : super(key: key);

  final SFormRow row;

  @override
  State<SFormSelect> createState() => _SFormSelectState();
}

class _SFormSelectState extends State<SFormSelect> {
  final TextEditingController _controller = TextEditingController();

  SFormRow get row => widget.row;
  bool get _enabled => row.enabled;
  bool get _filterable => row.filterable??false;

  TextStyle? get _valueStyle => row.rowConfig?.valueStyle ?? SFormConfig.rowConfig.valueStyle;
  Color? get _disableColor => row.rowConfig?.disableColor ?? SFormConfig.rowConfig.disableColor;
  TextStyle? get _placeholderStyle => row.rowConfig?.placeholderStyle ?? SFormConfig.rowConfig.placeholderStyle;
  String value = "";

  @override
  void initState() {
    super.initState();
    row.options?.forEach((element) {
      if(element.selected){
        value = value.isEmpty? element.title : "$value,${element.title}";
      }
    });
    if (row.value.isNotEmpty){
      value = row.value;
    }
    _controller.text = value;
    _controller.addListener(() {

    });
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
      readOnly: ( !_enabled || !_filterable),
      onChanged: (value) {
        row.value = value;
        if(row.value.isEmpty){
          for (SFormSelectOption element in row.options!) {
            element.selected = false;
          }
        }
        row.onChange != null?row.onChange!(row):null;
      },
      onTap: () {
        switch(row.openType){
          case SFormSelectOpenType.normal:
            openNormalSelectWidget();
            break;
          case SFormSelectOpenType.page:
            openPageSelectWidget();
            break;
          case SFormSelectOpenType.picker:
            openPickerSelectWidget();
            break;
          default:
            throw "can not find openType";
        }
      },
    );
  }

  void openNormalSelectWidget(){
    showGeneralDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(.5),
      barrierDismissible: true,
      barrierLabel: '',
      transitionDuration: const Duration(milliseconds: 200),
      transitionBuilder: (BuildContext context,Animation<double> animation,Animation<double> secondaryAnimation,Widget child) {
        return ScaleTransition(scale: animation, child: child);
      },
      pageBuilder: ( context,  animation, secondaryAnimation) {
        return StatefulBuilder(
            builder:(BuildContext context, void Function(void Function()) dialogSetState) {
              return Center(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadiusDirectional.all(Radius.circular(5)),
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: row.multiple! ?((MediaQuery.of(context).size.height * 0.5) - 70) : ((MediaQuery.of(context).size.height * 0.5) - 20),
                        margin: const EdgeInsets.fromLTRB(10 , 5, 10, 5),
                        child: ListView.builder(
                          itemCount: row.options?.length,
                          itemBuilder: (context , index){
                            SFormSelectOption option = row.options![index];
                            return GestureDetector(
                              onTap: () => itemSelect(option, dialogSetState),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 50,
                                    child:Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Expanded(child: Text(option.title , style: const TextStyle(
                                            decoration: TextDecoration.none,
                                            fontSize: 20,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400
                                        ),),),
                                        option.selected ? const Icon(Icons.done) : const SizedBox.shrink(),
                                      ],
                                    ),
                                  ),
                                  const Divider(height: 0.5,),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      row.multiple! ?SizedBox(
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(onPressed: () => cancelClick(dialogSetState), child: Text(row.pickerOption?.cancelTitle ?? "cancel")),
                            Expanded(child: Text(row.pickerOption?.centerTitle ?? "")),
                            TextButton(onPressed: () => confirmClick(dialogSetState), child: Text(row.pickerOption?.confirmTitle ?? "confirm")),
                          ],
                        ),
                      ) : const SizedBox.shrink(),
                    ],
                  ),
                ),
              );
            }
        );
      }
    );
  }

  void openPageSelectWidget(){
    showCupertinoModalPopup(
      context: context,
      barrierDismissible: !row.multiple!,
      builder: (BuildContext context){
      return StatefulBuilder(
          builder:(BuildContext context, void Function(void Function()) dialogSetState) {
            return Center(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadiusDirectional.all(Radius.circular(5)),
                ),
                child: Column(
                  children: [
                    row.multiple! ?SizedBox(
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(onPressed: () => cancelClick(dialogSetState), child: Text(row.pickerOption?.cancelTitle ?? "cancel")),
                          Expanded(child: Text(row.pickerOption?.centerTitle ?? "")),
                          TextButton(onPressed: () => confirmClick(dialogSetState), child: Text(row.pickerOption?.confirmTitle ?? "confirm")),
                        ],
                      ),
                    ) : const SizedBox.shrink(),
                    Container(
                      height: row.multiple! ?(MediaQuery.of(context).size.height - 70) : (MediaQuery.of(context).size.height - 20),
                      margin: const EdgeInsets.fromLTRB(10 , 5, 10, 5),
                      child: ListView.builder(
                        itemCount: row.options?.length,
                        itemBuilder: (context , index){
                          SFormSelectOption option = row.options![index];
                          return GestureDetector(
                            onTap: () => itemSelect(option, dialogSetState),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 50,
                                  child:Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Expanded(child: Text(option.title , style: const TextStyle(
                                          decoration: TextDecoration.none,
                                          fontSize: 20,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400
                                      ),),),
                                      option.selected ? const Icon(Icons.done) : const SizedBox.shrink(),
                                    ],
                                  ),
                                ),
                                const Divider(height: 0.5,),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
      );
    },
    );
  }

  void openPickerSelectWidget(){
    showModalBottomSheet(
      context: context,
      isDismissible: !row.multiple!,
      enableDrag: !row.multiple!,
      builder: (BuildContext context){
        return StatefulBuilder(
          builder:(BuildContext context, void Function(void Function()) dialogSetState) {
            return Center(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.5,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10) , topRight: Radius.circular(10)),
                ),
                child: Column(
                  children: [
                    row.multiple! ?SizedBox(
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(onPressed: () => cancelClick(dialogSetState), child: Text(row.pickerOption?.cancelTitle ?? "cancel")),
                          Expanded(child: Text(row.pickerOption?.centerTitle ?? "")),
                          TextButton(onPressed: () => confirmClick(dialogSetState), child: Text(row.pickerOption?.confirmTitle ?? "confirm")),
                        ],
                      ),
                    ) : const SizedBox.shrink(),
                    Container(
                      height: row.multiple! ?((MediaQuery.of(context).size.height * 0.5) - 70) : ((MediaQuery.of(context).size.height * 0.5) - 20),
                      margin: const EdgeInsets.fromLTRB(10 , 5, 10, 5),
                      child: ListView.builder(
                        itemCount: row.options?.length,
                        itemBuilder: (context , index){
                          SFormSelectOption option = row.options![index];
                          return GestureDetector(
                            onTap: () => itemSelect(option, dialogSetState),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 50,
                                  child:Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Expanded(child: Text(option.title , style: const TextStyle(
                                          decoration: TextDecoration.none,
                                          fontSize: 20,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400
                                      ),),),
                                      option.selected ? const Icon(Icons.done) : const SizedBox.shrink(),
                                    ],
                                  ),
                                ),
                                const Divider(height: 0.5,),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
      );
      },
    );
  }


  void itemSelect(SFormSelectOption option , void Function(void Function()) dialogSetState){
    if(row.multiple!){
      if(row.multipleLimit != null){
        int number = 0;
        for (SFormSelectOption element in row.options!) {
          if(element.value != option.value){
            element.selected ? number++:null;
          }
        }
        if(row.multipleLimit! <= number ){
          return ;
        }
      }
      print(option.selected);
      mounted?dialogSetState((){
        for (SFormSelectOption element in row.options!) {
          element.value == option.value ? element.selected = !option.selected:null;
        }
      }):null;
    }else{
      mounted?dialogSetState((){
        for (SFormSelectOption element in row.options!) {
          element.value == option.value ? element.selected = true :element.selected = false;
        }
        row.value = option.value.toString();
        _controller.text = option.title;
      }):null;
      row.onChange != null?row.onChange!(row):null;
      Navigator.of(context).pop();
    }
  }

  void cancelClick(void Function(void Function()) dialogSetState){
    if(row.multiple!){
      List<String> listValue = row.value.split(",");
      mounted?dialogSetState((){
        for (SFormSelectOption element in row.options!) {
          String valueStr = (element.value).toString();
          listValue.contains(valueStr)?element.selected = true:element.selected = false;
        }
      }):null;
    }
    row.onChange != null?row.onChange!(row):null;
    Navigator.of(context).pop();
  }

  void confirmClick(void Function(void Function()) dialogSetState){
    List<String> titles = [];
    List<dynamic> values = [];
    for (SFormSelectOption element in row.options!) {
      if(element.selected ){
        titles.add(element.title);
        values.add(element.value);
      }
    }
    row.value = values.toString().substring(1 , values.toString().length -1);
    _controller.text = titles.toString().substring(1 , titles.toString().length -1);
    row.onChange != null?row.onChange!(row):null;
    Navigator.of(context).pop();
  }
}
