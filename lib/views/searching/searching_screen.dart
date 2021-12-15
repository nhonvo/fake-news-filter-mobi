import 'package:fake_news/views/breaking/breaking_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

class Searching extends StatefulWidget {
  const Searching({Key? key}) : super(key: key);

  @override
  _SearchingState createState() => _SearchingState();
}

class _SearchingState extends State<Searching> {
  BreakingViewModel get viewmodel => Get.find<BreakingViewModel>();

  @override
  Widget build(BuildContext context) {
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return Obx(() {
      return FloatingSearchBar(
        automaticallyImplyBackButton: true,
        leadingActions: [
          FloatingSearchBarAction.back(),
        ],
        hint: 'Search...',
        scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
        transitionDuration: const Duration(milliseconds: 800),
        transitionCurve: Curves.easeInOut,
        physics: const BouncingScrollPhysics(),
        axisAlignment: isPortrait ? 0.0 : -1.0,
        openAxisAlignment: 0.0,
        width: isPortrait ? 600 : 500,
        debounceDelay: const Duration(milliseconds: 500),
        progress: viewmodel.isSearching.value,
        onQueryChanged: (query) {
          viewmodel.search(query);
        },
        // Specify a custom transition to be used for
        // animating between opened and closed stated.
        transition: CircularFloatingSearchBarTransition(),
        actions: [
          FloatingSearchBarAction(
            showIfOpened: false,
            child: CircularButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                print('Search');
              },
            ),
          ),
          FloatingSearchBarAction.searchToClear(
            showIfClosed: false,
          ),
        ],
        builder: (context, transition) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Material(
              color: Colors.white,
              elevation: 4.0,
              child: Obx(() {
                return Column(mainAxisSize: MainAxisSize.min, children: [
                  for (var item in viewmodel.searchingNews)
                    InkWell(
                      onTap: () {
                        // FloatingSearchBar.of(context)!.close();
                        print(item?.name);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          title: Text(item?.name ?? ""),
                          subtitle: Text(item?.description.toString().substring(
                                  0, item.description!.length > 50 ? 50 : item.description.toString().length) ??
                              ""),
                        ),
                      ),
                    ),
                ]);
              }),
            ),
          );
        },
      );
    });
  }
}
