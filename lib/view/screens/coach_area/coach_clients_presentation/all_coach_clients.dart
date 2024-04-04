import 'package:flutter/cupertino.dart';
import 'package:followupapprefactored/view/screens/coach_area/coach_clients_presentation/player_overview_page.dart';
import 'package:followupapprefactored/view/widgets/custom_appbar.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../controller/coach_controllers/diet_making_controllers/diet_make_controller.dart';
import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/helpers/helper_functions.dart';
import '../../../../main.dart';

class AllClientsDisplay extends StatelessWidget {
  AllClientsDisplay({super.key});

  final dietMakingController = Get.put(DietMakingController());

  @override
  Widget build(BuildContext context) {
    var dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: const CustomAppBar(showBackArrow: false, title: "Clients"),
      body: dietMakingController.coachClients.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: dietMakingController.coachClients.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Get.to(() => PlayerOverviewPage(
                                index: index,
                              ));
                        },
                        splashColor: Colors.green,
                        splashFactory: InkRipple.splashFactory,
                        child: Card(
                          color:
                              dark ? const Color(0xFF1C1C1E) : CColors.primary,
                          child: ListTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  myServices.sharedPreferences.getInt("user") !=
                                          dietMakingController
                                              .coachClients[index].id
                                      ? "Client: ${dietMakingController.coachClients[index].firstName}${dietMakingController.coachClients[index].secondName}"
                                      : "Its You",
                                  style: const TextStyle(color: Colors.white),
                                ),
                                Icon(
                                  CupertinoIcons.smallcircle_fill_circle_fill,
                                  color: dietMakingController
                                              .coachClients[index].isActive ==
                                          1
                                      ? Colors.green
                                      : Colors.white,
                                  size: 22,
                                ),
                              ],
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Username: ${dietMakingController.coachClients[index].username}',
                                  style: const TextStyle(color: Colors.white),
                                ),
                                Text(
                                  'Email: ${dietMakingController.coachClients[index].email}',
                                  style: const TextStyle(color: Colors.white),
                                ),
                                Text(
                                  'Subscription Date: ${dietMakingController.coachClients[index].subscriptionDate.year}-${dietMakingController.coachClients[index].subscriptionDate.month.toString().padLeft(2, '0')}-${dietMakingController.coachClients[index].subscriptionDate.day.toString().padLeft(2, '0')}',
                                  style: const TextStyle(color: Colors.white),
                                ),
                                Text(
                                  'Subscription Lenth: ${dietMakingController.coachClients[index].subscriptionLenth} Month',
                                  style: const TextStyle(color: Colors.white),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Current Stage: ${dietMakingController.coachClients[index].currentStep == 0 ? "Form Completion" : dietMakingController.coachClients[index].currentStep == 1 ? "Plan To Put Now" : "Client On The Plan"}',
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                    InkWell(
                                        onTap: () {
                                          dietMakingController.sendMessage(
                                              "I'm your Coach",
                                              "Dont Forget To Finsh Your Form",
                                              dietMakingController
                                                  .coachClients[index]
                                                  .fireBaseToken);
                                        },
                                        child: dietMakingController
                                                    .coachClients[index]
                                                    .currentStep ==
                                                0
                                            ? const Row(
                                                children: [
                                                  Icon(
                                                    Icons.notifications,
                                                    size: 20,
                                                    color: Colors.white,
                                                  ),
                                                  Text(
                                                    "Notifiy Client",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 11),
                                                  )
                                                ],
                                              )
                                            : dietMakingController
                                                        .coachClients[index]
                                                        .currentStep ==
                                                    1
                                                ? const Row(
                                                    children: [
                                                      Icon(
                                                        Icons.notifications,
                                                        size: 20,
                                                        color: Colors.white,
                                                      ),
                                                      Text(
                                                        "Notifiy Client",
                                                        style: TextStyle(
                                                            fontSize: 11,
                                                            color:
                                                                Colors.white),
                                                      )
                                                    ],
                                                  )
                                                : const Row(
                                                    children: [
                                                      Icon(
                                                        Icons.notifications,
                                                        size: 20,
                                                      ),
                                                      Text(
                                                        "Notifiy Client",
                                                        style: TextStyle(
                                                            fontSize: 11),
                                                      )
                                                    ],
                                                  ))
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),

                  // Container(
                  //   padding: EdgeInsets.symmetric(horizontal: 12.w),
                  //   width: double.maxFinite,
                  //   child: MaterialButton(
                  //     shape: const OutlineInputBorder(
                  //       borderRadius: BorderRadius.horizontal(
                  //         left: Radius.circular(5),
                  //         right: Radius.circular(5),
                  //       ),
                  //     ),
                  //     onPressed: () async {
                  //
                  //      },
                  //     color: const Color(0xFF1D82EA),
                  //     child: const Text(
                  //       'Start Routine',
                  //       style: TextStyle(color: Colors.white),
                  //     ),
                  //   ),
                  // )
                ],
              ),
            ),
    );
  }
}
