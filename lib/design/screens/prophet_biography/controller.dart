import 'dart:async';

import '../../../general_exports.dart';

class ProphetBiographyController extends GetxController {
  int selectedCategory = 0;
  bool isLoading = true;

  TextEditingController searchContrller = TextEditingController();
  List categories = [];
  Timer? searchOnStoppedTyping;

  List content = [
    // {
    //   kTitle: 'This is long title',
    //   kSubtitle: 'This is long subtitle',
    //   kIsFavorite: false,
    //   kImageUrl: testImage,
    // },
  ];

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  void updateSelectedCategory(int index) {
    selectedCategory = index;
    getContents();
    update();
  }

  void getData() {
    getCategories();
  }

  void onSearchChange() {
    const duration = Duration(seconds: 1);
    if (searchOnStoppedTyping != null) {
      searchOnStoppedTyping!.cancel(); // clear timer
    }
    searchOnStoppedTyping =
        Timer(duration, () => searchContent(searchContrller.text));
  }

  void getCategories() {
    isLoading = true;
    ApiRequest(
      path: apiProphetBiographyCategories,
      method: getMethod,
    ).request(
      onSuccess: (data, response) {
        categories = data;
        getContents();
      },
    );
  }

  void getContents() {
    isLoading = true;
    ApiRequest(
      path: apiProphetBiography,
      method: getMethod,
      formatResponse: true,
      queryParameters: {
        kCategory: categories[selectedCategory][kId],
      },
    ).request(
      onSuccess: (data, response) {
        content = data;
        consoleLog(content);
        isLoading = false;
        update();
      },
    );
  }

  void searchContent(String toSearch) {
    if (searchContrller.text.isEmpty) {
      return;
    }
    isLoading = true;
    selectedCategory = -1;
    update();
    ApiRequest(
      path: '$apiProphetBiographySearch/$toSearch',
      method: getMethod,
    ).request(
      onSuccess: (data, response) {
        content = data;
        isLoading = false;
        update();
      },
      onError: (error) {
        isLoading = false;
        update();
        reset();
      },
    );
  }

  void reset() {
    updateSelectedCategory(0);
    getContents();
  }

  void toggleFavorite(Map item) {
    final List fav = box.read(kProphetBiography) ?? [];
    item[kIsFavorite] = !item[kIsFavorite];
    update();
    if (item[kIsFavorite]) {
      fav.add(item);
      box.write(kProphetBiography, fav);
      ApiRequest(
        path: apiFavorite,
        method: postMethod,
        shouldShowMessage: false,
        body: {
          kType: kProphetBiography,
          kReferenceId: item[kId],
        },
      ).request(
        onSuccess: (data, response) {},
      );
    } else {
      fav.removeWhere((element) => element[kId] == item[kId]);
      box.write(kProphetBiography, fav);
      ApiRequest(
        path: '$apiFavorite/${item[kId]}/$kProphetBiography',
        method: deleteMethod,
        shouldShowMessage: false,
      ).request(
        onSuccess: (data, response) {},
      );
    }
  }
}
