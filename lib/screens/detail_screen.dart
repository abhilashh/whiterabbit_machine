import 'package:flutter/material.dart';
import 'package:whiterabbit_machine/model/home_model.dart';

class DetailScreen extends StatefulWidget {
  final HomeModel? homeModel;
  DetailScreen({Key? key, this.homeModel}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.grey,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
                padding: const EdgeInsets.all(10),
                height: MediaQuery.of(context).size.height / 3,
                width: MediaQuery.of(context).size.width,
                child: Card(
                    shadowColor: Colors.blue,
                    elevation: 2,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(10.0),
                          top: Radius.circular(10.0)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: SizedBox(
                              height: 100,
                              width: 100,
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(
                                  widget.homeModel?.profileImage ?? "",
                                ),
                                onBackgroundImageError: (e, s) {
                                  const Icon(Icons.error);
                                  debugPrint('image issue, $e,$s');
                                },
                              )),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          widget.homeModel?.name ?? "",
                          style: const TextStyle(
                              fontSize: 20.0, color: Colors.black),
                        ),
                        Text(
                          widget.homeModel?.username ?? "",
                          style: const TextStyle(
                              fontSize: 20.0, color: Colors.black),
                        ),
                      ],
                    ))),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 5,
                child: Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.homeModel?.email ?? "",
                        style: const TextStyle(fontSize: 20.0),
                      ),
                      Text(
                        widget.homeModel?.phone ?? "",
                        style: const TextStyle(fontSize: 20.0),
                      ),
                      Text(
                        widget.homeModel?.website ?? "",
                        style: const TextStyle(fontSize: 20.0),
                      ),
                      Text(
                        widget.homeModel?.address?.street ?? "",
                        style: const TextStyle(fontSize: 20.0),
                      ),
                      Text(
                        widget.homeModel?.company?.name ?? "",
                        style: const TextStyle(fontSize: 20.0),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
