import 'package:flutter/material.dart';
import 'package:itunes/src/models/albumModel.dart';
import 'package:itunes/src/provider/itune_provider.dart';
import 'package:paging/paging.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // API Providers
  final ituneProvider = ItuneProvider();

  // Variables funcionales
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final SnackBar snackBar = const SnackBar(content: Text('Click search'));

  // Variables API
  List<AlbumModel> listaAlbum = [];
  List<AlbumModel> listaPaginada = [];

  // Varibles generales
  bool showSearch = false;
  double tamanoSearch = 0;
  static const int _COUNT = 10;

  Future<List<AlbumModel>> pageData(int previousCount) async {
    if (listaAlbum.length > 0) {
      if (previousCount < 50) {
        for (int i = previousCount; i < previousCount + _COUNT; i++) {
          listaPaginada.add(listaAlbum[i]);
        }
      }
    }
    return listaPaginada;
  }

  @override
  void initState() async {
    super.initState();
    List<AlbumModel> listaAlbumTemp = [];
    await ituneProvider.getListado().then((res) {
      if (res.length > 0) {
        res.forEach((list) {
          listaAlbumTemp.add(AlbumModel(
              artistId: list.artistId,
              artistName: list.artistName,
              artistViewUrl: list.artistViewUrl,
              artworkUrl100: list.artworkUrl100,
              artworkUrl30: list.artworkUrl30,
              artworkUrl60: list.artworkUrl60,
              collectionCensoredName: list.collectionCensoredName,
              collectionExplicitness: list.collectionExplicitness,
              collectionHdPrice: list.collectionHdPrice,
              collectionId: list.collectionId,
              collectionName: list.collectionName,
              collectionPrice: list.collectionPrice,
              collectionViewUrl: list.collectionViewUrl,
              contentAdvisoryRating: list.contentAdvisoryRating,
              copyright: list.copyright,
              country: list.country,
              currency: list.currency,
              description: list.description,
              discCount: list.discCount,
              discNumber: list.discNumber,
              isStreamable: list.isStreamable,
              kind: list.kind,
              longDescription: list.longDescription,
              previewUrl: list.previewUrl,
              primaryGenreName: list.primaryGenreName,
              releaseDate: list.releaseDate,
              shortDescription: list.shortDescription,
              trackCensoredName: list.trackCensoredName,
              trackCount: list.trackCount,
              trackExplicitness: list.trackExplicitness,
              trackHdPrice: list.trackHdPrice,
              trackId: list.trackId,
              trackName: list.trackName,
              trackNumber: list.trackNumber,
              trackPrice: list.trackPrice,
              trackTimeMillis: list.trackTimeMillis,
              trackViewUrl: list.trackViewUrl,
              wrapperType: list.wrapperType));
        });
        setState(() {
          listaAlbum = listaAlbumTemp;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double tamanoScroll = MediaQuery.of(context).size.height - 100;

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                Icons.person,
                color: Colors.white,
              ),
              onPressed: null,
            );
          },
        ),
        title: Builder(
          builder: (BuildContext context) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/bcify.png',
                  width: 40.0,
                  height: 40.0,
                ),
                Text(' BCIFY'),
              ],
            );
          },
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              icon: const Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {
                // scaffoldKey.currentState.showSnackBar(snackBar);
                setState(() {
                  showSearch = !showSearch;
                });
              },
            ),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          // searchBar(),
          Container(
            width: double.infinity,
            height: tamanoScroll,
            child: Pagination(
              pageBuilder: (currentListSize) => pageData(currentListSize),
              itemBuilder: (index, item) {
                return album(listaPaginada[index].trackName,
                    listaPaginada[index].artworkUrl100);
              },
            ),
          ),
        ],
      ),
    );
  }

  searchBar() {
    return showSearch
        ? Container(
            width: double.infinity,
            height: tamanoSearch,
            color: Color(0xFF1E1E1E),
            child: Text('Buscar...'),
          )
        : Container();
  }

  album(nombre, imagen) {
    return Container(
      color: Color(0xFF181818),
      height: 200.0,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Image.network(imagen),
            ),
            Container(
              child: Text(
                nombre,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
