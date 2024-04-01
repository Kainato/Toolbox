// ignore_for_file: file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:toolbox/enums/DrawerItens.dart';
import 'package:toolbox/classes/PhrasesModel.dart';
import 'package:toolbox/firebase_service.dart';
import 'package:toolbox/widgets/layouts/BackgroundPage.dart';

class DailyPhrasesPage extends StatelessWidget {
  const DailyPhrasesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BackgroundPage(
      currentPage: DrawerItens.phrases,
      title: 'Daily Phrases Page',
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          child: StreamBuilder<QuerySnapshot<Object?>>(
            stream: FirebaseService().getPhrases(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasError) {
                return const Text('Something went wrong');
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text('Loading');
              } else {
                List<PhrasesModel> data = snapshot.data.docs
                    .map<PhrasesModel>(
                        (doc) => PhrasesModel.fromJson(doc.data()))
                    .toList();
                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(data[index].description),
                      subtitle: Text(data[index].author.toString()),
                    );
                  },
                );
              }
            },
          ),
        )
      ],
    );
  }
}
