import 'package:astorage/defines/acolors.dart';
import 'package:astorage/provider/home_provider.dart';
import 'package:astorage/utils/aglobal.dart';
import 'package:astorage/widgets/aappbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:astorage/extensions/file_extensions.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with RouteAware {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      AGlobal.unsafeHeightTop = MediaQuery.of(context).padding.top;
      AGlobal.routeObserver.subscribe(this, ModalRoute.of(context));
    });
  }

  @override
  void dispose() {
    AGlobal.routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AAppBar(
        textTitle: '首页',
        noLeading: true,
      ),
      body: Consumer<HomeProvider>(
        builder: (context, homeProvider, child) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return _itemBuilder(context, homeProvider, index);
            },
            itemCount: homeProvider.files.length,
          );
        },
      ),
    );
  }

  // Navigator Observer
  @override
  void didPopNext() {
    super.didPopNext();

    print('HomePage will show.');
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    homeProvider.refresh();
  }

  Widget _itemBuilder(
    BuildContext context,
    HomeProvider homeProvider,
    int index,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      decoration: BoxDecoration(
        color: AColors.white,
      ),
      child: Text(homeProvider.files[index].name),
    );
  }
}
