import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/app.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_login/bottom_navigation/bottom_navigation.dart';
import 'package:user_repository/user_repository.dart';

void main() {
  runApp(App(
    authenticationRepository: AuthenticationRepository(),
    userRepository: UserRepository(),
  ));

//    runApp(
//       MultiBlocProvider(
//           providers: [
//             BlocProvider<BottomNavigationBloc>(
//               create: (context) =>
//                   BottomNavigationBloc(),
//             ),

//           ],
//           child: App()
//       )
//   );
// }
}
