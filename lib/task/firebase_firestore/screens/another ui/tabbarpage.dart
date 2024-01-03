import 'package:fb_series/task/firebase_firestore/screens/another%20ui/new_login.dart';
import 'package:fb_series/task/firebase_firestore/screens/another%20ui/register_form.dart';
import 'package:flutter/material.dart';

import '../data_showing.dart';

/// Tab controller instance
TabController? tabController;

class TabBarPage extends StatefulWidget {
  const TabBarPage({super.key});
  @override
  State<TabBarPage> createState() => _TabBarPageState();
}

class _TabBarPageState extends State<TabBarPage> with SingleTickerProviderStateMixin{

  /// scroll controller instance
  ScrollController? _scrollViewController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 3);
    _scrollViewController = ScrollController(initialScrollOffset: 0.0);
  }

  @override
  void dispose() {
    tabController?.dispose();
    _scrollViewController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: NestedScrollView(
          controller: _scrollViewController,
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              new SliverAppBar(
                title: Text('Firebase CRUD'),
                pinned: true,
                floating: true,
                bottom: TabBar(
                  controller: tabController,
                  tabs: [
                    Tab(icon: Icon(Icons.security_sharp)),
                    Tab(icon: Icon(Icons.person)),
                    Tab(icon: Icon(Icons.people))
                  ],
                ),
              )
            ];
          }, body: TabBarView(
          ///this will stop swiping
          physics: const NeverScrollableScrollPhysics(),
          controller: tabController,
          children: [
            /// tab bar views
            FormLogin(),
            FormRegister(),
            ListViewScreen(),
          ],
        ),
        ));
  }
}
