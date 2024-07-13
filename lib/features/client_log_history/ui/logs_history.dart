import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/utils/helpers/helper_functions.dart';
import '../../../core/utils/constants/image_strings.dart';
import '../data/models/client_log_history_response.dart';
import '../logic/cubit/log_history_cubit.dart';
import '../logic/cubit/log_history_state.dart';

class LogsHistoryPage extends StatelessWidget {
  const LogsHistoryPage({super.key, required this.name});
  final String name;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('$name History'),
      ),
      body: BlocBuilder<LogHistoryCubit, HistoryLogsState>(
        builder: (context, state) {
          if (state is HistoryLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HistoryError) {
            return const Center(child: Text('No History available'));
          } else if (state is HistoryNoData) {
            return const Center(child: Text('No Diet Plan available'));
          } else if (state is HistoryLoaded) {
            return LoadedDataUi(
              dark: dark,
              clientLogs: state.clientLogs,
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

class LoadedDataUi extends StatefulWidget {
  const LoadedDataUi({super.key, required this.dark, required this.clientLogs});
  final bool dark;
  final ClientLogsResponseBody clientLogs;
  @override
  LoadedDataUiState createState() => LoadedDataUiState();
}

class LoadedDataUiState extends State<LoadedDataUi> {
  String selectedMeasure = 'weight';

  List<FlSpot> getWeightData() {
    return widget.clientLogs.measuresLogs
        .asMap()
        .entries
        .map((e) =>
            FlSpot(e.key.toDouble(), double.tryParse(e.value.weight) ?? 0))
        .toList();
  }

  List<FlSpot> getMeasureData(String measure) {
    switch (measure) {
      case 'waist':
        return widget.clientLogs.measuresLogs
            .asMap()
            .entries
            .map((e) =>
                FlSpot(e.key.toDouble(), double.tryParse(e.value.waist) ?? 0))
            .toList();
      case 'chest':
        return widget.clientLogs.measuresLogs
            .asMap()
            .entries
            .map((e) =>
                FlSpot(e.key.toDouble(), double.tryParse(e.value.chest) ?? 0))
            .toList();
      case 'hip':
        return widget.clientLogs.measuresLogs
            .asMap()
            .entries
            .map((e) =>
                FlSpot(e.key.toDouble(), double.tryParse(e.value.hip) ?? 0))
            .toList();
      case 'arms':
        return widget.clientLogs.measuresLogs
            .asMap()
            .entries
            .map((e) =>
                FlSpot(e.key.toDouble(), double.tryParse(e.value.arms) ?? 0))
            .toList();
      case 'neck':
        return widget.clientLogs.measuresLogs
            .asMap()
            .entries
            .map((e) =>
                FlSpot(e.key.toDouble(), double.tryParse(e.value.neck) ?? 0))
            .toList();
      case 'wrist':
        return widget.clientLogs.measuresLogs
            .asMap()
            .entries
            .map((e) =>
                FlSpot(e.key.toDouble(), double.tryParse(e.value.wrist) ?? 0))
            .toList();
      default:
        return getWeightData();
    }
  }

  Map<String, Map<String, List<Log>>> _groupLogsByDateAndMinute() {
    Map<String, Map<String, List<Log>>> groupedLogs = {};
    for (var routine in widget.clientLogs.routineLogs) {
      for (var log in routine.logs) {
        String dateTime =
            log.logTimestamp.substring(0, 16); // Group by date and minute
        String exerciseName = log.exerciseName;

        if (!groupedLogs.containsKey(dateTime)) {
          groupedLogs[dateTime] = {};
        }
        if (!groupedLogs[dateTime]!.containsKey(exerciseName)) {
          groupedLogs[dateTime]![exerciseName] = [];
        }
        groupedLogs[dateTime]![exerciseName]!.add(log);
      }
    }
    return groupedLogs;
  }

  Widget _buildMeasureButton(String label, String measure) {
    bool isSelected = selectedMeasure == measure;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: isSelected ? Colors.blueAccent : Colors.white,
        borderRadius: BorderRadius.circular(22),
      ),
      child: MaterialButton(
        splashColor: Colors.transparent,
        onPressed: () {
          setState(() {
            selectedMeasure = measure;
          });
        },
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 22.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 200, child: _buildChart()),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 18.0, horizontal: 8),
                child: SizedBox(
                  height: 30,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _buildMeasureButton("Weight", 'weight'),
                      const SizedBox(width: 5),
                      _buildMeasureButton("Waist", 'waist'),
                      const SizedBox(width: 5),
                      _buildMeasureButton("Chest", 'chest'),
                      const SizedBox(width: 5),
                      _buildMeasureButton("Hip", 'hip'),
                      const SizedBox(width: 5),
                      _buildMeasureButton("Arms", 'arms'),
                      const SizedBox(width: 5),
                      _buildMeasureButton("Wrist", 'wrist'),
                      const SizedBox(width: 5),
                      _buildMeasureButton("Neck", 'neck'),
                    ],
                  ),
                ),
              ),
              _buildRoutineLogs()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChart() {
    return Padding(
      padding: const EdgeInsets.only(right: 40),
      child: LineChart(
        LineChartData(
          lineBarsData: [
            LineChartBarData(
              spots: getMeasureData(selectedMeasure),
              isCurved: true,
              color: Colors.blue,
              barWidth: 5,
              belowBarData: BarAreaData(show: true),
            ),
          ],
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 3,
                getTitlesWidget: (value, meta) {
                  final date = widget
                      .clientLogs.measuresLogs[value.toInt()].logTimestamp;
                  final formattedDate =
                      "${date.split('-')[2].split(' ')[0]}/${date.split('-')[1]}/${date.split('-')[0].substring(2)}";
                  return SideTitleWidget(
                    axisSide: meta.axisSide,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Text(
                        formattedDate,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                  );
                },
              ),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
          ),
          borderData: FlBorderData(show: false),
          gridData: const FlGridData(show: false),
        ),
      ),
    );
  }

  Widget _buildRoutineLogs() {
    final groupedLogs = _groupLogsByDateAndMinute();
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: groupedLogs.length,
      itemBuilder: (context, index) {
        final dateTime = groupedLogs.keys.elementAt(index);
        final routineName =
            groupedLogs[dateTime]!.values.first.first.routineName;
        final exercises = groupedLogs[dateTime]!;
        final formattedDate =
            "${dateTime.split('-')[2].split(' ')[0]}/${dateTime.split('-')[1]}/${dateTime.split('-')[0].substring(2)}";
        return Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "$routineName routine at $formattedDate ",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ...exercises.entries.map((entry) {
                final exerciseName = entry.key;
                final logs = entry.value;
                final sets = logs.length;
                // final reps = logs.map((log) => log.reps).join(', ');
                // final weights = logs.map((log) => log.weight).join(', ');
                return Column(
                  children: [
                    SizedBox(height: 10.h),
                    ListTile(
                        leading: CircleAvatar(
                          radius: 30,
                          child: ClipOval(
                            child: Image(
                              image: AssetImage(
                                "${TImages.excersiseDirectory}${logs[0].exerciseImage}",
                              ),
                            ),
                          ),
                        ),
                        title: Text("$sets Sets of $exerciseName")),
                    SizedBox(height: 10.h),
                  ],
                );
              }),
            ],
          ),
        );
      },
    );
  }
}
