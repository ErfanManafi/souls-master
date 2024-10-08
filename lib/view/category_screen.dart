import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:souls_master/constants/scaffold_bg.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:animate_do/animate_do.dart';
import 'package:get/get.dart';
import 'package:souls_master/controller/category_controller.dart';
import 'package:souls_master/model/category_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    CategoryController categoryController = Get.find<CategoryController>();
    final textTheme = Theme.of(context).textTheme;

    final categoryId = Get.parameters['id'];

    final CategoryModel? categoryList = categoryController.categories
        .firstWhereOrNull((category) => category.id == categoryId);

    return Scaffold(
      body: GradientBackground(
        child: CustomScrollView(
          slivers: [
            _buildSliverAppBar(
                categoryList!.category, categoryList.poster, categoryId),
            SliverToBoxAdapter(
              child: _buildCategoryContent(textTheme, categoryList),
            ),
          ],
        ),
      ),
    );
  }

  // Custom SliverAppBar with animation and hero effect for the image
  Widget _buildSliverAppBar(
      String categoryTitle, String categoryPoster, String? categoryId) {
    return SliverAppBar(
      expandedHeight: 300.0,
      floating: false,
      pinned: true,
      backgroundColor: Colors.transparent,
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: FadeInDown(
          duration: const Duration(milliseconds: 800),
          child: Text(
            categoryTitle,
            style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: [
                Shadow(
                  offset: const Offset(2.0, 2.0),
                  blurRadius: 5.0,
                  color: Colors.black.withOpacity(0.5),
                ),
              ],
            ),
          ),
        ),
        background: Hero(
          tag: 'categoryHero_$categoryId',
          child: CachedNetworkImage(
            imageUrl: categoryPoster,
            fit: BoxFit.cover,
            placeholder: (context, url) => const Center(
              child: SpinKitFadingCircle(
                color: Colors.white,
                size: 40,
              ),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
      ),
    );
  }

  // Build the main content of the category page
  Widget _buildCategoryContent(
      TextTheme textTheme, CategoryModel categoryList) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FadeInUp(
            duration: const Duration(milliseconds: 800),
            child: Text(
              categoryList.smallTitle, // Dynamic title
              style: textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 16),
            ),
          ),

          const SizedBox(height: 10),

          FadeInUp(
            duration: const Duration(milliseconds: 900),
            child: const Divider(
              color: Colors.white,
              thickness: 2,
              endIndent: 40,
              indent: 40,
            ),
          ),

          const SizedBox(height: 20),

          // Pass categoryList to the section builder
          _buildCategoryContentSection(textTheme, categoryList),
        ],
      ),
    );
  }

  // Build the section for the category content
  Widget _buildCategoryContentSection(
      TextTheme textTheme, CategoryModel categoryList) {
    return CategoryContentWidget(categoryList: categoryList);
  }
}

// Widget to handle HTML content caching and rendering
class CategoryContentWidget extends StatefulWidget {
  final CategoryModel categoryList;

  const CategoryContentWidget({super.key, required this.categoryList});

  @override
  // ignore: library_private_types_in_public_api
  _CategoryContentWidgetState createState() => _CategoryContentWidgetState();
}

class _CategoryContentWidgetState extends State<CategoryContentWidget> {
  String? cachedHtmlContent;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadContent();
  }

  Future<void> _loadContent() async {
    final prefs = await SharedPreferences.getInstance();
    String? savedHtmlContent =
        prefs.getString('cached_html_${widget.categoryList.id}');

    if (savedHtmlContent != null) {
      // Use cached content if available
      setState(() {
        cachedHtmlContent = savedHtmlContent;
        isLoading = false;
      });
    } else {
      // Otherwise, load from categoryList and cache it
      _cacheHtmlContent(widget.categoryList.content);
    }
  }

  Future<void> _cacheHtmlContent(String content) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('cached_html_${widget.categoryList.id}', content);

    setState(() {
      cachedHtmlContent = content;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    if (isLoading) {
      return const Center(
          child: SpinKitFadingCircle(
        color: Colors.white,
        size: 40,
      ));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StaggeredFadeIn(
          index: 0,
          child: HtmlWidget(
            '<div style="text-align: justify;">$cachedHtmlContent</div>',
            enableCaching: true, // In-memory caching during the session
            textStyle: textTheme.displaySmall!.copyWith(
              fontSize: 14,
              height: 1.8,
            ),
          ),
        ),
      ],
    );
  }
}

// A custom widget for staggered fade-in animations
class StaggeredFadeIn extends StatelessWidget {
  final Widget child;
  final int index;

  const StaggeredFadeIn({super.key, required this.child, required this.index});

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      delay: Duration(milliseconds: 300 * index),
      duration: const Duration(milliseconds: 700),
      child: child,
    );
  }
}
