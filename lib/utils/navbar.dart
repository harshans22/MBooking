import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movieticket/screens/events.dart';
import 'package:movieticket/screens/homescreen.dart';
import 'package:movieticket/screens/profile.dart';
import 'package:movieticket/screens/ticketscreen.dart';
import 'package:movieticket/utils/color.dart';
import 'package:movieticket/widgets/tikcet.dart';

import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';


class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
 PersistentTabController _controller= PersistentTabController(initialIndex: 0);



   List<Widget> _buildScreens() {
        return [
        const  Homescreen(name:"harsg" ,),
        const  TicketScreen(),
        const  EventsScreen(),
        const  ProfileScreen()
        ];
    }

   List<PersistentBottomNavBarItem> _navBarsItems() {
        return [
            PersistentBottomNavBarItem(
                icon:const Icon(CupertinoIcons.home),
                title: ("Home"),
                activeColorPrimary: appthemecolor,
                inactiveColorPrimary: CupertinoColors.systemGrey,
            ),
            PersistentBottomNavBarItem(
                icon:const Icon(CupertinoIcons.ticket),
                title: ("Tickets"),
                activeColorPrimary: appthemecolor,
                inactiveColorPrimary: CupertinoColors.systemGrey,
            ),
            PersistentBottomNavBarItem(
                icon:const Icon(CupertinoIcons.video_camera),
                title: ("Live events"),
                activeColorPrimary: appthemecolor,
                inactiveColorPrimary: CupertinoColors.systemGrey,
            ),
            PersistentBottomNavBarItem(
                icon:const Icon(CupertinoIcons.person),
                title: ("Profile"),
                activeColorPrimary: appthemecolor,
                inactiveColorPrimary: CupertinoColors.systemGrey,
            ),
           
        ];
    }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      
        context,
      //  padding: NavBarPadding.symmetric(vertical: 20),
   
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: greycolorshade1, // Default is Colors.white.
        handleAndroidBackButtonPress: true, // Default is true.
        resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      //  stateManagement: false, // Default is true.
        hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
        decoration: NavBarDecoration(
        //  border: Border.all(color: appthemecolor),
          borderRadius: BorderRadius.circular(10.0),
         // colorBehindNavBar: Colors.transparent,
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: ItemAnimationProperties( // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 200),
          curve: Curves.easeInOut,
        ),
        screenTransitionAnimation: ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          curve: Curves.easeInOut,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle: NavBarStyle.style1, // Choose the nav bar style with this property.
    );
  }
}