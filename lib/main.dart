import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Assignment',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'Flutter Assignment'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;
  final List<String> _tabs = ['First', 'Second'];

  MyHomePage({this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverAppBar(
                  title: Text(title),
                  centerTitle: true,
                  elevation: 8,
                  floating: true,
                  pinned: false,
                  stretch: true,
                  titleSpacing: 8,
                  expandedHeight: MediaQuery.of(context).size.height * 0.4,
                  forceElevated: innerBoxIsScrolled,
                  bottom: TabBar(
                    tabs: _tabs
                        .map((e) => Tab(
                              text: e,
                            ))
                        .toList(),
                  ),
                ),
              )
            ];
          },
          body: TabBarView(
              children: _tabs
                  .map(
                    (e) => SafeArea(
                      bottom: false,
                      top: false,
                      child: Builder(
                        builder: (BuildContext context) {
                          return CustomScrollView(
                            key: PageStorageKey<String>(e),
                            slivers: [
                              SliverOverlapInjector(
                                handle: NestedScrollView
                                    .sliverOverlapAbsorberHandleFor(context),
                              ),
                              SliverPadding(
                                padding: const EdgeInsets.all(8.0),
                                sliver: SliverFixedExtentList(
                                    delegate: SliverChildBuilderDelegate(
                                        (BuildContext context, int index) {
                                      return Card(
                                        child: Container(
                                          child: ListTile(
                                            title: Text('$index'),
                                          ),
                                        ),
                                      );
                                    }, childCount: 100),
                                    itemExtent: 50),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  )
                  .toList()),
        ),
      ),
    );
  }
}
