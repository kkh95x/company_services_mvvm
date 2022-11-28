import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mvvm_desgin_app/presentation/main/pages/home/view/home.dart';
import 'package:mvvm_desgin_app/presentation/main/pages/notifaction/notifaction.dart';
import 'package:mvvm_desgin_app/presentation/main/pages/search/search.dart';
import 'package:mvvm_desgin_app/presentation/main/pages/setting/setting.dart';
import 'package:mvvm_desgin_app/presentation/resource/color_manager.dart';
import 'package:mvvm_desgin_app/presentation/resource/string_manager.dart';
import 'package:mvvm_desgin_app/presentation/resource/values_manager.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  List<Widget> pages = [
    HomePage(),
    NotifactionPage(),
    SearchPage(),
    SettingPage()
  ];
   List<String> titles = [
    AppString.homePage,
    AppString.notifaction,
    AppString.search,
    AppString.setting,

  ];
  int _currentIndex = 0;
  String _title=AppString.homePage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title,style: Theme.of(context).textTheme.titleSmall,),
        centerTitle: true,
        ),
        body: pages[_currentIndex],
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            boxShadow:[BoxShadow(color: ColorManager.lightGrey,spreadRadius: AppSize.s1)]
             ),
          child: BottomNavigationBar(
            selectedItemColor: ColorManager.primary,
            unselectedItemColor: ColorManager.darkGrey,
            currentIndex: _currentIndex,
            onTap:ontap ,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home_outlined),label: AppString.homePage),
              BottomNavigationBarItem(icon: Icon(Icons.notifications),label: AppString.notifaction),
              BottomNavigationBarItem(icon: Icon(Icons.search),label: AppString.search),
              BottomNavigationBarItem(icon: Icon(Icons.settings),label: AppString.setting),


            ],
          ),
        ),
    );
  }
  ontap(index){
    setState(() {
      _currentIndex=index;
      _title=titles[index];
    });
  }
}
