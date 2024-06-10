import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hezr/app/modules/doctor/doctor_home/controller/doctor_home_controller.dart';
import 'package:hezr/global/constants/app_colors.dart';
import 'package:hezr/global/utils/app_text_style.dart';
import 'package:hezr/global/utils/spaces.dart';

class LineChartGraph extends GetView<DoctorHomeController> {
  const LineChartGraph({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.whiteBGColor,
        borderRadius: BorderRadius.circular(10),
      ),
      height: MediaQuery.of(context).size.height * 0.26,
      child: LineChart(
        mainData(demoList),
      ),
    );
  }

  LineChartData mainData(List<FlSpotModel> flSpotModel) {
    return LineChartData(
      lineTouchData: LineTouchData(
        getTouchedSpotIndicator:
            (LineChartBarData barData, List<int> spotIndexes) {
          return spotIndexes.map((spotIndex) {
            final spot = barData.spots[spotIndex];
            if (spot.x == 0 || spot.x == 6) {
              return null;
            }
            return TouchedSpotIndicatorData(
              const FlLine(
                color: AppColors.primaryColor,
                strokeWidth: 2,
              ),
              FlDotData(
                getDotPainter: (spot, percent, barData, index) {
                  return FlDotCirclePainter(
                      radius: 6,
                      color: AppColors.primaryColor,
                      strokeWidth: 1,
                      strokeColor: Colors.transparent);
                },
              ),
            );
          }).toList();
        },
        touchTooltipData: LineTouchTooltipData(
          // tooltipBgColor: AppColors.primaryColor,
          getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
            return touchedBarSpots.map((barSpot) {
              final flSpot = barSpot;

              TextAlign textAlign;
              switch (flSpot.x.toInt()) {
                case 1:
                  textAlign = TextAlign.left;
                  break;
                case 5:
                  textAlign = TextAlign.right;
                  break;
                default:
                  textAlign = TextAlign.center;
              }

              return LineTooltipItem(
                '',
                const TextStyle(
                  color: Colors.transparent,
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                    text: flSpot.y.toStringAsFixed(2),
                    style: AppTextStyles.medium.copyWith(
                      fontWeight: FontWeight.w500,
                      // fontSize: Spaces.fontSize(fontSize: 14),
                      color: AppColors.whiteBGColor,
                    ),
                  ),
                ],
                textAlign: textAlign,
              );
            }).toList();
          },
        ),
        touchCallback: (FlTouchEvent event, LineTouchResponse? lineTouch) {
          if (!event.isInterestedForInteractions ||
              lineTouch == null ||
              lineTouch.lineBarSpots == null) {
            return;
          }
        },
      ),
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        drawHorizontalLine: true,
        horizontalInterval: 19.9,
        getDrawingHorizontalLine: (value) {
          return const FlLine(
              color: AppColors.blackBGColor,
              strokeWidth: .5,
              dashArray: [2, 4]);
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          axisNameSize: 20,
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 40,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 30,
          ),
        ),
      ),
      borderData: FlBorderData(
          show: false,
          border: Border(
              left: BorderSide(color: AppColors.blackBGColor.withOpacity(1)))),
      minX: 0,
      maxX: 6,
      minY: 0,
      maxY: 100,
      lineBarsData: [
        LineChartBarData(
          shadow: BoxShadow(
              color: AppColors.primaryColor.withOpacity(0.6),
              offset: const Offset(0, 4),
              blurRadius: 3,
              blurStyle: BlurStyle.solid),
          gradient: LinearGradient(
            colors: controller.gradientColors,
          ),
          spots: flSpotModel.map((e) => FlSpot(e.x!, e.y!)).toList(),
          isCurved: true,
          barWidth: 2.5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            applyCutOffY: true,
            show: true,
            cutOffY: 0,
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0, 0.5, 1],
                tileMode: TileMode.mirror,
                colors: [
                  AppColors.primaryColor.withOpacity(.3),
                  AppColors.primaryColor.withOpacity(0.15),
                  AppColors.primaryColor.withOpacity(0.01),
                ]),
          ),
        ),
      ],
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    final style = AppTextStyles.medium.copyWith(
      fontWeight: FontWeight.w400,
      color: AppColors.blackBGColor,
      fontSize: Spaces.fontSize(fontSize: 10),
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = Text('Mon', style: style);
        break;
      case 1:
        text = Text('Tue', style: style);
        break;
      case 2:
        text = Text('Wed', style: style);
        break;
      case 3:
        text = Text('Thu', style: style);
        break;
      case 4:
        text = Text('Fri', style: style);
        break;
      case 5:
        text = Text('Sat', style: style);
        break;

      case 6:
        text = Text('Sun', style: style);
        break;

      default:
        text = Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    final style = AppTextStyles.medium.copyWith(
      fontWeight: FontWeight.w300,
      fontSize: Spaces.fontSize(fontSize: 10),
      color: AppColors.blackBGColor,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = '0';
        break;
      case 20:
        text = '20';
        break;
      case 40:
        text = '40';
        break;
      case 60:
        text = '60';
        break;
      case 80:
        text = '80';
        break;
      case 100:
        text = '100';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  Color lerpGradient(List<Color> colors, List<double> stops, double t) {
    if (colors.isEmpty) {
      throw ArgumentError('"colors" is empty.');
    } else if (colors.length == 1) {
      return colors[0];
    }

    if (stops.length != colors.length) {
      stops = [];

      /// provided gradientColorStops is invalid and we calculate it here
      colors.asMap().forEach((index, color) {
        final percent = 1.0 / (colors.length - 1);
        stops.add(percent * index);
      });
    }

    for (var s = 0; s < stops.length - 1; s++) {
      final leftStop = stops[s];
      final rightStop = stops[s + 1];
      final leftColor = colors[s];
      final rightColor = colors[s + 1];
      if (t <= leftStop) {
        return leftColor;
      } else if (t < rightStop) {
        final sectionT = (t - leftStop) / (rightStop - leftStop);
        return Color.lerp(leftColor, rightColor, sectionT)!;
      }
    }
    return colors.last;
  }
}

class FlSpotModel {
  double? x;
  double? y;
  DateTime? date;
  FlSpotModel({this.x, this.y, this.date});
}

List<FlSpotModel> demoList = [
  FlSpotModel(x: 0, y: 5.0, date: DateTime(2024, 6, 1)),
  FlSpotModel(x: 1, y: 25.0, date: DateTime(2024, 6, 2)),
  FlSpotModel(x: 2, y: 10.0, date: DateTime(2024, 6, 3)),
  FlSpotModel(x: 3, y: 50.0, date: DateTime(2024, 6, 4)),
  FlSpotModel(x: 4.0, y: 0.0, date: DateTime(2024, 6, 5)),
  FlSpotModel(x: 5.0, y: 20.0, date: DateTime(2024, 6, 5)),
  FlSpotModel(x: 6.0, y: 0.0, date: DateTime(2024, 6, 5)),
];
