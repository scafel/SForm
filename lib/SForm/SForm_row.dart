import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sform/SForm/SForm_checkbox.dart';
import 'package:sform/SForm/SForm_date.dart';
import 'package:sform/SForm/SForm_radio.dart';
import 'package:sform/SForm/SForm_select.dart';
import 'package:sform/SForm/SForm_text.dart';
import 'package:sform/SForm/SForm_textarea.dart';
import 'package:sform/SForm/SForm_upload.dart';
import 'package:sform/Util/Config.dart';

/// [ud] 上下布局
/// [du] 下上布局
/// [du]  左右布局
/// [du] 右左布局
enum RowLayout {
  ud,
  du,
  lr,
  rl
}
/// 选项配置
/// [title] 选项展示内容
/// [value] 选项对应的值
/// [disabled] 禁用状态
/// [slot] 自定义模板
/// [selected] 选项选定状态
/// [width] 选项宽度只对radio 和 checkbox 有效
class SFormSelectOption {

  String title;
  dynamic value;
  bool disabled;
  Widget? slot;
  bool selected;
  double? width;

  SFormSelectOption({
    required this.title,
    required this.value ,
    this.disabled = false,
    this.slot,
    this.selected = false,
    this.width = 200
  });
}
/// 弹出层配置
class SFormPickerOption {

  BuildContext? context;
  String confirmTitle;
  String cancelTitle;
  String centerTitle;

  Function? cancelAction;
  Function? confirmAction;

  SFormPickerOption({
    this.context,
    this.confirmTitle = "confirm",
    this.cancelTitle = "cancel",
    this.centerTitle = "",
    this.cancelAction,
    this.confirmAction,
  });
}

class SFormRow{
  /// row的类型
  SFormRowType type = SFormRowType.text;
  /// 唯一字段
  String? name;
  /// 表单项标题
  String? title;
  /// 表单项的值
  String value = "";
  /// 通过 builder 的方式自定义 row
  Widget Function(BuildContext, SFormRow)? widgetBuilder;
  /// 输入框占位
  String placeholder = "";
  /// 是否能编辑
  bool enabled = true;
  /// 是否必填
  bool require = false;
  /// 显示必填的标志
  bool requireStar = false;
  /// 必填项校验不通过提示
  String requireMsg = "";
  /// 自定义校验规则
  bool Function(SFormRow)? validator;
  /// 输入框文字对齐方式
  TextAlign textAlign = TextAlign.right;
  /// 标记插入删除操作是否显示动画
  bool animation = true;
  /// 通过 builder 的方式自定义 suffixWidget
  Widget Function(SFormRow)? suffixWidget;
  /// 通过 builder 的方式自定义 prefixWidget
  Widget Function(SFormRow)? prefixWidget;
  /// value发生变化时触发
  Function(SFormRow)? onChange;
  /// 点击事件  在upload类型中推荐使用异步类型
  Future Function(SFormRow)? onTap;
  /// 清除按钮显示模式
  OverlayVisibilityMode? clearButtonModel;
  /// 样式配置
  SFormRowConfig? rowConfig;
  /// 布局方式
  RowLayout rowLayout;


  //region text 专有属性
  /// 输入框键盘类型
  TextInputType keyboardType = TextInputType.text;
  /// 输入文本类型
  SFormTextType textType = SFormTextType.text;
  /// 输入框输入最大长度限制
  int maxlength = 100;
  /// 最小输入长度
  int minlength = 0;
  /// 输入框内容是否加密
  bool obscureText = false;
  //endregion

  SFormRow.Text({
    this.type = SFormRowType.text,
    this.name,
    this.title,
    this.value = "",
    this.widgetBuilder,
    this.placeholder = "",
    this.enabled = true,
    this.require = false,
    this.requireStar = false,
    this.requireMsg = "",
    this.validator,
    this.textAlign = TextAlign.left,
    this.animation = true,
    this.suffixWidget,
    this.prefixWidget,
    this.onChange,
    this.clearButtonModel = OverlayVisibilityMode.editing,
    this.rowConfig,
    this.keyboardType = TextInputType.text,
    this.textType = SFormTextType.text,
    this.maxlength = 100,
    this.minlength = 0,
    this.obscureText = false,
    this.rowLayout = RowLayout.lr
  });

  SFormRow.TextArea({
    this.type = SFormRowType.textarea,
    this.name,
    this.title,
    this.value = "",
    this.widgetBuilder,
    this.placeholder = "",
    this.enabled = true,
    this.require = false,
    this.requireStar = false,
    this.requireMsg = "",
    this.validator,
    this.textAlign = TextAlign.left,
    this.animation = true,
    this.suffixWidget,
    this.prefixWidget,
    this.onChange,
    this.clearButtonModel = OverlayVisibilityMode.editing,
    this.rowConfig,
    this.maxlength = 100,
    this.minlength = 0,
    this.rowLayout = RowLayout.lr
  });
  /// 有弹窗的属性
  SFormPickerOption? pickerOption ;

  //region select 专有属性
  /// 选项列表
  List<SFormSelectOption>? options ;
  /// 是否多选
  bool? multiple;
  /// multiple 属性设置为 true 时，代表多选场景下用户最多可以选择的项目数， 为 0 则不限制
  int? multipleLimit;
  /// Select 组件是否可筛选
  bool? filterable;
  /// 自定义筛选方法
  Function(SFormRow)? filterMethod;
  /// 其中的选项是否从服务器远程加载
  bool? remote;
  /// 自定义远程搜索方法
  Function(SFormRow)? remoteMethod;
  /// 显示选择框样式
  SFormSelectOpenType? openType;
  //endregion


  SFormRow.Select({
    this.type = SFormRowType.select,
    this.name,
    this.title,
    this.value = "",
    this.widgetBuilder,
    this.placeholder = "",
    this.enabled = true,
    this.require = false,
    this.requireStar = false,
    this.requireMsg = "",
    this.validator,
    this.textAlign = TextAlign.left,
    this.animation = true,
    this.suffixWidget,
    this.prefixWidget,
    this.onChange,
    this.clearButtonModel = OverlayVisibilityMode.editing,
    this.rowConfig,
    required this.options,
    this.multiple = false,
    this.multipleLimit = 3,
    this.filterable = false,
    this.filterMethod,
    this.remote,
    this.remoteMethod,
    this.openType = SFormSelectOpenType.normal,
    this.pickerOption,
    this.rowLayout = RowLayout.lr
  });

  /// 选项排列方式
  ///
  RowLayout optionLayout = RowLayout.lr;

  SFormRow.Radio({
    this.type = SFormRowType.radio,
    this.name,
    this.title,
    this.value = "",
    this.widgetBuilder,
    this.enabled = true,
    this.require = false,
    this.requireStar = false,
    this.requireMsg = "",
    this.validator,
    this.textAlign = TextAlign.left,
    this.animation = true,
    this.suffixWidget,
    this.prefixWidget,
    this.onChange,
    this.rowConfig,
    required this.options,
    this.optionLayout = RowLayout.rl,
    this.rowLayout = RowLayout.ud
  });


  SFormRow.CheckBox({
    this.type = SFormRowType.checkbox,
    this.name,
    this.title,
    this.value = "",
    this.widgetBuilder,
    this.enabled = true,
    this.require = false,
    this.requireStar = false,
    this.requireMsg = "",
    this.validator,
    this.textAlign = TextAlign.left,
    this.animation = true,
    this.suffixWidget,
    this.prefixWidget,
    this.onChange,
    this.rowConfig,
    required this.options,
    this.multiple = false,
    this.multipleLimit = 3,
    this.rowLayout = RowLayout.lr
  });

  //region date 专有属性
  /// 时间显示类型
  SFormDateType dateType = SFormDateType.date;
  /// 显示在文本框中的格式
  /// d : Day of month (01 - 31)
  // j : Day of month, without leading 0s (1 - 31)
  // D : An abbreviated textual representation of a day (Mon - Sun)
  // l : A textual representation of a day (Monday - Sunday)
  // S : Suffix of a day (st, th, nd)
  // z : The day of the year (starting from 0)
  // F : A textual representation of a month (January - December)
  // M : An abbreviated textual representation of a month (Jan - Dec)
  // m : Numeric representation of a month (01 - 12)
  // n : Numeric representation of a month, without leading 0s (1 - 12)
  // Y : Full numeric representation of a year (e.g. 2019)
  // y : A two digit representation of a year (e.g. 19)
  // a : Ante meridiem and post meridiem, lowercase (am or pm)
  // A : Ante meridiem and post meridiem, uppercase (AM or PM)
  // g : 12-hour format of an hour, without leading 0s (1 - 12)
  // h : 12-hour format of an hour (01 - 12)
  // G : 24-hour format of an hour, without leading 0s (0 - 23)
  // H : 24-hour format of an hour (00 - 23)
  // i : Minutes (0 - 59)
  // s : Seconds (0 - 59)
  // v : Milliseconds (0 - 999)
  // u : Microseconds (0 - 999)
  // e : Timezone identifier (Returns [DateTime.timeZoneName], which is provided by the operating system and may be a name or abbreviation.)
  // O : Difference to Greenwich Time (GMT) in hours (±0000)
  // P : Difference to Greenwich Time (GMT) in hours with a colon (±00:00)
  // T : Timezone abbreviation (Identifies the Timezone from [DateTime.timeZoneName].)
  // c : ISO 8601 date (e.g. 2019-10-15T19:42:05-08:00)
  // r : RFC 2822 date (Tue, 15 Oct 2019 17:42:05 -0800)
  // U : Seconds since Unix Epoch
  // \ : Escape character
  String dateFormat = "YYYY-MM-DD";
  /// 选择范围时的分隔符
  String dateRangeSeparator = "-";
  /// 开始时间 默认1997
  DateTime? startDate;
  /// 结束时间  默认当前时间
  DateTime? endDate;
  /// 实际数据的格式
  /// 具体同[dateFormat]
  String valueFormat = "X";
  //endregion

  SFormRow.Date({
    this.type = SFormRowType.date,
    this.name,
    this.title,
    this.value = "",
    this.widgetBuilder,
    this.placeholder = "",
    this.enabled = true,
    this.require = false,
    this.requireStar = false,
    this.requireMsg = "",
    this.validator,
    this.textAlign = TextAlign.left,
    this.animation = true,
    this.suffixWidget,
    this.prefixWidget,
    this.onChange,
    this.clearButtonModel,
    this.rowConfig,
    this.dateType = SFormDateType.date,
    this.dateFormat = "Y-m-d",
    this.dateRangeSeparator = "-",
    this.valueFormat = "U",
    this.startDate,
    this.endDate,
    this.pickerOption,
    this.rowLayout = RowLayout.lr
  });

  SFormUploadType? uploadType = SFormUploadType.file;

  SFormRow.Upload({
    this.type = SFormRowType.upload,
    this.name,
    this.title,
    this.value = "",
    this.widgetBuilder,
    this.placeholder = "",
    this.require = false,
    this.requireStar = false,
    this.requireMsg = "",
    this.validator,
    this.animation = true,
    this.suffixWidget,
    this.prefixWidget,
    this.onChange,
    this.onTap,
    this.rowConfig,
    this.multiple = true,
    this.multipleLimit = 3,
    this.uploadType = SFormUploadType.file,
    this.rowLayout = RowLayout.lr
  });

  SFormRow.ExtendField({
    this.type = SFormRowType.extendField,
    this.name,
    this.title,
    this.value = "",
    this.widgetBuilder,
    this.placeholder = "",
    this.enabled = true,
    this.require = false,
    this.requireStar = false,
    this.requireMsg = "",
    this.validator,
    this.suffixWidget,
    this.prefixWidget,
    this.onChange,
    this.onTap,
    this.rowLayout = RowLayout.lr
  });
}

class SFormItem extends StatelessWidget {
  const SFormItem({Key? key, required this.row, this.divider}) : super(key: key);

  final SFormRow row;
  final Divider? divider;


  @override
  Widget build(BuildContext context) {
    // row
    Widget widget;
    if (row.widgetBuilder != null) {
      widget = row.widgetBuilder!(context, row);
    } else {
      switch(row.type){
        case SFormRowType.radio:
          widget = SFormRadio(row: row);
          break;
        case SFormRowType.checkbox:
          widget = SFormCheckBox(row: row);
          break;
        case SFormRowType.select:
          widget = SFormSelect(row: row);
          break;
        case SFormRowType.date:
          widget = SFormDate(row: row);
          break;
        case SFormRowType.cascader:
          widget = SFormRadio(row: row);
          break;
        case SFormRowType.upload:
          widget = SFormUpload(row: row);
          break;
        case SFormRowType.textarea:
          widget = SFormTextArea(row: row);
          break;
        case SFormRowType.extendField:
          widget = SFormTextArea(row: row);
          break;
        case SFormRowType.text:
        default :
          widget = SFormText(row: row);
          break;
      }
    }

    // animation
    widget = row.animation ? TweenAnimationBuilder(
      duration: const Duration(milliseconds: 500),
      builder: (BuildContext context, double value, Widget? child) {
        return Opacity(opacity: value, child: child,);
      },
      tween: Tween(begin: 0.0, end: 1.0),
      child: widget,
    ) : widget;
    // divider
    widget = SFormConfig.widgetType != SFormWidgetType.separated? Column(
      children: [widget, SFormConfig.divider],
    ) : widget;
    return widget;
  }
}
