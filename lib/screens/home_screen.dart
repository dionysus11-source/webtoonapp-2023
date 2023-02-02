import 'package:flutter/material.dart';
import 'package:webtoon_app_2023/models/webtoon_model.dart';
import 'package:webtoon_app_2023/services/api_service.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final Future<List<WebtoonModel>> webtoons = ApiServce.getTodaysToons();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 2,
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        title: const Text(
          "오늘의 웹툰",
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: FutureBuilder(
        future: webtoons,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Expanded(child: makeList(snapshot)),
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  ListView makeList(AsyncSnapshot<List<WebtoonModel>> snapshot) {
    return ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        scrollDirection: Axis.horizontal,
        itemBuilder: ((context, index) {
          var webtoon = snapshot.data![index];
          return Column(
            children: [
              Container(
                //padding:
                //    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 15,
                      offset: const Offset(10, 10),
                      color: Colors.black.withOpacity(0.5),
                    )
                  ],
                  borderRadius: BorderRadius.circular(15),
                ),
                width: 250,
                child: Image.network(webtoon.thumb),
              ),
              const SizedBox(height: 20),
              Text(
                webtoon.title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          );
        }),
        separatorBuilder: ((context, index) => const SizedBox(
              width: 40,
            )),
        itemCount: snapshot.data!.length);
  }
}
