import 'package:flutter/material.dart';
import 'package:souls_master/components/home_widgets.dart';
import 'package:souls_master/constants/my_strings.dart';
import 'package:souls_master/constants/scaffold_bg.dart';

final GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return Scaffold(
      key: globalKey, // Assign the GlobalKey to the Scaffold
      extendBodyBehindAppBar: true,
      appBar: buildAppBar(textTheme), // Use the AppBar widget
      drawer: buildDrawer(context),
      body: GradientBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 110, bottom: 40),
            child: Column(
              children: [
                const BuildCarouselSlider(),
                const SizedBox(height: 25),
                categoryTransparentList(),
                buildTitleRow(MyStrings.allBossFights, textTheme),
                buildHorizontalArticleList(textTheme,
                    isFirstList: false, addRightMargin: true),
                buildTitleRow(MyStrings.allLocationsTitle, textTheme),
                buildHorizontalLocationList(textTheme,
                    isFirstList: false, addRightMargin: true),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
