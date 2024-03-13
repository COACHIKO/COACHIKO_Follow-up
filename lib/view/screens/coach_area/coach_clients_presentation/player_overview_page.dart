import 'package:flutter/material.dart';
import 'package:followupapprefactored/controller/client_controllers/routines_page_controller.dart';
import 'package:get/get.dart';
import '../../../../controller/coach_controllers/diet_make_controller.dart';
import '../../../../core/utils/constants/image_strings.dart';
import '../../../../core/utils/constants/sizes.dart';
import '../../../../main.dart';
import '../diet_presentation/diet_making_page.dart';
import '../routine_presentation/coach_clients_routine_preview_page.dart';

class PlayerOverviewPage extends StatelessWidget {
    final int index;
    PlayerOverviewPage({
    super.key,
    required this.index,

  });

  final coachHomeController = Get.put(DietMakingController());
   final routinePageController = Get.put(RoutinesPageController());


  @override
  Widget build(BuildContext context) {
   // var dark = THelperFunctions.isDarkMode(context);
    return Scaffold(appBar: AppBar(
      centerTitle: true,
      title: Text("${coachHomeController.coachClients[index].firstName} ${coachHomeController.coachClients[index].secondName}",),
      iconTheme: const IconThemeData(color: Colors.blueAccent),
    ),
      body:  Column(
        children: [
          SizedBox(
            width: double.maxFinite,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Physical Info ",
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10,),
                          Text("Gender: ${coachHomeController.coachClients[index].genderSelect==0 ? "Male" : "Female"} "),
                          Text("Weight: ${coachHomeController.coachClients[index].weight} KG"),
                          Text("Abdomen: ${coachHomeController.coachClients[index].waist} CM"),
                          Text("Neck: ${coachHomeController.coachClients[index].neck} CM"),
                          Text("Hip: ${coachHomeController.coachClients[index].hip} CM"),
                          Text("Chest: ${coachHomeController.coachClients[index].chest} CM"),
                          Text("Arm: ${coachHomeController.coachClients[index].arms} CM"),
                          Text("Wrist: ${coachHomeController.coachClients[index].wrist} CM"),
                          const SizedBox(height: 10,),
                          Text("Social Info ", style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 15, fontWeight: FontWeight.bold),),
                          const SizedBox(height: 10,),
                          Text("Goal: ${coachHomeController.coachClients[index].goalSelect == 0 ? "Weight Loss" : coachHomeController.coachClients[index].goalSelect == 1 ? "Weight Maintain" : "Weight Gain"} "),
                          Text(
                              coachHomeController.coachClients[index].activitySelect == 0 ? "${coachHomeController.coachClients[index].genderSelect == 0 ? "He" : "She"} Doesn't Train At All" :
                              coachHomeController.coachClients[index].activitySelect == 1 ? "${coachHomeController.coachClients[index].genderSelect == 0 ? "He" : "She"} Trains 1 or 2 Times A Week" :
                              coachHomeController.coachClients[index].activitySelect == 2 ? "${coachHomeController.coachClients[index].genderSelect == 0 ? "He" : "She"} Trains 3 to 5 Times A Week" :
                              coachHomeController.coachClients[index].activitySelect == 3 ? "${coachHomeController.coachClients[index].genderSelect == 0 ? "He" : "She"} Trains 6 Times A Week" : "${coachHomeController.coachClients[index].genderSelect == 0 ? "He" : "She"} Trains Twice a Day"),
                          Text("${coachHomeController.coachClients[index].genderSelect == 0 ? "His" : "Her"} Budget is ${coachHomeController.coachClients[index].costSelect == 0 ? "Low" : coachHomeController.coachClients[index].costSelect == 1 ? "Medium" : "High"}"),
                          Text("Preferred Foods: ${coachHomeController.coachClients[index].preferedFoods.replaceAll(",", " And")}"),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16), // Adding space between text and image
                          coachHomeController.coachClients[index].genderSelect == 0 && coachHomeController.coachClients[index].fatPercentage!=0 && coachHomeController.coachClients[index].fatPercentage < 12 ? const Image(image: AssetImage(TImages.under12FatMan), height: 300,)
                        : coachHomeController.coachClients[index].genderSelect == 0 && coachHomeController.coachClients[index].fatPercentage > 12 && coachHomeController.coachClients[index].fatPercentage < 20 ? const Image(image: AssetImage(TImages.above12under20FatMan), height: 300,)
                        : coachHomeController.coachClients[index].genderSelect == 0 && coachHomeController.coachClients[index].fatPercentage > 20 && coachHomeController.coachClients[index].fatPercentage < 29 ? const Image(image: AssetImage(TImages.above20under30FatMan), height: 300,)
                        : coachHomeController.coachClients[index].genderSelect == 0 && coachHomeController.coachClients[index].fatPercentage > 29 && coachHomeController.coachClients[index].fatPercentage < 39 ? const Image(image: AssetImage(TImages.above29Under40FatMan), height: 300,)
                        : const SizedBox.shrink(),
                  ],
                ),
              ),
            ),
          ),



          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Column(children: [
                const SizedBox(height: TSizes.spaceBtwItems),
                myServices.sharedPreferences.getInt("user") == coachHomeController.coachClients[index].id ?
                Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {
                          Get.offAllNamed("/formComplection");
                        },
                        child: const Text("Complete Form"),
                      ),
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems),

                  ],
                ) : const SizedBox.shrink(),
                SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed:() {
                    Get.to(FoodListPage(id: coachHomeController.coachClients[index].id));

                  },
                  child: const Text("Set Diet Plan"),
                ),
              ),
                const SizedBox(height: TSizes.spaceBtwItems),
                SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () async{
                   await Get.to(() => WorkoutPlanPreview(id:coachHomeController.coachClients[index].id,));


                  },
                  child: const Text("Set Workout Plan"),
                ),
              ),

              ],),),


        ],),

    );

  }
}















