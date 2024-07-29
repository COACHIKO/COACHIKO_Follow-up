import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:followupapprefactored/features/modules/coach/diet_making_features/food_selection/ui/food_selection_page.dart';
import '../../../../../core/networking/api_service.dart';
import '../../../../../core/services/shared_pref/shared_pref.dart';
import '../../../../../core/utils/constants/image_strings.dart';
import '../../../../../core/utils/constants/sizes.dart';
import '../../../../client_log_history/data/repository/get_log_history_repo_imp.dart';
import '../../../../client_log_history/logic/cubit/log_history_cubit.dart';
import '../../../../client_log_history/ui/logs_history.dart';
import '../../../client/phases_cases/form_completion/ui/form_completion.dart';
import '../../all_clients_display/data/models/clients_response.dart';
import '../../navigation_bar/ui/coach_navigation_bar.dart';
import '../../workout_routine_making_features/display_client_routine/ui/client_routines_display.dart';

class ClientProfilePage extends StatelessWidget {
  final ClientData clientData;
  const ClientProfilePage({
    super.key,
    required this.clientData,
  });

  @override
  Widget build(BuildContext context) {
    // var dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) =>
                        const CoachNavigationBar(initialIndex: 2)),
                (route) => false,
              );
            },
            icon: const Icon(Icons.arrow_back)),
        centerTitle: true,
        title: Text("${clientData.firstName} ${clientData.secondName}"),
        iconTheme: const IconThemeData(color: Colors.blueAccent),
      ),
      body: Column(
        children: [
          SizedBox(
            width: double.maxFinite,
            child: Card(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Physical Info ",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                              "Gender: ${clientData.genderSelect == 0 ? "Male" : "Female"} "),
                          Text("Weight: ${clientData.weight} KG"),
                          Text("Abdomen: ${clientData.waist} CM"),
                          Text("Neck: ${clientData.neck} CM"),
                          Text("Hip: ${clientData.hip} CM"),
                          Text("Chest: ${clientData.chest} CM"),
                          Text("Arm: ${clientData.arms} CM"),
                          Text("Wrist: ${clientData.wrist} CM"),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Social Info ",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                              "Goal: ${clientData.goalSelect == 0 ? "Weight Loss" : clientData.goalSelect == 1 ? "Weight Maintain" : "Weight Gain"} "),
                          Text(clientData.activitySelect == 0
                              ? "${clientData.genderSelect == 0 ? "He" : "She"} Doesn't Train At All"
                              : clientData.activitySelect == 1
                                  ? "${clientData.genderSelect == 0 ? "He" : "She"} Trains 1 or 2 Times A Week"
                                  : clientData.activitySelect == 2
                                      ? "${clientData.genderSelect == 0 ? "He" : "She"} Trains 3 to 5 Times A Week"
                                      : clientData.activitySelect == 3
                                          ? "${clientData.genderSelect == 0 ? "He" : "She"} Trains 6 Times A Week"
                                          : "${clientData.genderSelect == 0 ? "He" : "She"} Trains Twice a Day"),
                          Text(
                              "${clientData.genderSelect == 0 ? "His" : "Her"} Budget is ${clientData.costSelect == 0 ? "Low" : clientData.costSelect == 1 ? "Medium" : "High"}"),
                          Text(
                              "Preferred Foods: ${clientData.preferredFoods!.replaceAll(",", " And")}"),
                        ],
                      ),
                    ),
                    const SizedBox(
                        width: 16), // Adding space between text and image
                    clientData.genderSelect == 0 &&
                            clientData.fatPercentage != 0 &&
                            clientData.fatPercentage! < 12
                        ? const Image(
                            image: AssetImage(TImages.under12FatMan),
                            height: 300,
                          )
                        : clientData.genderSelect == 0 &&
                                clientData.fatPercentage! > 12 &&
                                clientData.fatPercentage! < 20
                            ? const Image(
                                image: AssetImage(TImages.above12under20FatMan),
                                height: 300,
                              )
                            : clientData.genderSelect == 0 &&
                                    clientData.fatPercentage! > 20 &&
                                    clientData.fatPercentage! < 29
                                ? const Image(
                                    image: AssetImage(
                                        TImages.above20under30FatMan),
                                    height: 300,
                                  )
                                : clientData.genderSelect == 0 &&
                                        clientData.fatPercentage! > 29 &&
                                        clientData.fatPercentage! < 39
                                    ? const Image(
                                        image: AssetImage(
                                            TImages.above29Under40FatMan),
                                        height: 300,
                                      )
                                    : const SizedBox.shrink(),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Column(
              children: [
                clientData.currentStep! > 1
                    ? SizedBox(
                        width: double.infinity,
                        child: SharedPref().getInt("user") == clientData.id
                            ? ElevatedButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => BlocProvider(
                                          create: (context) {
                                            return LogHistoryCubit(
                                                getLogHistoryRepoImp:
                                                    GetLogHistoryRepoImp(
                                                        ApiService(Dio())))
                                              ..getLogsHistory(clientData
                                                  .id); // Ensure initial data fetch
                                          },
                                          child: LogsHistoryPage(
                                            name:
                                                clientData.firstName.toString(),
                                          ),
                                        ),
                                      ));
                                },
                                child: const Text("Track History"),
                              )
                            : OutlinedButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => BlocProvider(
                                          create: (context) {
                                            return LogHistoryCubit(
                                                getLogHistoryRepoImp:
                                                    GetLogHistoryRepoImp(
                                                        ApiService(Dio())))
                                              ..getLogsHistory(clientData.id);
                                          },
                                          child: LogsHistoryPage(
                                            name:
                                                clientData.firstName.toString(),
                                          ),
                                        ),
                                      ));
                                },
                                child: const Text("Track History"),
                              ),
                      )
                    : const SizedBox.shrink(),
                const SizedBox(height: TSizes.spaceBtwItems),
                SharedPref().getInt("user") == clientData.id
                    ? Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton(
                              onPressed: () {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const FormComplectionView(),
                                  ),
                                  (route) => false,
                                );
                              },
                              child: const Text("Complete Form"),
                            ),
                          ),
                          const SizedBox(height: TSizes.spaceBtwItems),
                        ],
                      )
                    : const SizedBox.shrink(),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  FoodSelection(clientData: clientData)));
                    },
                    child: const Text("Set Diet Plan"),
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtwItems),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ClientRoutineDisplay(
                                      id: clientData.id!,
                                      clientData: clientData,
                                    )));
                      },
                      child: const Text("Set Workout Plan")),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
