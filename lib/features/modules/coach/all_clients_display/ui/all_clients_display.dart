import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:followupapprefactored/view/widgets/custom_appbar.dart';
import '../../../../../../core/utils/constants/colors.dart';
import '../../../../../../core/utils/helpers/helper_functions.dart';
import '../../../../../core/services/shared_pref/shared_pref.dart';
import '../../specific_client_profile/ui/client_profile_page.dart';
import '../logic/cubit/clients_cubit.dart';
import '../logic/cubit/clients_state.dart';

class MyClients extends StatelessWidget {
  const MyClients({super.key});

  @override
  Widget build(BuildContext context) {
    var dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: const CustomAppBar(showBackArrow: false, title: "Clients"),
      body: BlocBuilder<ClientsCubit, ClientState>(
        builder: (context, state) {
          if (state is ClientsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ClientsError) {
            return Center(child: Text('Error: ${state.error}'));
          } else if (state is ClientsLoadedSuccessfully) {
            if (state.clients.isEmpty) {
              return const Center(child: Text('No Clients available'));
            } else {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: state.clients.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ClientProfilePage(
                            clientData: state.clients[index],
                          ),
                        ),
                      );
                    },
                    splashColor: Colors.green,
                    splashFactory: InkRipple.splashFactory,
                    child: Card(
                      color: dark ? const Color(0xFF1C1C1E) : CColors.primary,
                      child: ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              SharedPref().getInt("user") !=
                                      state.clients[index].id
                                  ? "Client: ${state.clients[index].firstName}${state.clients[index].secondName}"
                                  : "Its You",
                              style: const TextStyle(color: Colors.white),
                            ),
                            Icon(
                              CupertinoIcons.smallcircle_fill_circle_fill,
                              color: state.clients[index].isActive == 1
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
                              'Username: ${state.clients[index].username}',
                              style: const TextStyle(color: Colors.white),
                            ),
                            Text(
                              'Email: ${state.clients[index].email}',
                              style: const TextStyle(color: Colors.white),
                            ),
                            Text(
                              'Subscription Date: ${state.clients[index].subscriptionDate!.year}-${state.clients[index].subscriptionDate!.month.toString().padLeft(2, '0')}-${state.clients[index].subscriptionDate!.day.toString().padLeft(2, '0')}',
                              style: const TextStyle(color: Colors.white),
                            ),
                            Text(
                              'Subscription Lenth: ${state.clients[index].subscriptionLength} Month',
                              style: const TextStyle(color: Colors.white),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Current Stage: ${state.clients[index].currentStep == 0 ? "Form Completion" : state.clients[index].currentStep == 1 ? "Plan To Put Now" : "Client On The Plan"}',
                                  style: const TextStyle(color: Colors.white),
                                ),
                                GestureDetector(
                                    onTap: () {
                                      BlocProvider.of<ClientsCubit>(context)
                                          .sendMessage(
                                              "I'm your Coach",
                                              "Dont Forget To Finsh Your Form",
                                              state.clients[index]
                                                  .fireBaseToken);
                                    },
                                    child: state.clients[index].currentStep == 0
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
                                        : state.clients[index].currentStep == 1
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
                                                        color: Colors.white),
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
                                                    style:
                                                        TextStyle(fontSize: 11),
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
              );
            }
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
