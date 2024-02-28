import 'dart:async';

import '../../../general_exports.dart';

class VirtuesOfDeedsController extends GetxController {
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

  void onSearchChange() {
    const duration = Duration(seconds: 1);
    if (searchOnStoppedTyping != null) {
      searchOnStoppedTyping!.cancel(); // clear timer
    }
    searchOnStoppedTyping =
        Timer(duration, () => searchContent(searchContrller.text));
  }

  void getData() {
    getCategories();
  }

  void getCategories() {
    isLoading = true;
    ApiRequest(
      path: apiVirtuesOfDeedsCategories,
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
      path: apiVirtuesOfDeeds,
      method: getMethod,
      formatResponse: true,
      queryParameters: {
        kCategory: categories[selectedCategory][kId],
      },
    ).request(
      onSuccess: (data, response) {
        content = data;
        isLoading = false;
        update();
      },
    );
  }

  void searchContent(String toSearch) {
    if (toSearch.isEmpty) {
      return;
    }
    isLoading = true;
    selectedCategory = -1;
    update();
    ApiRequest(
      path: '$apiVirtuesOfDeedsSearch/$toSearch',
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
    final List fav = box.read(kScientificContent) ?? [];
    item[kIsFavorite] = !item[kIsFavorite];
    update();
    if (item[kIsFavorite]) {
      fav.add(item);
      box.write(kScientificContent, fav);
      ApiRequest(
        path: apiFavorite,
        method: postMethod,
        shouldShowMessage: false,
        body: {
          kType: kScientificContent,
          kReferenceId: item[kId],
        },
      ).request(
        onSuccess: (data, response) {},
      );
    } else {
      fav.removeWhere((element) => element[kId] == item[kId]);
      box.write(kScientificContent, fav);
      ApiRequest(
        path: '$apiFavorite/${item[kId]}/$kScientificContent',
        method: deleteMethod,
        shouldShowMessage: false,
      ).request(
        onSuccess: (data, response) {},
      );
    }
  }
}
