import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hotel/presentation/pages/allTab.dart';
import 'package:hotel/presentation/pages/currentTab.dart';
import 'package:hotel/presentation/pages/pendingTab.dart';
import 'package:hotel/presentation/provider/statusRoom_provider.dart';
import 'package:hotel/presentation/widgets/menuDrawer_widget.dart';
import 'package:provider/provider.dart';

import 'cleanedTab.dart';

class HomeRoomsUser extends StatefulWidget {
  @override
  _HomeRoomsUserState createState() => _HomeRoomsUserState();
}

class _HomeRoomsUserState extends State<HomeRoomsUser>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int _tabIndex = 0;
  TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 4);
  }

  void _toggleTab() {
    _tabIndex = _tabController.index - 1;
    _tabController.animateTo(_tabIndex);

  }


  @override
  Widget build(BuildContext context) {
      final roomModel = Provider.of<StatusRoom>(context);

    return Scaffold(
      key: _scaffoldKey,
      drawer: MenuWidget(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white24,
        leading: IconButton(
          icon: Icon(
            FontAwesomeIcons.alignLeft,
            color: Colors.black,
            size: 30,
          ),
          onPressed: () => _scaffoldKey.currentState.openDrawer(),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Column(
          children: [
            ListTile(
              title: Text(
                'HouseKeeping',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 32,
                    fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'Keep every room clean.',
                style: TextStyle(fontSize: 15),
              ),
            ),
            SizedBox(height: 30),
            Expanded(
              child: NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverPersistentHeader(
                      delegate: _SliverAppBarDelegate(
                        TabBar(
                          physics: NeverScrollableScrollPhysics(),
                          controller: _tabController,
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                          indicatorColor: Colors.white24,
                          labelColor: Colors.blue,
                          unselectedLabelColor: Colors.black,
                          tabs: [
                            Tab(text: "All"),
                            Tab(text: "Current"),
                            Tab(text: "Pending"),
                            Tab(text: "Cleaned"),
                          ],
                        ),
                      ),
                      pinned: true,
                    ),
                  ];
                },
                body: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  controller: _tabController,
                  children: <Widget>[
                    AllTab(),
                    CurrentTab(roomModel.room),
                    PendingTab(_toggleTab),
                    CleanedTab()
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      color: Colors.white,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
