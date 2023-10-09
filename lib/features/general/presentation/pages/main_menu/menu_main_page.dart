import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:login_app/core/constant/color.dart';
import 'package:login_app/features/auth/presentation/pages/login_page.dart';
import 'package:login_app/features/general/presentation/pages/circuit_page/circuit_page.dart';
import 'package:login_app/features/general/presentation/pages/home_page/home_page.dart';
import 'package:login_app/features/general/presentation/pages/notification_page/notification_page.dart';
import 'package:login_app/features/general/presentation/pages/profile_page/profile_page.dart';

class MenuMainPage extends HookWidget {
  const MenuMainPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ValueNotifier<int> currentIndex = useState(0);
    List<Widget> screen = [
      const HomePage(),
      const CircuitPage(),
      const NotificationPage(),
      const ProfilePage(),
    ];
    List<String> title = [
      'Home',
      'Circuit',
      'Notification',
      'Profile',
    ];
    void changeBottom(int index) {
      currentIndex.value = index;
    }

    return Scaffold(
        appBar: buildAppBar(title, currentIndex, context),
        body: screen[currentIndex.value],
        bottomNavigationBar:
            buildBottomNavigationBar(currentIndex, changeBottom));
  }

  AppBar buildAppBar(List<String> title, ValueNotifier<int> currentIndex,
      BuildContext context) {
    return AppBar(
      backgroundColor: ColorManager.primaryColor,
      centerTitle: true,
      title: Text(title[currentIndex.value],
          style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontFamily: 'Urbanist',
              fontSize: 20)),
      leading: IconButton(
        icon: SvgPicture.asset('assets/images/svg/arrow-left.svg'),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => const LoginPage()));
        },
      ),
      systemOverlayStyle: SystemUiOverlayStyle.light,
      flexibleSpace: ColorFiltered(
        colorFilter:
            ColorFilter.mode(Colors.black.withOpacity(.3), BlendMode.colorBurn),
        child: Container(
            decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/png/rectangle_1.png'),
              fit: BoxFit.fill,
              opacity: 0.4),
        )),
      ),
    );
  }

  Widget buildBottomNavigationBar(
      ValueNotifier<int> currentIndex, Function(int index) changeBottom) {
    return BottomNavigationBar(
      elevation: 10.0,
      backgroundColor: Colors.white,
      selectedItemColor: ColorManager.primaryColor,
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/images/svg/home.svg',
            colorFilter: currentIndex.value == 0
                ? ColorFilter.mode(ColorManager.primaryColor,
                    BlendMode.srcIn) // Selected color
                : ColorFilter.mode(ColorManager.grayColor, BlendMode.srcIn),
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/images/svg/map.svg',
            colorFilter: currentIndex.value == 1
                ? ColorFilter.mode(ColorManager.primaryColor,
                    BlendMode.srcIn) // Selected color
                : ColorFilter.mode(ColorManager.grayColor, BlendMode.srcIn),
          ),
          label: 'Circuits',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/images/svg/notification.svg',
            colorFilter: currentIndex.value == 2
                ? ColorFilter.mode(ColorManager.primaryColor,
                    BlendMode.srcIn) // Selected color
                : ColorFilter.mode(ColorManager.grayColor, BlendMode.srcIn),
          ),
          label: 'Notification',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/images/svg/profile.svg',
            colorFilter: currentIndex.value == 3
                ? ColorFilter.mode(ColorManager.primaryColor,
                    BlendMode.srcIn) // Selected color
                : ColorFilter.mode(ColorManager.grayColor, BlendMode.srcIn),
          ),
          label: 'Profile',
        ),
      ],
      onTap: (index) {
        changeBottom(index);
      },
      currentIndex: currentIndex.value,
    );
  }
}
