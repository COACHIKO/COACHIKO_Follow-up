import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:followupapprefactored/features/modules/client/phases_cases/form_completion/ui/form_completion.dart';
import '../features/auth/login/ui/login_screen.dart';
import '../features/auth/signup/ui/signup_screen.dart';
import '../features/modules/client/navigation_bar/ui/client_navigation_bar.dart';
import '../features/modules/client/phases_cases/waiting_phase/data/repository/current_state_repo_impl.dart';
import '../features/modules/client/phases_cases/waiting_phase/logic/cubit/current_stage_cubit.dart';
import '../features/modules/client/phases_cases/waiting_phase/ui/current_stage_page.dart';
import '../features/modules/coach/navigation_bar/ui/coach_navigation_bar.dart';
import '../view/screens/fork_usering_page.dart';
import 'di/dependency_injection.dart';

class AppRouter {
  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/forkUsering':
        return MaterialPageRoute(builder: (_) => const ForkUseringPage());
      case '/signup':
        return MaterialPageRoute(builder: (_) => const SignUpPage());
      case '/login':
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case '/formCompletion':
        return MaterialPageRoute(builder: (_) => const FormComplectionView());
      case '/currentStage':
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => CurrentStageCubit(
                currentStateRepoImpl: sl<CurrentStateRepoImpl>())
              ..getCurrentStage(),
            child: const CurrentStage(),
          ),
        );
      case '/ClientHome':
        return MaterialPageRoute(builder: (_) => const ClientNavigationBar());
      case '/CoachHome':
        return MaterialPageRoute(builder: (_) => const CoachNavigationBar());
      default:
        return MaterialPageRoute(builder: (_) => const ForkUseringPage());
    }
  }
}
