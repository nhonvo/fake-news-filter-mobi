import 'dart:async';

import 'package:fake_news/resources/utils/style.dart';
import 'package:fake_news/views/breaking/breaking_viewmodel.dart';
import 'package:fake_news/views/view_news/viewnews_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

class Searching extends StatefulWidget {
  const Searching({Key? key}) : super(key: key);

  @override
  _SearchingState createState() => _SearchingState();
}

class _SearchingState extends State<Searching> {
  BreakingViewModel get viewModel => Get.find<BreakingViewModel>();

  @override
  Widget build(BuildContext context) {
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return Obx(() {
      return FloatingSearchBar(
        //automaticallyImplyBackButton: true,
        controller: viewModel.floatingSearchBarController,
        clearQueryOnClose: true,
        leadingActions: [
          FloatingSearchBarAction.back(),
        ],
        hint: 'searchNews'.tr,
        scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
        transitionDuration: const Duration(milliseconds: 800),
        transitionCurve: Curves.easeInOut,
        physics: const BouncingScrollPhysics(),
        axisAlignment: isPortrait ? 0.0 : -1.0,
        openAxisAlignment: 0.0,
        width: isPortrait ? 600 : 500,
        debounceDelay: const Duration(milliseconds: 500),
        progress: viewModel.isSearching.value,
        onQueryChanged: (query) {
          viewModel.search(query);
        },
        transition: CircularFloatingSearchBarTransition(),
        actions: [
          FloatingSearchBarAction.icon(
              showIfClosed: false,
              showIfOpened: true,
              icon: Icon(Icons.clear),
              onTap: () {
                viewModel.floatingSearchBarController
                  ..clear()
                  ..close()
                  ..clear();
              }),
        ],
        builder: (context, transition) {
          //clear result when search bar is closed
          if (viewModel.floatingSearchBarController.query.isEmpty) {
            viewModel.searchingNews.clear();
          }

          return ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Material(
              color: Colors.white,
              elevation: 4.0,
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                for (var item in viewModel.searchingNews)
                  InkWell(
                    onTap: () {
                      // FloatingSearchBar.of(context)!.close();
                      Get.to(() => ViewNewsScreen(
                            publisher: item?.publisher.toString(),
                            newsId: item!.newsId.toString(),
                            webUrl: item.urlNews,
                          ));
                    },
                    child: Container(
                      decoration: item != viewModel.searchingNews.last
                          ? BoxDecoration(border: Border(bottom: BorderSide(color: MyColors.greyLight)))
                          : null,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          title: Text(item?.title ?? "", style: StylesText.content16BoldBlack),
                          subtitle: Text(
                              '${item?.title.toString().substring(0, item.title!.length > 50 ? 50 : item.title.toString().length) ?? ""}...',
                              style: StylesText.content14LightBlack),
                        ),
                      ),
                    ),
                  ),
              ]),
            ),
          );
        },
      );
    });
  }
}
