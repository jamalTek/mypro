import '../../../general_exports.dart';

class AccountController extends GetxController {
  List<Map> items = [
    {
      kTitle: 'Profile',
      kIcon: Assets.assetsIconsPerson,
      kOnPress: () {
        Get.toNamed(routeProfile);
      },
      kIsVisible: box.read(kUserData) != null,
    },
    {
      kTitle: 'Settings',
      kIcon: Assets.assetsIconsSettings,
      kOnPress: () {
        Get.toNamed(routeSettings);
      }
    },
    {
      kTitle: 'Masbaha',
      kIcon: Assets.assetsIconsMasbaha,
      kOnPress: () {
        Get.toNamed(routeMasbaha);
      }
    },
    {
      kTitle: 'Prophet Biography',
      kIcon: Assets.assetsIconsDoc,
      kOnPress: () {
        Get.toNamed(routeProphetBiography);
      }
    },
    {
      kTitle: 'Favorite',
      kIcon: Assets.assetsIconsHeart,
      //kIsVisible: box.read(kUserData) != null,
      kOnPress: () {
        Get.toNamed(routeFavorites);
      }
    },
    {
      kTitle: 'About us',
      kIcon: Assets.assetsIconsBuilding,
      kIsVisible: false,
      kOnPress: () {
        Get.back();
      }
    },
    {
      kTitle: 'About app',
      kIcon: Assets.assetsIconsInfo,
      kOnPress: () {
        Get.toNamed(
          routeWeb,
          arguments: {
            kUrl: 'https://merath-alnabi.com/ar/web-views/about-app',
            kTitle: 'About app',
          },
        );
      }
    },
    {
      kTitle: 'Contact us',
      kIcon: Assets.assetsIconsInfo,
      kOnPress: () {
        Get.toNamed(
          routeWeb,
          arguments: {
            kUrl: 'https://merath-alnabi.com/en/web-views/contact',
            kTitle: 'Contact us',
          },
        );
      }
    },
    {
      kTitle: 'Terms and conditions',
      kIcon: Assets.assetsIconsShield,
      kOnPress: () {
        Get.toNamed(
          routeWeb,
          arguments: {
            kUrl: 'https://merath-alnabi.com/ar/web-views/terms',
            kTitle: 'Terms and conditions',
          },
        );
      }
    },
    {
      kTitle: 'Privacy policy',
      kIcon: Assets.assetsIconsLines3,
      kOnPress: () {
        Get.toNamed(
          routeWeb,
          arguments: {
            kUrl: 'https://merath-alnabi.com/ar/web-views/privacy-policy',
            kTitle: 'Privacy policy',
          },
        );
      }
    },
    {
      kTitle: 'Logout',
      kIcon: Assets.assetsIconsLogout,
      kIsVisible: box.read(kUserData) != null,
      kOnPress: () {
        box.write(kUserData, null);
        Get.offAllNamed(routeLogin);
      },
      kColor: MerathColors.red,
    },
  ];
}
