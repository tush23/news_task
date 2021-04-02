import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:news_task/app/api/provider/api_handlers.dart';
import 'package:news_task/app/data/models/news_response.dart';

import '../controllers/home_controller.dart';
import 'package:news_task/app/utils/extensions.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Top Headlines'),
          actions: [
            IconButton(
                icon: Icon(Icons.lightbulb),
                onPressed: () {
                  if (Get.isDarkMode) {
                    Get.changeTheme(ThemeData.light());
                  } else {
                    Get.changeTheme(ThemeData.dark());
                  }
                })
          ],
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: controller.obx(
            (state) => state.isEmpty
                ? Center(child: Text('No Articles'))
                : ListView.separated(
                    controller: controller.scrollController,
                    itemCount: state.length + 1,
                    shrinkWrap: true,
                    itemBuilder: (ctx, i) => InkWell(
                        onTap: () => controller.launchURL(state[i].url),
                        child: i == state.length //end of the list
                            ? Center(
                                child: controller.endOfListMsg.value == ''
                                    ? CircularProgressIndicator()
                                    : Text(controller.endOfListMsg.value))
                            : _articleCard(state[i])),
                    separatorBuilder: (ctx, i) => Divider(),
                  ),
            onError: (error) => ApiHandler().errorRetry(
                error: error,
                retry: () => controller
                    .getTopHeadlines(controller.pageCount.value.toString())),
          ),
        ));
  }

  Widget _articleCard(Articles article) => Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(article.urlToImage ?? '',
                errorBuilder: (context, ob, _) => Container(
                      height: 200,
                      width: double.infinity,
                      child: Center(
                        child: Icon(Icons.error),
                      ),
                    ),
                width: double.infinity,
                height: 200,
                repeat: ImageRepeat.repeat,
                fit: BoxFit.fill,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    height: 200,
                    width: double.infinity,
                    child: Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes
                            : null,
                      ),
                    ),
                  );
                }),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            article.title,
            style:
                Get.textTheme.headline6.copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            article.description ?? 'No Description found',
            style: Get.textTheme.bodyText2,
          ),
          SizedBox(
            height: 4,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Chip(
                    backgroundColor: Colors.blue,
                    label: Text(
                      article.author ?? "Unknown",
                      maxLines: 1,
                      softWrap: true,
                      overflow: TextOverflow.fade,
                      style: Get.textTheme.subtitle2.copyWith(fontSize: 16),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Chip(
                    label: Text(
                      DateTime.parse(article.publishedAt).beautify(),
                      style: Get.textTheme.subtitle2.copyWith(fontSize: 16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      );
}
