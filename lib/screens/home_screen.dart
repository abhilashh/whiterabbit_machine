import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Common/constants.dart';
import '../model/home_model.dart';
import '../provider/home_provider.dart';
import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    fetchInitialData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: SafeArea(
        child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Consumer<HomeProvider>(builder: (context, data, _) {
              List<HomeModel?> homeModel = [];
              if (data.pageLoadState == LoadState.loading) {
                return Container(
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(
                    strokeWidth: 4.0,
                    color: Colors.red,
                  ),
                );
              }
              if (data.pageLoadState == LoadState.loaded) {
                homeModel = data.homeModel;
                return Column(
                  children: [
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: TextField(
                            onChanged: (value) => Future.microtask(() =>
                                context.read<HomeProvider>()
                                  ..filterData(value)),
                            decoration: const InputDecoration(
                                labelText: 'Search',
                                suffixIcon: Icon(Icons.search),
                                border: InputBorder.none),
                            cursorColor: Colors.white,
                          ),
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                        child: homeModel.isNotEmpty
                            ? ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: homeModel.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                    child: SizedBox(
                                      height: 100,
                                      child: Card(
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.vertical(
                                              bottom: Radius.circular(10.0),
                                              top: Radius.circular(10.0)),
                                        ),
                                        child: ListTile(
                                          title: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                homeModel[index]!.username ??
                                                    '',
                                                style: const TextStyle(
                                                    fontSize: 25),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                homeModel[index]
                                                        ?.company
                                                        ?.name ??
                                                    '',
                                                style: const TextStyle(
                                                    fontSize: 15),
                                              ),
                                            ],
                                          ),
                                          leading: SizedBox(
                                              height: 80,
                                              width: 80,
                                              child: CircleAvatar(
                                                backgroundImage: NetworkImage(
                                                    homeModel[index]!
                                                            .profileImage ??
                                                        ""),
                                                onBackgroundImageError: (e, s) {
                                                  const Icon(Icons.error);
                                                  debugPrint(
                                                      'image issue, $e,$s');
                                                },
                                              )),
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => DetailScreen(
                                                homeModel: homeModel[index])),
                                      );
                                    },
                                  );
                                })
                            : const Center(
                                child: Text(
                                  'No users Found',
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white),
                                ),
                              ))
                  ],
                );
              }
              return Container();
            })),
      ),
    );
  }

  void fetchInitialData() {
    Future.microtask(() => context.read<HomeProvider>()
      ..homeInit()
      ..getHomeData());
  }
}
