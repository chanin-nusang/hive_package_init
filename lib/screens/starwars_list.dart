import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sp1_midterm_exam/Helpers/starwars_repo.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class StarwarsList extends StatefulWidget {
  const StarwarsList({Key? key}) : super(key: key);
  @override
  _StarwarsListState createState() => _StarwarsListState();
}

class _StarwarsListState extends State<StarwarsList> {
  var box = Hive.box('starwars');
  List<People> people = [];
  int? page, itemPerPage;
  bool? error, loading, hasMore, connectivity;

  @override
  void initState() {
    page = 1;
    itemPerPage = 10;
    error = false;
    loading = true;
    hasMore = true;
    connectivity = false;
    checkConnectivity();
    super.initState();
  }

  checkConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      // I am connected to a mobile network.
      connectivity = true;
      print('Connection : true');
      getPeople();
    } else if (connectivityResult == ConnectivityResult.wifi) {
      // I am connected to a wifi network.
      connectivity = true;
      print('Connection : true');
      getPeople();
    } else {
      connectivity = false;
      print('Connection : false');
    }
  }

  Future getPeople() async {
    try {
      print("Page = $page");
      //List<People> peoplePage =
      await StarwarsRepo().getPage(page!);
      //print("PeoplePage lenght : ${peoplePage.length}");
      //await box.put('people', peoplePage);
      setState(() {
        hasMore = 10 == itemPerPage;
        loading = false;
        page = page! + 1;
        //people.addAll(peoplePage);
        //people = box.get('people');
        //print("People lenght : ${people.length}");
      });
    } catch (e) {
      print(e);
      loading = false;
      error = true;
    }
  }

  empty() {
    if (loading!) {
      return Center(
        child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.amberAccent)),
      );
    } else if (error!) {
      return Center(
          child: InkWell(
        onTap: () {
          setState(() {
            loading = true;
            error = false;
            getPeople();
          });
        },
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Error!, tap to try loading again."),
          ),
        ),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    print('Connectivity in widget : $connectivity');
    if (connectivity == false) {
      if (box.isEmpty) {
        print('1 Done!!!!!!!!!!!!!!!!!!');
        return Center(
          child: Text('No internet access.'),
        );
      } else {
        print('2 Done!!!!!!!!!!!!!!!!!!');
        return ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: box.length,
            itemBuilder: (BuildContext context, int index) {
              print("Index : $index");
              print("Error : $error");
              People _people = box.get(index + 1);
              return Wrap(
                children: [
                  PeopleTile(people: _people),
                  if (index < people.length - 1)
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: Divider(),
                    )
                ],
              );
            });
      }
    } else {
      if (box.isEmpty) {
        print('3 Done!!!!!!!!!!!!!!!!!!');
        return empty();
      } else {
        print('4 Done!!!!!!!!!!!!!!!!!!');
        return ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: box.length + (hasMore! ? 1 : 0),
            itemBuilder: (BuildContext context, int index) {
              if (index == box.length - 5) {
                if (page! < 10) {
                  getPeople();
                }
              }
              if (index == box.length) {
                if (error!) {
                  return Center(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          loading = true;
                          error = false;
                          getPeople();
                        });
                      },
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Error!, tap to try loading again."),
                        ),
                      ),
                    ),
                  );
                } else
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(
                          valueColor: new AlwaysStoppedAnimation<Color>(
                              Colors.amberAccent)),
                    ),
                  );
              }
              //print("Name : ${box.get(index).name}");
              print("Index : $index");
              print("Error : $error");
              People _people = box.get(index + 1);
              return Wrap(
                children: [
                  PeopleTile(people: _people),
                  if (index < people.length - 1)
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: Divider(),
                    )
                ],
              );
            });
      }
    }
  }
}

class PeopleTile extends StatelessWidget {
  PeopleTile({@required this.people});
  final People? people;
  static Map<String, Color?>? color = {
    'black': Colors.black,
    'blond': Color(0xFFFAF0BE),
    'fair': Color(0xFFF3CFBB),
    'blue': Colors.blue,
    'gold': Color(0xFFd4af37),
    'yellow': Colors.yellow,
    'white': Colors.white,
    'red': Colors.red,
    'brown': Colors.brown,
    'light': Colors.amber[100],
    'grey': Colors.grey,
    'auburn': Color(0xFF922704),
    'blue-gray': Color(0xFF657895),
    'green': Colors.green,
    'green-tan': Color(0xFFa9be70),
    'orange': Colors.orange,
    'hazel': Color(0xFF9e6b4a),
    'pale': Color(0xFFFFBFDF),
    'metal': Color(0xFFAAA9AD),
    'dark': Color(0xFF3A3B3C),
    'brown mottle': Color(0xFF654321),
    'mottled green': Color(0xFF98fb98),
    'pink': Colors.pink,
    'tan': Color(0xFFD2B48C),
    'blonde': Color(0xFFF0E2B6),
    'silver': Color(0xFFC0C0C0),
  };

  List<String>? hair, skin, eye;
  colorSplit() async {
    hair = people?.hairColor!.split(', ');
    skin = people?.skinColor!.split(', ');
    eye = people?.eyeColor!.split(', ');
  }

  List<Widget>? wid = [];
  colorSquare() async {
    for (int i = 0; i < hair!.length; i++) {
      if (color!.containsKey(hair![i])) {
        wid!.add(Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(),
            color: color![hair![i]],
          ),
          height: 13,
          width: 13,
        ));
      } else
        wid!.add(Text(" - ", style: TextStyle(color: Colors.grey[600])));
    }
    wid!.add(Text("/", style: TextStyle(color: Colors.grey[600])));
    for (int i = 0; i < skin!.length; i++) {
      if (color!.containsKey(skin![i])) {
        wid!.add(Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(),
            color: color![skin![i]],
          ),
          height: 13,
          width: 13,
        ));
      } else
        wid!.add(Text(" - ", style: TextStyle(color: Colors.grey[600])));
    }
    wid!.add(Text("/", style: TextStyle(color: Colors.grey[600])));
    for (int i = 0; i < eye!.length; i++) {
      if (color!.containsKey(eye![i])) {
        wid!.add(Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(),
            color: color![eye![i]],
          ),
          height: 13,
          width: 13,
        ));
      } else
        wid!.add(Text(" - ", style: TextStyle(color: Colors.grey[600])));
    }
  }

  @override
  Widget build(BuildContext context) {
    colorSplit();
    colorSquare();
    return Container(
      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            child: CircleAvatar(
                radius: 40,
                backgroundColor: Colors.transparent,
                // backgroundImage: Image.asset(
                //   'images/Star_Wars_Logo_Square.png',
                //   fit: BoxFit.cover,
                // ).image,
                foregroundImage: CachedNetworkImageProvider(
                    'https://starwars-visualguide.com/assets/img/characters/${people?.no}.jpg')),
          ),
          SizedBox(
            width: 10,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  people?.name ?? ' ',
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  "Gender : ${people?.gender}   Height : ${people?.height.toString()}   Mass : ${people?.mass.toString()}",
                  style: TextStyle(fontSize: 15, color: Colors.grey[600]),
                ),
                Row(
                  children: [
                    Flexible(
                      flex: 6,
                      child: Text('Hair/Skin/Eye Colors : ',
                          style: TextStyle(color: Colors.grey[600])),
                    ),
                    for (var item in wid!) Flexible(child: item)
                  ],
                ),
                Text('Year of Birth : ${people?.birthYear}',
                    style: TextStyle(
                        color: Colors.grey[600], fontWeight: FontWeight.w400))
              ],
            ),
          )
        ],
      ),
    );
  }
}
