import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/authentication/bloc/authentication_bloc.dart';
import 'package:flutter_login/bottom_navigation/bottom_navigation.dart';
import 'package:listing_repository/listing_repository.dart';
import 'package:calculator_repository/calculator_repository.dart';

import '../../bottom_navigation/bottom_navigation.dart';

class HomePage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HomePage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BottomNavigationBloc(
        listingRepository: ListingRepository(),
        calculatorRepository: CalculatorRepository(),
      ),
      child: HomeView(),
    );
  }
}

// MultiBlocProvider(
//   providers: [
//     BlocProvider<BlocA>(
//       create: (BuildContext context) => BlocA(),
//     ),
//     BlocProvider<BlocB>(
//       create: (BuildContext context) => BlocB(),
//     ),
//     BlocProvider<BlocC>(
//       create: (BuildContext context) => BlocC(),
//     ),
//   ],
//   child: ChildA(),
// )

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Home')),
        // body: BlocProvider<BottomNavigationBloc>(
        //   create: (context) => BottomNavigationBloc(),
        // ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Builder(
                builder: (context) {
                  final userId = context.select(
                    (AuthenticationBloc bloc) => bloc.state.user.id,
                  );
                  final state = context.select(
                    (BottomNavigationBloc bloc) => bloc.state,
                  );
                  if (state is PageLoading) {
                    return Text('Initial Page load text : $userId');
                  }
                  if (state is FirstPageLoaded) {
                    return Text('Clicked on First: $userId');
                  }
                  if (state is SecondPageLoaded) {
                    return Text('Clicked on Second: $userId');
                  }
                  if (state is ThirdPageLoaded) {
                    return Text('Clicked on Third: $userId');
                  }
                  return Container();
                },
              ),
              ElevatedButton(
                child: const Text('Logout'),
                onPressed: () {
                  context
                      .read<AuthenticationBloc>()
                      .add(AuthenticationLogoutRequested());
                },
              ),
            ],
          ),
        ),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              DrawerHeader(
                child: Text('Drawer Header'),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
              ),
              ListTile(
                title: Text('Item 1'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                title: Text('Item 2'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          // ignore: lines_longer_than_80_chars
          currentIndex: context.select((BottomNavigationBloc bloc) =>
              bloc.currentIndex), // this will be set when a new tab is tapped

          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.list_alt),
              label: 'Listing',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.calculate),
              label: 'Estimator',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favourites',
            ),
          ],
          onTap: (index) => context
              .read<BottomNavigationBloc>()
              .add(PageTapped(index: index)),
        ));
  }
}
