import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:itunes/src/models/albumModel.dart';
import 'package:itunes/src/provider/itune_provider.dart';
import 'package:itunes/src/pages/detail/detail_page.dart';

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

  // Configuracion Search bar
  final dio = new Dio();
  final TextEditingController _filter = new TextEditingController();
  String _searchText = "";
  List filteredItems = new List();
  Icon _searchIcon = new Icon(
    Icons.search,
    color: Colors.white,
  );
  Widget _appBarTitle = Builder(
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
  );

  @override
  void initState() {
    super.initState();

    this.cargarListado('daddy yankee');
  }

  _HomePageState() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
        });
        this.cargarListado('daddy yankee');
      } else {
        setState(() {
          _searchText = _filter.text;
          perPage = 20;
          present = 0;
          listaAlbumOriginal = [];
          listaAlbumPaginada = [];
          if (_searchText.length > 3) {}
          this.cargarListado(_searchText);
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
        title: _appBarTitle,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              icon: _searchIcon,
              onPressed: () {
                setState(() {
                  if (this._searchIcon.icon == Icons.search) {
                    this._searchIcon = new Icon(Icons.close);
                    this._appBarTitle = new TextField(
                      controller: _filter,
                      style: TextStyle(color: Colors.white),
                      decoration: new InputDecoration(
                        labelStyle: TextStyle(color: Colors.white),
                        hintStyle: TextStyle(color: Colors.white),
                        fillColor: Colors.white,
                        prefixIcon: InkWell(
                          onTap: () {
                            if (_filter.text.isEmpty) {
                              this.cargarListado('daddy yankee');
                            } else {
                              setState(() {
                                perPage = 20;
                                present = 0;
                                listaAlbumOriginal = [];
                                listaAlbumPaginada = [];
                              });
                              this.cargarListado(_filter.text);
                            }
                          },
                          child: new Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                        ),
                        hintText: 'Buscar...',
                      ),
                    );
                  } else {
                    this._searchIcon = new Icon(
                      Icons.search,
                      color: Colors.white,
                    );
                    this._appBarTitle = Builder(
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
                    );
                    _filter.clear();
                  }
                });
              },
            ),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
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
                                listaAlbumPaginada[index].collectionName,
                                listaAlbumPaginada[index].artworkUrl100,
                                listaAlbumPaginada[index].trackName,
                                listaAlbumPaginada[index].artistName,
                                listaAlbumPaginada[index].collectionPrice,
                                listaAlbumPaginada[index].previewUrl,
                                listaAlbumPaginada[index].primaryGenreName);
                      },
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  album(collectionName, artworkUrl100, trackName, artistName, collectionPrice,
      previewUrl, genero) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.rightToLeft,
            child: DetailPage(
              nombre: artistName,
              previewUrl: previewUrl,
              artista: artistName,
              descripcion: trackName,
              genero: genero.toString(),
              imagen: artworkUrl100,
              precio: collectionPrice.toString(),
            ),
          ),
        );
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
                child: Image.network(artworkUrl100),
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
                          collectionName,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0),
                        ),
                        Text(
                          trackName == null
                              ? ''
                              : trackName.replaceAll('ArtistName.', ''),
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 12.0),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          artistName,
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

  cargarListado(String terminoBusqueda) {
    List<AlbumModel> listaAlbumTemp = [];
    ituneProvider.getListado(terminoBusqueda).then((res) {
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
              collectionId: list.collectionId,
              collectionName: list.collectionName,
              collectionPrice: list.collectionPrice,
              collectionViewUrl: list.collectionViewUrl,
              contentAdvisoryRating: list.contentAdvisoryRating,
              country: list.country,
              currency: list.currency,
              discCount: list.discCount,
              discNumber: list.discNumber,
              isStreamable: list.isStreamable,
              kind: list.kind,
              previewUrl: list.previewUrl,
              primaryGenreName: list.primaryGenreName,
              releaseDate: list.releaseDate,
              trackCensoredName: list.trackCensoredName,
              trackCount: list.trackCount,
              trackExplicitness: list.trackExplicitness,
              trackId: list.trackId,
              trackName: list.trackName,
              trackNumber: list.trackNumber,
              trackPrice: list.trackPrice,
              trackViewUrl: list.trackViewUrl,
              wrapperType: list.wrapperType));
        });
        setState(() {
          listaAlbumOriginal = listaAlbumTemp;
          listaAlbumPaginada
              .addAll(listaAlbumOriginal.getRange(present, present + perPage));
          present = present + perPage;
          filteredItems = listaAlbumOriginal;
        });
      }
    });
  }
}
