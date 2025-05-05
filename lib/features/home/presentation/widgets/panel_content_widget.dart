import 'package:flutter/material.dart';
import 'package:zilant_look/config/theme/app_colors.dart';
import 'package:zilant_look/features/home/presentation/widgets/catalog_tab.dart';
import 'package:zilant_look/features/home/presentation/widgets/wardrobe_tab.dart';
import 'package:animations/animations.dart';

class PanelContentWidget extends StatelessWidget {
  final int selectedTabIndex;
  final Function(int) onTabSelected;
  final ScrollController catalogScrollController;
  final ScrollController wardrobeScrollController;

  const PanelContentWidget({
    super.key,
    required this.selectedTabIndex,
    required this.onTabSelected,
    required this.catalogScrollController,
    required this.wardrobeScrollController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20,
          child: Center(
            child: Container(
              height: 5,
              width: 230,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 217, 217, 217),
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24.0),
                topRight: Radius.circular(24.0),
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    _buildTabButton('Каталог', 0),
                    _buildTabButton('Гардероб', 1),
                  ],
                ),
                Expanded(
                  child: PageTransitionSwitcher(
                    duration: const Duration(milliseconds: 400),
                    transitionBuilder: (child, animation, secondaryAnimation) {
                      return SharedAxisTransition(
                        animation: animation,
                        secondaryAnimation: secondaryAnimation,
                        transitionType: SharedAxisTransitionType.horizontal,
                        child: child,
                      );
                    },
                    child:
                        selectedTabIndex == 0
                            ? CatalogTab(
                              key: const ValueKey('catalog'),
                              scrollController: catalogScrollController,
                            )
                            : WardrobeTab(
                              key: const ValueKey('wardrobe'),
                              scrollController: wardrobeScrollController,
                            ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTabButton(String title, int index) {
    bool isSelected = selectedTabIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => onTabSelected(index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primaryColor : Colors.white,
            borderRadius:
                index == 0
                    ? const BorderRadius.only(
                      topLeft: Radius.circular(24.0),
                      bottomRight: Radius.circular(24.0),
                    )
                    : const BorderRadius.only(
                      topRight: Radius.circular(24.0),
                      bottomLeft: Radius.circular(24.0),
                    ),
          ),
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'SFPro-Medium',
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
