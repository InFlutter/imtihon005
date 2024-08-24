import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imtihon005/screen/tab_box/screen_one/screen_one.dart';
import 'package:imtihon005/screen/tab_box/screen_two/screen_two.dart';

import '../../cubit/tab_box_cubit/tab_box_cubit.dart';

class TabBoxScreen extends StatefulWidget {
  const TabBoxScreen({super.key});

  @override
  State<TabBoxScreen> createState() => _TabBoxScreenState();
}

class _TabBoxScreenState extends State<TabBoxScreen> {
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  List<Widget> screens = [
    const ScreenOne(),
    const ScreenTwo(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TabBoxCubit, int>(
        builder: (context, state) {
          return IndexedStack(
            index: state,
            children: screens,
          );
        },
      ),
      bottomNavigationBar: BlocBuilder<TabBoxCubit, int>(
        builder: (context, state) {
          return CurvedNavigationBar(
            key: _bottomNavigationKey,
            index: state,
            items: const <Widget>[
              Icon(Icons.home,size: 24,),
              Icon(Icons.person,size: 24,)
            ],
            color: Colors.white,
            buttonBackgroundColor: Colors.white,
            backgroundColor: Colors.blueAccent,
            animationCurve: Curves.easeInOut,
            animationDuration: const Duration(milliseconds: 600),
            onTap: (index) => context.read<TabBoxCubit>().navigateToTab(index),
            letIndexChange: (index) => true,
          );
        },
      ),
    );
  }
}