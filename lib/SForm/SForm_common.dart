/// 每一个row的构成结构为
///
///  prefixWidget？ title? requireStar? filed clearButtonModel? suffixWidget?
///
///
///
import "package:flutter/material.dart";
import 'package:sform/SForm/SForm_row.dart';
import 'package:sform/Util/Config.dart';


Widget emptyWidget(){
  return const SizedBox(width: 0, height: 0,);
}

Widget rowTitle(SFormRow row){
  return RichText(
    overflow: TextOverflow.visible,
    text: TextSpan(
      text: row.title,
      style: row.enabled ? SFormConfig.rowConfig.titleStyle:SFormConfig.rowConfig.titleStyle?.copyWith(color: SFormConfig.rowConfig.disableColor) ,
      children: [
        TextSpan(
          text: row.require ? (row.requireStar ? "*" : "") : "",
          style: SFormConfig.rowConfig.titleStyle?.copyWith(color: row.enabled ? Colors.red : SFormConfig.rowConfig.disableColor),
        )
      ],
    )
  );
}

Widget layoutWidgetLR(SFormRow row , Widget field){
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      row.prefixWidget != null?row.prefixWidget!(row) : const SizedBox.shrink(),
      const SizedBox(width: 5,),
      row.title != null ? rowTitle(row) : const SizedBox.shrink(),
      const SizedBox(width: 5,),
      Expanded(
        child: field,
      ),
      const SizedBox(width: 5,),
      row.suffixWidget != null ? row.suffixWidget!(row) : const SizedBox.shrink(),
    ],
  );
}
Widget layoutWidgetRL(SFormRow row , Widget field){
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      row.prefixWidget != null ? row.prefixWidget!(row) : const SizedBox.shrink(),
      const SizedBox(width: 5,),
      Expanded(
        child: field,
      ),
      const SizedBox(width: 5,),
      row.title != null ? rowTitle(row) : const SizedBox.shrink(),
      const SizedBox(width: 5,),
      row.suffixWidget != null ? row.suffixWidget!(row) : const SizedBox.shrink(),
    ],
  );
}
Widget layoutWidgetUD(SFormRow row , Widget field){
  return Column(
    children: [
      const SizedBox(height: 5,),
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          row.prefixWidget != null?row.prefixWidget!(row) : const SizedBox.shrink(),
          const SizedBox(width: 5,),
          row.title != null ? Expanded(child: rowTitle(row)) : const SizedBox.shrink(),
          const SizedBox(width: 5,),
          row.suffixWidget != null ? row.suffixWidget!(row) : const SizedBox.shrink(),
        ],
      ),
      const SizedBox(height: 5,),
      field,
      const SizedBox(height: 5,),
    ],
  );
}
Widget layoutWidgetDU(SFormRow row , Widget field){
  return Column(
    children: [
      const SizedBox(height: 5,),
      field,
      const SizedBox(height: 5,),
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          row.prefixWidget != null?row.prefixWidget!(row) : const SizedBox.shrink(),
          const SizedBox(width: 5,),
          row.title != null ? Expanded(child: rowTitle(row)) : const SizedBox.shrink(),
          const SizedBox(width: 5,),
          row.suffixWidget != null ? row.suffixWidget!(row) : const SizedBox.shrink(),
        ],
      ),
      const SizedBox(height: 5,),
    ],
  );
}


class DataScrollItemView extends StatelessWidget {
  const DataScrollItemView({
    Key? key,
    required this.onChanged,
    required this.datas,
    required this.controller,
    this.options = const DataScrollOptions(),
    this.scrollViewOptions = const ScrollViewDetailOptions(),
    required this.selectedIndex,
  }) : super(key: key);

  /// A controller for scroll views whose items have the same size.
  final FixedExtentScrollController controller;

  /// On optional listener that's called when the centered item changes.
  final ValueChanged<int> onChanged;

  /// This is a list of dates.
  final List datas;

  /// A set that allows you to specify options related to ListWheelScrollView.
  final DataScrollOptions options;

  /// A set that allows you to specify options related to ScrollView.
  final ScrollViewDetailOptions scrollViewOptions;

  /// The currently selected date index.
  final int selectedIndex;

  double _getScrollViewWidth(BuildContext context) {
    String _longestText = '';
    for (var text in datas) {
      if ('$text'.length > _longestText.length) {
        _longestText = '$text'.padLeft(2, '0');
      }
    }
    _longestText += scrollViewOptions.label;
    final TextPainter _painter = TextPainter(
      text: TextSpan(
        style: scrollViewOptions.selectedTextStyle,
        text: _longestText,
      ),
      textDirection: Directionality.of(context),
    );
    _painter.layout();
    return _painter.size.width + 8.0;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        int _maximumCount = constraints.maxHeight ~/ options.itemExtent;
        return Container(
          margin: scrollViewOptions.margin,
          width: _getScrollViewWidth(context),
          child: ListWheelScrollView.useDelegate(
            itemExtent: options.itemExtent,
            diameterRatio: options.diameterRatio,
            controller: controller,
            physics: const FixedExtentScrollPhysics(),
            perspective: options.perspective,
            onSelectedItemChanged: onChanged,
            childDelegate: options.isLoop && datas.length > _maximumCount
                ? ListWheelChildLoopingListDelegate(
              children: List<Widget>.generate(
                datas.length, (index) => _buildDateView(index: index),
              ),
            )
                : ListWheelChildListDelegate(
              children: List<Widget>.generate(
                datas.length, (index) => _buildDateView(index: index),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDateView({required int index}) {
    return Container(
      alignment: scrollViewOptions.alignment,
      child: Text(
        '${datas[index]}${scrollViewOptions.label}',
        style: selectedIndex == index ? scrollViewOptions.selectedTextStyle : scrollViewOptions.textStyle,
      ),
    );
  }
}

class DataScrollOptions {
  const DataScrollOptions({
    this.itemExtent = 30.0,
    this.diameterRatio = 3,
    this.perspective = 0.01,
    this.isLoop = false,
  });

  /// Size of each child in the main axis
  final double itemExtent;

  /// {@macro flutter.rendering.wheelList.diameterRatio}
  final double diameterRatio;

  /// {@macro flutter.rendering.wheelList.perspective}
  final double perspective;

  /// The loop iterates on an explicit list of values
  final bool isLoop;
}
class ScrollViewDetailOptions {
  const ScrollViewDetailOptions({
    this.label = '',
    this.alignment = Alignment.centerLeft,
    this.margin,
    this.selectedTextStyle =
    const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    this.textStyle =
    const TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
  });

  /// The text printed next to the year, month, and day.
  final String label;

  /// The year, month, and day text alignment method.
  final Alignment alignment;

  /// The amount of space that can be added to the year, month, and day.
  final EdgeInsets? margin;

  /// An immutable style describing how to format and paint text.
  final TextStyle textStyle;

  /// An invariant style that specifies the selected text format and explains how to draw it.
  final TextStyle selectedTextStyle;
}
