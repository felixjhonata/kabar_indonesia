import 'package:flutter/material.dart';
import 'package:news_app_v2/HomePage.dart';
import 'package:news_app_v2/PageState.dart';
import 'package:news_app_v2/module/NewsFetcher.dart';

class SearchPage extends StatefulWidget {
  final PageState<HomePage> home;
  const SearchPage({super.key, required this.home});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends PageState<SearchPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: _body(),
    );
  }

  AppBar _appBar(context) {
    return AppBar(
      backgroundColor: const Color(0xFF14213D),
      leadingWidth: MediaQuery.of(context).size.width,
      toolbarHeight: 250,
      leading: Center(
        child: Stack(
          children: [
            Column(
              children: [
                const SizedBox(height: 40),
                Image.asset(
                  "assets/image/logo-2.png",
                  height: 90,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "Search...",
                      hintStyle: const TextStyle(
                          color: Color.fromARGB(255, 127, 114, 114)),
                      contentPadding: const EdgeInsets.all(20),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 20, 0),
                        child: IconButton(
                          onPressed: _doSearch,
                          icon: const Icon(
                            Icons.search,
                            color: Colors.black,
                            size: 30,
                          ),
                          alignment: Alignment.center,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              top: 50,
              left: 30,
              child: IconButton(
                color: Colors.white,
                icon: const Icon(Icons.arrow_back_ios_new),
                onPressed: () {
                  widget.home.setState(() {});
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _doSearch() {
    setState(() {});
  }

  Widget _body() {
    return _searchController.text.isEmpty
        ? const Center(child: Text("Type in the search box to search..."))
        : FutureBuilder(
            future: NewsFetcher.fetchNewsByQuery(news, _searchController.text),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    if (index >= news.length) {
                      return Column(
                        children: [
                          SizedBox(
                              height: (news.length > 4
                                  ? 20
                                  : 140.0 * (4 - news.length) + 126)),
                          footer(),
                        ],
                      );
                    }
                    return newsCard(index);
                  },
                  itemCount: news.length + 1,
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          );
  }
}
