import 'package:flutter/material.dart';
import 'package:itunes/src/models/albumModel.dart';
import 'package:itunes/src/provider/itune_provider.dart';

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
  List<AlbumModel> listaAlbumOriginal = [];
  List<AlbumModel> listaAlbumPaginada = [];

  // Varibles generales
  bool showSearch = false;
  double tamanoSearch = 0;
  int perPage = 20;
  int present = 0;

  @override
  void initState() {
    super.initState();

    List<AlbumModel> listaAlbumTemp = [];
    ituneProvider.getListado().then((res) {
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
          listaAlbumOriginal = listaAlbumTemp;
          listaAlbumPaginada
              .addAll(listaAlbumOriginal.getRange(present, present + perPage));
          present = present + perPage;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double tamanoScroll = MediaQuery.of(context).size.height - 100;

    return Scaffold(
      backgroundColor: Color(0xFF181818),
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
          listaAlbumOriginal.length == 0
              ? Padding(
                  padding: EdgeInsets.only(top: 90.0),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : Expanded(
                  child: Container(
                    width: double.infinity,
                    height: tamanoScroll,
                    child: ListView.builder(
                      itemCount: (present <= listaAlbumOriginal.length)
                          ? listaAlbumPaginada.length + 1
                          : listaAlbumPaginada.length,
                      itemBuilder: (context, index) {
                        return (index == listaAlbumPaginada.length)
                            ? Container(
                                color: Color(0xFF00E04A),
                                child: FlatButton(
                                  child: Text("Cargar más"),
                                  onPressed: () {
                                    setState(() {
                                      if ((present + perPage) >
                                          listaAlbumOriginal.length) {
                                        listaAlbumPaginada.addAll(
                                            listaAlbumOriginal.getRange(present,
                                                listaAlbumOriginal.length));
                                      } else {
                                        listaAlbumPaginada.addAll(
                                            listaAlbumOriginal.getRange(
                                                present, present + perPage));
                                      }
                                      present = present + perPage;
                                    });
                                  },
                                ),
                              )
                            : album(
                                listaAlbumPaginada[index].trackName,
                                listaAlbumPaginada[index].artworkUrl100,
                                listaAlbumPaginada[index].artistName.toString(),
                                listaAlbumPaginada[index].collectionName,
                                listaAlbumPaginada[index].collectionPrice);
                      },
                    ),
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

  album(nombre, imagen, artista, collectionName, collectionPrice) {
    return InkWell(
      onTap: () {
        print('click');
      },
      child: Container(
        padding: EdgeInsets.all(20.0),
        color: Color(0xFF181818),
        height: 150.0,
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Image.network(imagen),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.65,
                padding: EdgeInsets.only(left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          nombre,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0),
                        ),
                        Text(
                          artista.replaceAll('ArtistName.', ''),
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 12.0),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          collectionName,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 15.0,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                    Container(
                      child: Text(
                        '\$' + collectionPrice.toString(),
                        style: TextStyle(
                            color: Color(0xFF00E04A),
                            fontWeight: FontWeight.w500,
                            fontSize: 15.0),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
