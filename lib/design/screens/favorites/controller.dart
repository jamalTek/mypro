import '../../../general_exports.dart';

class FavoritesController extends GetxController {
  List types = [
    {
      kTitle: 'Virtues of deeds',
      kType: kScientificContent,
    },
    {
      kTitle: 'Prophet biography',
      kType: kProphetBiography,
    },
  ];
  int selectedIndex = 0;
  List items = [];

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  void updateSelectedType(Map type) {
    selectedIndex = types.indexOf(type);
    update();
    getData();
  }

  void getData() {
    startLoading();
    if (Get.find<UserController>().userData == null) {
      items = box.read(types[selectedIndex][kType]) ?? [];
      update();
      dismissLoading();
      return;
    }
    ApiRequest(
      path: apiFavorite,
      method: getMethod,
      queryParameters: {
        kType: types[selectedIndex][kType],
      },
    ).request(
      onSuccess: (data, response) {
        dismissLoading();
        items = data;
        for (Map i in items) {
          i[kIsFavorite] = true;
        }
        update();
      },
    );
  }

  void toggleFavorite(Map item) {
    item[kIsFavorite] = !item[kIsFavorite];
    update();

    if (item[kIsFavorite]) {
      items.add(item);
      box.write(types[selectedIndex][kType], items);
      ApiRequest(
        path: apiFavorite,
        method: postMethod,
        shouldShowMessage: false,
        body: {
          kType: types[selectedIndex][kType],
          kReferenceId: item[kRefId],
        },
      ).request(
        onSuccess: (data, response) {},
      );
    } else {
      items.remove(item);
      box.write(types[selectedIndex][kType], items);
      ApiRequest(
        path: '$apiFavorite/${item[kRefId]}/${types[selectedIndex][kType]}',
        method: deleteMethod,
        shouldShowMessage: false,
      ).request(
        onSuccess: (data, response) {},
      );
    }
  }
}
