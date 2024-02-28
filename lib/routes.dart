import 'general_exports.dart';

const String routeSplash = '/';
const String routeMain = '/main';
const String routeLogin = '/login';
const String routeArticle = '/article';
const String routeAddrReminder = '/addReminder';
const String routeAddDailyDeed = '/addDailyDeed';
const String routeDailyDeedProgress = '/addDailyDeedProgress';
const String routeAccount = '/account';
const String routeSettings = '/settings';
const String routeFavorites = '/favorites';
const String routeProphetBiography = '/prophetBiography';
const String routeMasbaha = '/masbaha';
const String routeAppLanguage = '/appLanguage';
const String routeProfile = '/profile';
const String routeWeb = '/web';

List<GetPage> routes = [
  GetPage(
    name: routeSplash,
    page: () => const Splash(),
  ),
  GetPage(
    name: routeMain,
    page: () => const MainScreen(),
  ),
  GetPage(
    name: routeLogin,
    page: () => const Login(),
  ),
  GetPage(
    name: routeArticle,
    page: () => const Article(),
  ),
  GetPage(
    name: routeAddrReminder,
    page: () => const AddReminder(),
  ),
  GetPage(
    name: routeAddDailyDeed,
    page: () => const AddDailyDeed(),
  ),
  GetPage(
    name: routeDailyDeedProgress,
    page: () => const DailyDeedProgress(),
  ),
  GetPage(
    name: routeAccount,
    page: () => const Account(),
  ),
  GetPage(
    name: routeSettings,
    page: () => const Settings(),
  ),
  GetPage(
    name: routeFavorites,
    page: () => const Favorites(),
  ),
  GetPage(
    name: routeProphetBiography,
    page: () => const ProphetBiography(),
  ),
  GetPage(
    name: routeMasbaha,
    page: () => const Masbaha(),
  ),
  GetPage(
    name: routeAppLanguage,
    page: () => const AppLanguageScreen(),
  ),
  GetPage(
    name: routeProfile,
    page: () => const Profile(),
  ),
  GetPage(
    name: routeWeb,
    page: () => const WebScreen(),
  ),
];
