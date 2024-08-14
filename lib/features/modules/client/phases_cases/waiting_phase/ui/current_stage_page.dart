import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/services/shared_pref/shared_pref.dart';
import '../../../../../../core/utils/constants/colors.dart';
import '../../../../../../core/utils/helpers/helper_functions.dart';
import '../../../../coach/navigation_bar/ui/coach_navigation_bar.dart';
import '../logic/cubit/current_stage_cubit.dart';
import '../logic/cubit/current_stage_state.dart';

class CurrentStage extends StatelessWidget {
  const CurrentStage({super.key});

  @override
  Widget build(BuildContext context) {
      final bool dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar( 
        title: const Text('Current Stage'),
        centerTitle: true,
        backgroundColor: dark? const Color(0xFF1C1C1E):CColors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.refresh,
              color: Colors.blueAccent,
            ),
            onPressed: ()async {
                 context.read<CurrentStageCubit>().getCurrentStage();
            },
          ),
        ],
      ),
      body: BlocBuilder<CurrentStageCubit, CurrentStageState>(
        builder: (context, state) {
          if (state is CurrentStageLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CurrentStageError) {
            return Center(
                child: Text(state.error.toString(),
                    style: const TextStyle(color: Colors.red)));
          } else if (state is CurrentStageUpdate) {
            if (state.currentStage.currentStep == 1) {
              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 70.h,
                      child: Stepper(
                        type: StepperType.horizontal,
                        currentStep: 1,
                        steps: const [
                          Step(
                              state: StepState.complete,
                              title: Text('Form'),
                              stepStyle: StepStyle(color: CColors.primary),
                              content: SizedBox.shrink()),
                          Step(
                              title: Text('Waiting'),
                              content: SizedBox.shrink(),
                              stepStyle: StepStyle(
                                  color: CColors.primary,
                                  indexStyle: TextStyle(color: Colors.white)),
                              isActive: true),
                          Step(
                            title: Text('Ready'),
                            stepStyle: StepStyle(
                                color: CColors.white,
                                indexStyle: TextStyle(color: Colors.black)),
                            content: SizedBox.shrink(),
                          ),
                        ],
                      ),
                    ),
                    const Text("You're waiting your coach to put plan for you"),
                    SizedBox(height: 5.h),
                    const Text("But we have some settings to modify"),
                    SizedBox(height: 20.h),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text("Logging Setting"),
                            InkWell(
                              onTap: () {
                                context
                                    .read<CurrentStageCubit>()
                                    .toggleLogSettingsExpanded(
                                        state.currentStage);
                              },
                              child: Icon(
                                context
                                            .read<CurrentStageCubit>()
                                            .logSettingsExpanded ==
                                        false
                                    ? Icons.arrow_right
                                    : Icons.arrow_drop_down,
                                size: 30,
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 5.h),
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          transitionBuilder:
                              (Widget child, Animation<double> animation) {
                            return FadeTransition(
                              opacity: animation,
                              child: SizeTransition(
                                sizeFactor: animation,
                                child: child,
                              ),
                            );
                          },
                          child: context
                                  .read<CurrentStageCubit>()
                                  .logSettingsExpanded
                              ? SharedPref().getInt("numberOfLogs") == null
                                  ? Center(
                                      child: SizedBox(
                                          width: 400.w,
                                          height: 120,
                                          child: CustomCard(
                                              cardText:
                                                  "How many times you want to log your weight weekly ?",
                                              onPressed: () {
                                                showNumberPicker(
                                                  context: context,
                                                  minValue: 1,
                                                  maxValue: 7,
                                                  fontColor: CColors.primary,
                                                  onSelected: (int value) {
                                                    SharedPref().setInt(
                                                        "numberOfLogs", value);

                                                    context
                                                        .read<
                                                            CurrentStageCubit>()
                                                        .toggleUpdateLogSettingsExpanded(
                                                            state.currentStage);
                                                  },
                                                );
                                              },
                                              buttonText:
                                                  "Select weekly logs number")),
                                    )
                                  : Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                                "You're logging your weight ${SharedPref().getInt("numberOfLogs")} times weekly"),
                                            GestureDetector(
                                              onTap: () {
                                                SharedPref().removePreference(
                                                    "numberOfLogs");
                                                context
                                                    .read<CurrentStageCubit>()
                                                    .toggleUpdateLogSettingsExpanded(
                                                        state.currentStage);
                                              },
                                              child: Text(
                                                " edit",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelLarge!
                                                    .copyWith(
                                                        fontSize: 15,
                                                        color: CColors.primary,
                                                        fontWeight:
                                                            FontWeight.bold),
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(height: 10.h),
                                        SharedPref().getString("timeToLog") ==
                                                null
                                            ? Center(
                                                child: SizedBox(
                                                    width: 400.w,
                                                    height: 120,
                                                    child: CustomCard(
                                                        onPressed: () {
                                                          showTimePickerDialog(
                                                            context: context,
                                                            fontColor:
                                                                CColors.primary,
                                                            onSelected:
                                                                (TimeOfDay
                                                                    value) {
                                                              SharedPref().setString(
                                                                  "timeToLog",
                                                                  value.format(
                                                                      context));

                                                              context
                                                                  .read<
                                                                      CurrentStageCubit>()
                                                                  .toggleUpdateLogSettingsExpanded(
                                                                      state
                                                                          .currentStage);
                                                            },
                                                          );
                                                        },
                                                        cardText:
                                                            "When you want to log your weight ?",
                                                        buttonText:
                                                            "Select Time")),
                                              )
                                            : Row(
                                                children: [
                                                  Text(
                                                      "You're logging your weight at ${SharedPref().getString("timeToLog")}"),
                                                  GestureDetector(
                                                    onTap: () {
                                                      SharedPref()
                                                          .removePreference(
                                                              "timeToLog");
                                                      context
                                                          .read<
                                                              CurrentStageCubit>()
                                                          .toggleUpdateLogSettingsExpanded(
                                                              state
                                                                  .currentStage);
                                                    },
                                                    child: Text(
                                                      " edit",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .labelLarge!
                                                          .copyWith(
                                                              fontSize: 15,
                                                              color: CColors
                                                                  .primary,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                    ),
                                                  )
                                                ],
                                              ),
                                      ],
                                    )
                              : const SizedBox.shrink(),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //  const Text("You can notify your coach to put plan for you"),
                        SizedBox(height: 5.h),
                        context.read<CurrentStageCubit>().logSettingsExpanded ==
                                    false ||
                                SharedPref().getInt("numberOfLogs") != null &&
                                    SharedPref().getString("timeToLog") != null
                            ? Center(
                                child: CustomMaterialButton(
                                    onPressed: () {},
                                    buttonText: "Notifiy Coach"),
                              )
                            : const SizedBox.shrink()
                      ],
                    ),
                  ],
                ),
              );
            } else {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CoachNavigationBar()),
                  (Route<dynamic> route) => false,
                );
              });
              return const SizedBox.shrink(); // Return an empty widget
            }
          } else {
            return Container(); // handle other states if needed
          }
        },
      ),
    );
  }
}

void showNumberPicker({
  required BuildContext context,
  required int minValue,
  required int maxValue,
  required Color fontColor,
  required Function(int) onSelected,
}) {
  int selectedValue = minValue;

  showCupertinoModalPopup(
    context: context,
    builder: (context) {
      return Container(
        height: 300.h,
        color: Colors.white,
        child: Column(
          children: [
            SizedBox(
              height: 200.h,
              child: CupertinoPicker(
                backgroundColor: Colors.white,
                itemExtent: 32.0,
                onSelectedItemChanged: (int index) {
                  selectedValue = minValue + index;
                },
                children: List<Widget>.generate(
                  maxValue - minValue + 1,
                  (int index) {
                    return Center(
                      child: Text(
                        '${minValue + index}',
                        style: TextStyle(color: fontColor),
                      ),
                    );
                  },
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CupertinoButton(
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: Colors.red),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                CupertinoButton(
                  child: const Text(
                    'Save',
                    style: TextStyle(color: CColors.primary),
                  ),
                  onPressed: () {
                    onSelected(selectedValue);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}

Future<void> showTimePickerDialog({
  required BuildContext context,
  required Color fontColor,
  required Function(TimeOfDay) onSelected,
}) async {
  TimeOfDay? selectedTime = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
    builder: (BuildContext context, Widget? child) {
      return Theme(
        data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(primary: fontColor),
            buttonTheme:
                const ButtonThemeData(textTheme: ButtonTextTheme.primary)),
        child: child!,
      );
    },
  );

  if (selectedTime != null) {
    onSelected(selectedTime);
  }
}

class CustomCard extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;
  final String cardText;
  const CustomCard({
    super.key,
    required this.onPressed,
    required this.cardText,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: CColors.primary,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Text(cardText,style: const TextStyle(color: Colors.white),),
            const SizedBox(height: 10),
            SizedBox(
              width: 200,
              child: MaterialButton(
                animationDuration: const Duration(milliseconds: 100),
                highlightColor: CColors.primary,
                splashColor: CColors.primary,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide.none),
                onPressed: onPressed,
                child: Text(
                  buttonText,
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: CColors.primary, fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CustomMaterialButton extends MaterialButton {
  final String buttonText;
  final VoidCallback onPressed;

  CustomMaterialButton(
      {super.key,
      required this.onPressed,
      required this.buttonText,
      Color super.highlightColor = Colors.blueAccent,
      Color super.splashColor = Colors.blueAccent,
      Duration super.animationDuration = const Duration(milliseconds: 100),
      double super.height = 80,
      double super.minWidth = 120})
      : super(
          onPressed: onPressed,
          child: Text(
            buttonText,
            style: const TextStyle(
                color: Colors.blueAccent, fontWeight: FontWeight.bold),
          ),
          color: Colors.white,
          shape: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12))),
        );
}
