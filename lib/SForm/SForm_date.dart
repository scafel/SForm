import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sform/Util/Config.dart';
import 'package:sform/sform.dart';

/// 时间选择器
///
///
/// 时间显示类型
enum SFormDateType {
  year,
  month,
  date,
  dates,
  datetime,
  week,
  datetimerange,
  daterange,
  monthrange,
}

const List<String> DefaultMonths = [
  '1',
  '2',
  '3',
  '4',
  '5',
  '6',
  '7',
  '8',
  '9',
  '10',
  '11',
  '12',
];
const List<String> Default24Hours = [
  '0',
  '1',
  '2',
  '3',
  '4',
  '5',
  '6',
  '7',
  '8',
  '9',
  '10',
  '11',
  '12',
  '13',
  '14',
  '15',
  '16',
  '17',
  '18',
  '19',
  '20',
  '21',
  '22',
  '23',
];
const List<String> Default12Hours = [
  '1',
  '2',
  '3',
  '4',
  '5',
  '6',
  '7',
  '8',
  '9',
  '10',
  '11',
  '12',
];
const List<String> DefaultMinutes = [
  "0",
  "1",
  "2",
  "3",
  "4",
  "5",
  "6",
  "7",
  "8",
  "9",
  "10",
  "11",
  "12",
  "13",
  "14",
  "15",
  "16",
  "17",
  "18",
  "19",
  "20",
  "21",
  "22",
  "23",
  "24",
  "25",
  "26",
  "27",
  "28",
  "29",
  "30",
  "31",
  "32",
  "33",
  "34",
  "35",
  "36",
  "37",
  "38",
  "39",
  "40",
  "41",
  "42",
  "43",
  "44",
  "45",
  "46",
  "47",
  "48",
  "49",
  "50",
  "51",
  "52",
  "53",
  "54",
  "55",
  "56",
  "57",
  "58",
  "59"
];
const List<String> DefaultSeconds = [
  "0",
  "1",
  "2",
  "3",
  "4",
  "5",
  "6",
  "7",
  "8",
  "9",
  "10",
  "11",
  "12",
  "13",
  "14",
  "15",
  "16",
  "17",
  "18",
  "19",
  "20",
  "21",
  "22",
  "23",
  "24",
  "25",
  "26",
  "27",
  "28",
  "29",
  "30",
  "31",
  "32",
  "33",
  "34",
  "35",
  "36",
  "37",
  "38",
  "39",
  "40",
  "41",
  "42",
  "43",
  "44",
  "45",
  "46",
  "47",
  "48",
  "49",
  "50",
  "51",
  "52",
  "53",
  "54",
  "55",
  "56",
  "57",
  "58",
  "59"
];


class SFormDate extends StatefulWidget {
  const SFormDate({Key? key, required this.row}) : super(key: key);
  final SFormRow row;

  @override
  State<SFormDate> createState() => _SFormDateState();
}

class _SFormDateState extends State<SFormDate> {
  final TextEditingController _controller = TextEditingController();

  SFormRow get row => widget.row;
  bool get _enabled => row.enabled;

  TextStyle? get _valueStyle => row.rowConfig?.valueStyle ?? SFormConfig.rowConfig.valueStyle;
  Color? get _disableColor => row.rowConfig?.disableColor ?? SFormConfig.rowConfig.disableColor;
  TextStyle? get _placeholderStyle => row.rowConfig?.placeholderStyle ?? SFormConfig.rowConfig.placeholderStyle;
  String oldValue = "";
  String value = "";
  int _year = 0;
  int _month = 1;
  int _week = 1;
  int _day = 1;
  int _hour = 0;
  int _minute = 0;
  int _second = 0;
  int _year_2 = 0;
  int _month_2 = 1;
  int _day_2 = 1;
  int _hour_2 = 0;
  int _minute_2 = 0;
  int _second_2 = 0;
  List<String> years = [];
  List<String> months = [];
  List<String> days = [];
  List<String> years_2 = [];
  List<String> months_2 = [];
  List<String> days_2 = [];
  List<String> weeks = [];



  @override
  void initState() {
    super.initState();
    oldValue = row.value;
    row.options?.forEach((element) {
      if(element.selected){
        row.value = row.value.isEmpty ? element.value.toString() : "${row.value},${element.value}" ;
        value = value.isEmpty? element.title : "$value,${element.title}";
      }
    });
    _controller.text = value;
    _controller.addListener(() {

    });
    DateTime nowDate = DateTime.now();
    _year = nowDate.year;
    _month = nowDate.month;
    _day = nowDate.day;
    years = getYears();
    months = getMonths(_year);
    days = getDays(_year , _month);
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
      readOnly: true,
      onChanged: (value) {
        row.value = value;
        row.onChange != null?row.onChange!(row):null;
      },
      onTap: () {
        switch(row.dateType){
          case SFormDateType.date:
          case SFormDateType.datetime:
          case SFormDateType.year:
          case SFormDateType.month:
          case SFormDateType.week:
            openSignalDateWidget();
            break;
          case SFormDateType.daterange:
          case SFormDateType.datetimerange:
          case SFormDateType.monthrange:
            openDoubleDateWidget();
            break;
          case SFormDateType.dates:
            openMultipleDateWidget();
            break;
          default:
            throw "can not find dateType";
        }
      },
    );
  }

  List<DateTime> selectDateRange(){
    List<DateTime> dateRange = [];
    row.startDate != null ?dateRange.insert(0, row.startDate!):dateRange.insert(0, DateTime(0));
    row.endDate != null ? dateRange.insert(1, row.endDate!):dateRange.insert(1, DateTime(DateTime.now().year + 100));
    if(dateRange[0].isBefore(dateRange[1])){
      return dateRange;
    }else{
      return dateRange.reversed.toList();
    }
  }

  List<String> getYears({int startYears = -1}) {
    List<DateTime> dateRange = selectDateRange();
    int startYear = startYears == -1?dateRange[0].year:startYears;
    int endYear = dateRange[1].year;
    List<String> years = [];
    for( startYear ;startYear <= endYear ; startYear++ ){
      years.add(startYear.toString());
    }
    return years;
  }
  List<String> getMonths(int year , [int month = -1 , bool end = false]) {
    List<DateTime> dateRange = selectDateRange();
    int startYear = dateRange[0].year;
    int endYear = dateRange[1].year;
    int startMonth = dateRange[0].month;
    if(month> 0){
      if(month == 12 && end == true){
        startYear++;
      }else{
        startMonth = month;
      }
    }
    int endMonth = dateRange[1].month;
    if(year == startYear && year == endYear){
      return [for (int i= startMonth ; i <= endMonth ; i++) i.toString() ];
    }
    if(year == startYear){
      return [for (int i= startMonth ; i <= 12 ; i++) i.toString() ];
    }
    if(year == endYear){
      return [for (int i= 1 ; i <= endMonth ; i++) i.toString() ];
    }
    return DefaultMonths;
  }
  List<String> getDays(int year , int month , [int day = -1 , bool end = false]) {
    List<DateTime> dateRange = selectDateRange();
    int startYear = dateRange[0].year;
    int endYear = dateRange[1].year;
    int startMonth = dateRange[0].month;
    int endMonth = dateRange[1].month;
    int startDay = dateRange[0].day;
    int _monthDay = getMonthlyDate(year: year, month: month);
    if(day > 0){
      if(day == _monthDay && end == true){
        if(month == 12){
          startYear++;
          startMonth = 1;
        }else{
          startMonth = month + 1;
        }
        startDay = 1;
      }else{
        startDay = day;
      }
    }
    int endDay = dateRange[1].day;
    int days = getMonthlyDate(year: year , month:  month);
    if(year == startYear && year == endYear){
      if(month == startMonth && month == endMonth){
        return [for (int i= startDay ; i <= endDay ; i++) i.toString() ];
      }
      if(month == startMonth){
        return [for (int i= startDay ; i <= days ; i++) i.toString() ];
      }
      if(month == startMonth && month == endMonth){
        return [for (int i= startDay ; i <= endDay ; i++) i.toString() ];
      }
    }
    if(year == startYear && month == startMonth){
      return [for (int i= startDay ; i <= days ; i++) i.toString() ];
    }
    if(year == endYear && month == endMonth){
      return [for (int i= 1 ; i <= endDay ; i++) i.toString() ];
    }
    return [for (int i= 1 ; i <= days ; i++) i.toString() ];
  }

  openSignalDateWidget (){
    showModalBottomSheet(
      context: context,
      isDismissible: true,
      enableDrag: false,
      builder: (BuildContext context){
        double height = MediaQuery.of(context).size.height * 0.5 > 200 ? 200: MediaQuery.of(context).size.height * 0.5;
        return SizedBox(
          height: height,
          child: StatefulBuilder(
            builder:(BuildContext context, void Function(void Function()) dialogSetState) {
              return Center(
                child: Container(
                  height: height,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10) , topRight: Radius.circular(10)),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(onPressed: () => cancelClick(dialogSetState), child: Text(row.pickerOption?.cancelTitle ?? "cancel")),
                            Expanded(child: Text(row.pickerOption?.centerTitle ?? "")),
                            TextButton(onPressed: () => confirmClick(dialogSetState), child: Text(row.pickerOption?.confirmTitle ?? "confirm")),
                          ],
                        ),
                      ),
                      Container(
                        height: height - 70,
                        margin: const EdgeInsets.fromLTRB(10 , 5, 10, 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: getRowItems(dialogSetState),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          ),
        );
      },
    );
  }
  openDoubleDateWidget (){
    showModalBottomSheet(
      context: context,
      isDismissible: true,
      enableDrag: false,
      builder: (BuildContext context){
        double height = MediaQuery.of(context).size.height * 0.5 > 200 ? 200: MediaQuery.of(context).size.height * 0.5;
        return SizedBox(
          height: height,
          child: StatefulBuilder(
              builder:(BuildContext context, void Function(void Function()) dialogSetState) {
                return Center(
                  child: Container(
                    height: height,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(10) , topRight: Radius.circular(10)),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(onPressed: () => cancelClick(dialogSetState), child: Text(row.pickerOption?.cancelTitle ?? "cancel")),
                              Expanded(child: Text(row.pickerOption?.centerTitle ?? "")),
                              TextButton(onPressed: () => confirmClick(dialogSetState), child: Text(row.pickerOption?.confirmTitle ?? "confirm")),
                            ],
                          ),
                        ),
                        Container(
                          height: height - 70,
                          margin: const EdgeInsets.fromLTRB(10 , 5, 10, 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: getRowItems(dialogSetState),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
          ),
        );
      },
    );
  }
  openMultipleDateWidget (){}

  List<Widget> getRowItems(void Function(void Function()) dialogSetState) {
    List<Widget> children = [];
    switch(row.dateType){
      case SFormDateType.year:
        children.add(Expanded(
            child:DataScrollView(
              dataIndex: years.indexOf(_year.toString())==-1?0:years.indexOf(_year.toString()),
              datas: years,
              onDateTimeChanged: (int value) {
                mounted?dialogSetState((){
                  _year = int.parse(years[value]);
                }):null;
              },

            )
        ));
        break;
      case SFormDateType.month:
        children.add(Expanded(
            child:DataScrollView(
              dataIndex: years.indexOf(_year.toString())==-1?0:years.indexOf(_year.toString()),
              datas: years,
              onDateTimeChanged: (int value) {
                mounted?dialogSetState((){
                  _year = int.parse(years[value]);
                  months = getMonths(_year);
                }):null;
              },

            )
        ));
        children.add(Expanded(
            child:DataScrollView(
              dataIndex: months.indexOf(_month.toString())==-1?0:months.indexOf(_month.toString()),
              datas: months,
              onDateTimeChanged: (int value) {
                mounted?dialogSetState((){
                  _month = int.parse(months[value]);
                }):null;
              },
            )
        ));
        break;
      case SFormDateType.date:
        children.add(Expanded(
            child:DataScrollView(
              dataIndex: years.indexOf(_year.toString())==-1?0:years.indexOf(_year.toString()),
              datas: years,
              onDateTimeChanged: (int value) {
                mounted?dialogSetState((){
                  _year = int.parse(years[value]);
                  months = getMonths(_year);
                  days = getDays(_year, _month);
                }):null;
              },

            )
        ));
        children.add(Expanded(
            child:DataScrollView(
              dataIndex: months.indexOf(_month.toString())==-1?0:months.indexOf(_month.toString()),
              datas: this.months,
              onDateTimeChanged: (int value) {
                mounted?dialogSetState((){
                  _month = int.parse(months[value]);
                  days = getDays(_year, _month);
                }):null;
              },
            )
        ));
        children.add(Expanded(
            child:DataScrollView(
              dataIndex: days.indexOf(_day.toString())==-1?0:days.indexOf(_day.toString()),
              datas: days,
              onDateTimeChanged: (int value) {
                mounted?dialogSetState((){
                  _day = int.parse(days[value]);
                }):null;
              },

            )
        ));
        break;
      case SFormDateType.dates:

        break;
      case SFormDateType.datetime:
        children.add(Expanded(
            child:DataScrollView(
              dataIndex: years.indexOf(_year.toString())==-1?0:years.indexOf(_year.toString()),
              datas: years,
              onDateTimeChanged: (int value) {
                mounted?dialogSetState((){
                  _year = int.parse(years[value]);
                  months = getMonths(_year);
                  days = getDays(_year, _month);
                }):null;
              },

            )
        ));
        children.add(Expanded(
            child:DataScrollView(
              dataIndex: months.indexOf(_month.toString())==-1?0:months.indexOf(_month.toString()),
              datas: this.months,
              onDateTimeChanged: (int value) {
                mounted?dialogSetState((){
                  _month = int.parse(months[value]);
                  days = getDays(_year, _month);
                }):null;
              },
            )
        ));
        children.add(Expanded(
            child:DataScrollView(
              dataIndex: days.indexOf(_day.toString())==-1?0:days.indexOf(_day.toString()),
              datas: days,
              onDateTimeChanged: (int value) {
                mounted?dialogSetState((){
                  _day = int.parse(days[value]);
                }):null;
              },

            )
        ));
        children.add(Text("-"));
        children.add(Expanded(
            child:DataScrollView(
              dataIndex: 0,
              datas: Default24Hours,
              onDateTimeChanged: (int value) {
                mounted?dialogSetState((){
                  _hour = int.parse(Default24Hours[value]);
                }):null;
              },
            )
        ));
        children.add(Text(":"));
        children.add(Expanded(
            child:DataScrollView(
              dataIndex: 0,
              datas: DefaultMinutes,
              onDateTimeChanged: (int value) {
                mounted?dialogSetState((){
                  _minute = int.parse(DefaultMinutes[value]);
                }):null;
              },
            )
        ));
        children.add(Text(":"));
        children.add(Expanded(
            child:DataScrollView(
              dataIndex: 0,
              datas: DefaultSeconds,
              onDateTimeChanged: (int value) {
                mounted?dialogSetState((){
                  _second = int.parse(DefaultSeconds[value]);
                }):null;
              },
            )
        ));
        break;
      case SFormDateType.week:
        children.add(Expanded(
            child:DataScrollView(
              dataIndex: years.indexOf(_year.toString())==-1?0:years.indexOf(_year.toString()),
              datas: years,
              onDateTimeChanged: (int value) {
                mounted?dialogSetState((){
                  _year = int.parse(years[value]);
                  months = getMonths(_year);
                }):null;
              },

            )
        ));
        children.add(Expanded(
            child:DataScrollView(
              dataIndex: months.indexOf(_month.toString())==-1?0:months.indexOf(_month.toString()),
              datas: months,
              onDateTimeChanged: (int value) {
                mounted?dialogSetState((){
                  _month = int.parse(months[value]);
                }):null;
              },

            )
        ));
        children.add(Expanded(
            child:DataScrollView(
              dataIndex: weeks.indexOf(_week.toString())==-1?0:weeks.indexOf(_week.toString()),
              datas: weeks,
              onDateTimeChanged: (int value) {
                mounted?dialogSetState((){
                  _week = int.parse(weeks[value]);
                }):null;
              },
            )
        ));
        break;
      case SFormDateType.datetimerange:
        children.add(Expanded(
            child:DataScrollView(
              dataIndex: years.indexOf(_year.toString())==-1?0:years.indexOf(_year.toString()),
              datas: years,
              onDateTimeChanged: (int value) {
                mounted?dialogSetState((){
                  _year = int.parse(years[value]);
                  months = getMonths(_year);
                  days = getDays(_year, _month);
                }):null;
              },

            )
        ));
        children.add(Expanded(
            child:DataScrollView(
              dataIndex: months.indexOf(_month.toString())==-1?0:months.indexOf(_month.toString()),
              datas: this.months,
              onDateTimeChanged: (int value) {
                mounted?dialogSetState((){
                  _month = int.parse(months[value]);
                  days = getDays(_year, _month);
                }):null;
              },
            )
        ));
        children.add(Expanded(
            child:DataScrollView(
              dataIndex: days.indexOf(_day.toString())==-1?0:days.indexOf(_day.toString()),
              datas: days,
              onDateTimeChanged: (int value) {
                mounted?dialogSetState((){
                  _day = int.parse(days[value]);
                }):null;
              },

            )
        ));
        children.add(Text("-"));
        children.add(Expanded(
            child:DataScrollView(
              dataIndex: 0,
              datas: Default24Hours,
              onDateTimeChanged: (int value) {
                mounted?dialogSetState((){
                  _hour = int.parse(Default24Hours[value]);
                }):null;
              },
            )
        ));
        children.add(Text(":"));
        children.add(Expanded(
            child:DataScrollView(
              dataIndex: 0,
              datas: DefaultMinutes,
              onDateTimeChanged: (int value) {
                mounted?dialogSetState((){
                  _minute = int.parse(DefaultMinutes[value]);
                }):null;
              },
            )
        ));
        children.add(Text(":"));
        children.add(Expanded(
            child:DataScrollView(
              dataIndex: 0,
              datas: DefaultSeconds,
              onDateTimeChanged: (int value) {
                mounted?dialogSetState((){
                  _second = int.parse(DefaultSeconds[value]);
                }):null;
              },
            )
        ));
        children.add(Text("-"));
        children.add(Expanded(
            child:DataScrollView(
              dataIndex: years.indexOf(_year.toString())==-1?0:years.indexOf(_year.toString()),
              datas: years,
              onDateTimeChanged: (int value) {
                mounted?dialogSetState((){
                  _year = int.parse(years[value]);
                  months = getMonths(_year);
                  days = getDays(_year, _month);
                }):null;
              },

            )
        ));
        children.add(Expanded(
            child:DataScrollView(
              dataIndex: months.indexOf(_month.toString())==-1?0:months.indexOf(_month.toString()),
              datas: this.months,
              onDateTimeChanged: (int value) {
                mounted?dialogSetState((){
                  _month = int.parse(months[value]);
                  days = getDays(_year, _month);
                }):null;
              },
            )
        ));
        children.add(Expanded(
            child:DataScrollView(
              dataIndex: days.indexOf(_day.toString())==-1?0:days.indexOf(_day.toString()),
              datas: days,
              onDateTimeChanged: (int value) {
                mounted?dialogSetState((){
                  _day = int.parse(days[value]);
                }):null;
              },

            )
        ));
        children.add(Text("-"));
        children.add(Expanded(
            child:DataScrollView(
              dataIndex: 0,
              datas: Default24Hours,
              onDateTimeChanged: (int value) {
                mounted?dialogSetState((){
                  _hour = int.parse(Default24Hours[value]);
                }):null;
              },
            )
        ));
        children.add(Text(":"));
        children.add(Expanded(
            child:DataScrollView(
              dataIndex: 0,
              datas: DefaultMinutes,
              onDateTimeChanged: (int value) {
                mounted?dialogSetState((){
                  _minute = int.parse(DefaultMinutes[value]);
                }):null;
              },
            )
        ));
        children.add(Text(":"));
        children.add(Expanded(
            child:DataScrollView(
              dataIndex: 0,
              datas: DefaultSeconds,
              onDateTimeChanged: (int value) {
                mounted?dialogSetState((){
                  _second = int.parse(DefaultSeconds[value]);
                }):null;
              },
            )
        ));
        break;
      case SFormDateType.daterange:
        children.add(Expanded(
            child:DataScrollView(
              dataIndex: years.indexOf(_year.toString())==-1?0:years.indexOf(_year.toString()),
              datas: years,
              onDateTimeChanged: (int value) {
                mounted?dialogSetState((){
                  _year = int.parse(years[value]);
                  months = getMonths(_year);
                  days = getDays(_year, _month);
                  years_2 = getYears(startYears:_year);
                }):null;
              },
            )
        ));
        children.add(Expanded(
            child:DataScrollView(
              dataIndex: months.indexOf(_month.toString())==-1?0:months.indexOf(_month.toString()),
              datas: this.months,
              onDateTimeChanged: (int value) {
                mounted?dialogSetState((){
                  _month = int.parse(months[value]);
                  days = getDays(_year, _month);
                }):null;
              },
            )
        ));
        children.add(Expanded(
            child:DataScrollView(
              dataIndex: days.indexOf(_day.toString())==-1?0:days.indexOf(_day.toString()),
              datas: days,
              onDateTimeChanged: (int value) {
                mounted?dialogSetState((){
                  _day = int.parse(days[value]);
                }):null;
              },

            )
        ));
        children.add(Text("-"));
        children.add(Expanded(
            child:DataScrollView(
              dataIndex: years_2.indexOf(_year_2.toString())==-1?0:years_2.indexOf(_year_2.toString()),
              datas: years_2,
              onDateTimeChanged: (int value) {
                mounted?dialogSetState((){
                  _year_2 = int.parse(years_2[value]);
                  months_2 = getMonths(_year_2);
                  days_2 = getDays(_year_2, _month_2);
                }):null;
              },

            )
        ));
        children.add(Expanded(
            child:DataScrollView(
              dataIndex: months_2.indexOf(_month_2.toString())==-1?0:months_2.indexOf(_month_2.toString()),
              datas: this.months_2,
              onDateTimeChanged: (int value) {
                mounted?dialogSetState((){
                  _month_2 = int.parse(months_2[value]);
                  days_2 = getDays(_year_2, _month_2);
                }):null;
              },
            )
        ));
        children.add(Expanded(
            child:DataScrollView(
              dataIndex: days_2.indexOf(_day_2.toString())==-1?0:days_2.indexOf(_day_2.toString()),
              datas: days_2,
              onDateTimeChanged: (int value) {
                mounted?dialogSetState((){
                  _day_2 = int.parse(days_2[value]);
                }):null;
              },

            )
        ));
        break;
      case SFormDateType.monthrange:
        children.add(Expanded(
            child:DataScrollView(
              dataIndex: years.indexOf(_year.toString())==-1?0:years.indexOf(_year.toString()),
              datas: years,
              onDateTimeChanged: (int value) {
                mounted?dialogSetState((){
                  _year = int.parse(years[value]);
                  months = getMonths(_year);
                  days = getDays(_year, _month);
                  years_2 = getYears(startYears: _year);
                  months_2 = getMonths(_year , _month , true);
                }):null;
              },
            )
        ));
        children.add(Expanded(
            child:DataScrollView(
              dataIndex: months.indexOf(_month.toString())==-1?0:months.indexOf(_month.toString()),
              datas: this.months,
              onDateTimeChanged: (int value) {
                mounted?dialogSetState((){
                  _month = int.parse(months[value]);
                  months_2 = getMonths(_year, _month , true);
                }):null;
              },
            )
        ));
        children.add(Text("-"));
        children.add(Expanded(
            child:DataScrollView(
              dataIndex: years_2.indexOf(_year_2.toString())==-1?0:years_2.indexOf(_year_2.toString()),
              datas: years_2,
              onDateTimeChanged: (int value) {
                mounted?dialogSetState((){
                  _year_2 = int.parse(years_2[value]);
                  months_2 = getMonths(_year, _month_2 , true);
                }):null;
              },

            )
        ));
        children.add(Expanded(
            child:DataScrollView(
              dataIndex: months_2.indexOf(_month_2.toString())==-1?0:months_2.indexOf(_month_2.toString()),
              datas: months_2,
              onDateTimeChanged: (int value) {
                mounted?dialogSetState((){
                  _month_2 = int.parse(months_2[value]);
                }):null;
              },
            )
        ));
        break;
    }
    return children;
  }


  void cancelClick(void Function(void Function()) dialogSetState){
    row.value = oldValue;
    Navigator.of(context).pop();
  }

  void confirmClick(void Function(void Function()) dialogSetState){
    DateTime time;
    switch(row.dateType){
      case SFormDateType.year:
        time = DateTime(_year);
        row.value = time.toLocal().format(row.valueFormat);
        _controller.text = time.toLocal().format(row.dateFormat);
        break;
      case SFormDateType.month:
        time = DateTime(_year , _month);
        row.value = time.toLocal().format(row.valueFormat);
        _controller.text = time.toLocal().format(row.dateFormat);
        break;
      case SFormDateType.date:
        time = DateTime(_year , _month , _day);
        row.value = time.toLocal().format(row.valueFormat);
        _controller.text = time.toLocal().format(row.dateFormat);
        break;
      case SFormDateType.dates:
        time = DateTime(_year);
        break;
      case SFormDateType.datetime:
        time = DateTime(_year , _month , _day , _hour , _minute , _second);
        row.value = time.toLocal().format(row.valueFormat);
        _controller.text = time.toLocal().format(row.dateFormat);
        break;
      case SFormDateType.week:
        time = DateTime(_year , _month , _day);
        row.value = time.toLocal().format(row.valueFormat);
        _controller.text = time.toLocal().format(row.dateFormat);
        break;
      case SFormDateType.datetimerange:
        time = DateTime(_year , _month , _day , _hour , _minute , _second);
        DateTime time_2 = DateTime(_year_2 , _month_2 , _day_2 , _hour_2 , _minute_2 , _second_2);
        row.value = "${time.format(row.valueFormat)},${time_2.format(row.valueFormat)}";
        _controller.text = "${time.format(row.dateFormat)},${time_2.format(row.dateFormat)}";
        break;
      case SFormDateType.daterange:
        time = DateTime(_year , _month , _day);
        DateTime time_2 = DateTime(_year_2 , _month_2 , _day_2 );
        row.value = "${time.format(row.valueFormat)},${time_2.format(row.valueFormat)}";
        _controller.text = "${time.format(row.dateFormat)},${time_2.format(row.dateFormat)}";
        break;
      case SFormDateType.monthrange:
        time = DateTime(_year , _month);
        DateTime time_2 = DateTime(_year_2 , _month_2 );
        row.value = "${time.format(row.valueFormat)},${time_2.format(row.valueFormat)}";
        _controller.text = "${time.format(row.dateFormat)},${time_2.format(row.dateFormat)}";
        break;
    }
    row.onChange != null?row.onChange!(row):null;
    Navigator.of(context).pop();
  }
}


class DataScrollView extends StatelessWidget {
  DataScrollView({
    Key? key,
    required this.dataIndex,
    required this.datas,
    required this.onDateTimeChanged,
    this.options = const DataScrollOptions(),
  }) : super(key: key);
  final int dataIndex;
  final List<String> datas;
  /// A set that allows you to specify options related to ListWheelScrollView.
  final DataScrollOptions? options;
  /// On optional listener that's called when the centered item changes.
  final ValueChanged<int> onDateTimeChanged;


  /// This widget's selection and animation state.
  late FixedExtentScrollController _dataController;
  late Widget _dataScrollView;

  void _initDateScrollView() {
    _dataController = FixedExtentScrollController(initialItem: dataIndex);
    _dataScrollView = DataScrollItemView(
        datas: datas,
        controller: _dataController,
        selectedIndex: dataIndex,
        onChanged: (index) {
          onDateTimeChanged(index);
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    _initDateScrollView();
    return Stack(
      alignment: Alignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [_dataScrollView],
        ),
        /// Date Picker Indicator
        IgnorePointer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Theme.of(context).scaffoldBackgroundColor,
                        Theme.of(context).scaffoldBackgroundColor.withOpacity(0.7),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                height: options?.itemExtent,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.15),
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Theme.of(context).scaffoldBackgroundColor.withOpacity(0.7),
                        Theme.of(context).scaffoldBackgroundColor,
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

int getMonthlyDate({required int year, required int month}) {
  int day = 0;
  switch (month) {
    case 1:
      day = 31;
      break;
    case 2:
      day = (year % 4 == 0 && year % 100 != 0) || year % 400 == 0 ? 29 : 28;
      break;
    case 3:
      day = 31;
      break;
    case 4:
      day = 30;
      break;
    case 5:
      day = 31;
      break;
    case 6:
      day = 30;
      break;
    case 7:
      day = 31;
      break;
    case 8:
      day = 31;
      break;
    case 9:
      day = 30;
      break;
    case 10:
      day = 31;
      break;
    case 11:
      day = 30;
      break;
    case 12:
      day = 31;
      break;
    default:
      day = 30;
      break;
  }
  return day;
}
