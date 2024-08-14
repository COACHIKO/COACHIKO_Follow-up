import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/routing/routes.dart';
import '../../../../../core/routing/routing_model/routing_model.dart';
import '../../../../../core/services/shared_pref/shared_pref.dart';
import '../../../../../core/utils/constants/image_strings.dart';
import '../../../../../core/utils/constants/sizes.dart';
import '../../all_clients_display/data/models/clients_response.dart';

class ClientProfilePage extends StatelessWidget {
  final ClientData clientData;
  const ClientProfilePage({
    super.key,
    required this.clientData,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                                  context.push(Routes.trackHistory, extra: {
                                    'id': clientData.id!,
                                    'firstName': clientData.firstName!,
                                  });
                                },
                                child: const Text("Track History"),
                              )
                            : OutlinedButton(
                                onPressed: () {
                                  context.push(
                                    Routes.trackHistory,
                                    extra: TrackHistoryParams(
                                      userId: clientData.id!,
                                      name: clientData.firstName!,
                                    ),
                                  );
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
                                context.push(
                                  Routes.formComplection,
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
                      context.push(
                        Routes.foodSelection,
                        extra: clientData,
                      );
                    },
                    child: const Text("Set Diet Plan"),
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtwItems),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                      onPressed: () {
                        context.push(
                          Routes.exerciseSelection,
                          extra: clientData,
                        );
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
