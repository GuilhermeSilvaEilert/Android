import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:transparent_image/transparent_image.dart';


class HomeTab extends StatelessWidget {
   const HomeTab({Key? key}) : super(key: key);

   @override
  Widget build(BuildContext context) {
    Widget buildBodyBack()=> Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 200, 0, 0),
              Color.fromARGB(255, 50,10, 10),
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft
        ),
      ),
    );
    return Stack(
      children: [
        buildBodyBack(),
        CustomScrollView(
          slivers: [
            const SliverAppBar(
              floating: true,
              snap: true,
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              flexibleSpace: FlexibleSpaceBar(
                title: Text('Novidades'),
                centerTitle: true,
              ),
            ),
            FutureBuilder<QuerySnapshot>(
              future: FirebaseFirestore.instance.
              collection('home').orderBy('pos').get(),
              builder: (context, snapshot){
                if(!snapshot.hasData) {
                  return SliverToBoxAdapter(
                    child: Container(
                      height: 200,
                      alignment: Alignment.center,
                      child: const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                  );
                } else {
                  return  SliverToBoxAdapter(
                    child: GridView.custom(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverQuiltedGridDelegate(
                        crossAxisCount: 2,
                        mainAxisSpacing: 1,
                        crossAxisSpacing: 1,
                        repeatPattern: QuiltedGridRepeatPattern.inverted,
                        pattern: snapshot.data!.docs.map((e) {
                          return QuiltedGridTile(e['y'], e['x']);
                        }).toList(),
                      ),
                      childrenDelegate: SliverChildBuilderDelegate(
                            (context, index) => FadeInImage.memoryNetwork(
                          placeholder: kTransparentImage,
                          image: snapshot.data!.docs[index]['image'],
                          fit: BoxFit.cover,
                        ),
                        childCount: snapshot.data!.docs.length,
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ],
    );
  }
}