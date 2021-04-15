import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hotel/presentation/pages/currentTab.dart';
import 'package:hotel/presentation/pages/pendingTab.dart';
import 'package:hotel/presentation/widgets/menuDrawer_widget.dart';
import 'package:hotel/presentation/widgets/percentIndicator_widget.dart';

class HomeRoomsUser extends StatefulWidget {
  @override
  _HomeRoomsUserState createState() => _HomeRoomsUserState();
}

class _HomeRoomsUserState extends State<HomeRoomsUser>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
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
              child: DefaultTabController(
                length: 4,
                child: NestedScrollView(
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    return <Widget>[
                      SliverPersistentHeader(
                        delegate: _SliverAppBarDelegate(
                          TabBar(
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
                    children: <Widget>[
                     
                      Container(
                        child: Row(children: [PercentIndicator()]),
                      ),
                     CurrentTab(),
                      PendingTab(),
                      Container(
                        child: Row(children: [PercentIndicator()]),
                      )
                    ],
                  ),
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
      color: Colors.white, // ADD THE COLOR YOU WANT AS BACKGROUND.
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
