import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:newspaper_app/models/categories_new_model.dart';
import 'package:newspaper_app/models/news_channel_headlines_model.dart';
import 'package:newspaper_app/screen/categories_screen.dart';
import 'package:newspaper_app/screen/news_detail_screen.dart';
import 'package:newspaper_app/view_model/news_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum FilterList { bbcNews, aryNews, ansa, reuters, cnn, alJareera }

class _HomeScreenState extends State<HomeScreen> {
  NewsViewModel newsViewModel = NewsViewModel();

  FilterList? selectedMenu;
  final format = DateFormat('MMMM dd,yy');
  String name = 'bbc-news';

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery
        .sizeOf(context)
        .width * 1;
    final height = MediaQuery
        .sizeOf(context)
        .height * 1;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CategoriesScreen()));
          },
          icon: Image.asset(
            'images/category_icon.png',
            height: 30,
            width: 30,
          ),
        ),
        centerTitle: true,
        title: Text('News',
            style:
            GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w700)),
        actions: [
          PopupMenuButton<FilterList>(
              initialValue: selectedMenu,
              icon: Icon(
                Icons.more_vert,
                color: Colors.black,
              ),
              onSelected: (FilterList item) {
                if (FilterList.bbcNews.name == item.name) {
                  name = 'bbc-news';
                }

                if (FilterList.aryNews.name == item.name) {
                  name = 'ary-news';
                }

                if (FilterList.ansa.name == item.name) {
                  name = 'ansa';
                }

                if (FilterList.reuters.name == item.name) {
                  name = 'reuters';
                }

                if (FilterList.cnn.name == item.name) {
                  name = 'cnn';
                }
                if (FilterList.alJareera.name == item.name) {
                  name = 'al-jazeera-english';
                }


                setState(() {

                });
              },
              itemBuilder: (context) =>
              <PopupMenuEntry<FilterList>>[
                const PopupMenuItem<FilterList>(
                    value: FilterList.bbcNews, child: Text('BBC News')),
                const PopupMenuItem<FilterList>(
                    value: FilterList.aryNews, child: Text('Arc News')),
                const PopupMenuItem<FilterList>(
                    value: FilterList.ansa,
                    child: Text('Ansa')),
                const PopupMenuItem<FilterList>(
                    value: FilterList.reuters, child: Text('Reuters')),
                const PopupMenuItem<FilterList>(
                    value: FilterList.cnn, child: Text('CNN')),
                const PopupMenuItem<FilterList>(
                    value: FilterList.alJareera, child: Text('Al-Jareera')),
              ])
        ],
      ),
      body: ListView(children: [
        SizedBox(
          height: height * .55,
          width: width,
          child: FutureBuilder<NewsChannelsHeadlinesModel>(
              future: newsViewModel.fetchNewChannelHeadlinesApi(name),
              builder: (BuildContext context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      child: SpinKitCircle(
                        color: Colors.blue,
                        size: 50,
                      ));
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.articles!.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      DateTime dateTime = DateTime.parse(snapshot
                          .data!.articles![index].publishedAt
                          .toString());
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context, MaterialPageRoute(builder: (context) =>

                              NewsDetailsScreen(
                                  newImage: snapshot
                                      .data!.articles![index].urlToImage
                                      .toString(),
                                  newsTitle: snapshot
                                      .data!.articles![index].title
                                      .toString(),
                                  newsDate: snapshot
                                      .data!.articles![index].publishedAt
                                      .toString(),
                                  newsAuthor: snapshot
                                      .data!.articles![index].author
                                      .toString(),
                                   newsDesc: snapshot
                                      .data!.articles![index].description
                                  .toString(),
                                  newsContent: snapshot
                                      .data!.articles![index].content
                                      .toString(),
                                  newsSource: snapshot
                                      .data!.articles![index].source!.name
                                      .toString(),
                          )
                          )
                          );
                        },
                        child: SizedBox(
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  height: height * 0.6,
                                  width: width * .9,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: height * .02,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: CachedNetworkImage(
                                      imageUrl: snapshot
                                          .data!.articles![index].urlToImage
                                          .toString(),
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) =>
                                          Container(
                                            child: spinKit2,
                                          ),
                                      errorWidget: (context, url, error) =>
                                          Icon(
                                            Icons.error_outline,
                                            color: Colors.red,
                                          ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 20,
                                  child: Card(
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Container(
                                      alignment: Alignment.bottomCenter,
                                      padding: EdgeInsets.all(15),
                                      height: height * .22,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment
                                            .center,
                                        crossAxisAlignment: CrossAxisAlignment
                                            .center,
                                        children: [
                                          Container(
                                            width: width * 0.7,
                                            child: Text(
                                              snapshot.data!.articles![index]
                                                  .title
                                                  .toString(),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.poppins(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                          Spacer(),
                                          Container(
                                            width: width * 0.7,
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  snapshot.data!
                                                      .articles![index]
                                                      .source!.name
                                                      .toString(),
                                                  maxLines: 2,
                                                  overflow: TextOverflow
                                                      .ellipsis,
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 17,
                                                      fontWeight: FontWeight
                                                          .w600),
                                                ),
                                                Text(
                                                  format.format(dateTime),
                                                  maxLines: 2,
                                                  overflow: TextOverflow
                                                      .ellipsis,
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 12,
                                                      fontWeight: FontWeight
                                                          .w500),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )),
                      );
                    },
                  );
                }
              }),
        ),
        FutureBuilder<CategoriesNewsModel>(
            future: newsViewModel.fetchCategoriesNewsApi('general'),
            builder: (BuildContext context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child: SpinKitCircle(
                      color: Colors.blue,
                      size: 50,
                    ));
              } else {
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    physics: const ClampingScrollPhysics(),
                    itemCount: snapshot.data!.articles!.length,
                    shrinkWrap: true,


                    itemBuilder: (context, index) {
                      DateTime dateTime = DateTime.parse(snapshot
                          .data!.articles![index].publishedAt
                          .toString());
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context, MaterialPageRoute(builder: (context) =>

                              NewsDetailsScreen(
                                newImage: snapshot
                                    .data!.articles![index].urlToImage
                                    .toString(),
                                newsTitle: snapshot
                                    .data!.articles![index].title
                                    .toString(),
                                newsDate: snapshot
                                    .data!.articles![index].publishedAt
                                    .toString(),
                                newsAuthor: snapshot
                                    .data!.articles![index].author
                                    .toString(),
                                newsDesc: snapshot
                                    .data!.articles![index].description
                                    .toString(),
                                newsContent: snapshot
                                    .data!.articles![index].content
                                    .toString(),
                                newsSource: snapshot
                                    .data!.articles![index].source!.name
                                    .toString(),
                              )
                          )
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: CachedNetworkImage(
                                  imageUrl: snapshot
                                      .data!.articles![index].urlToImage
                                      .toString(),
                                  fit: BoxFit.cover,
                                  height: height * .18,
                                  width: width * .3,
                                  placeholder: (context, url) =>
                                      Container(
                                        child: SpinKitCircle(
                                          color: Colors.blue,
                                          size: 50,
                                        ),
                                      ),
                                  errorWidget: (context, url, error) =>
                                      Icon(
                                        Icons.error_outline,
                                        color: Colors.red,
                                      ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  height: height * .18,
                                  padding: EdgeInsets.only(left: 15),
                                  child: Column(
                                    children: [
                                      Text(
                                          snapshot
                                              .data!.articles![index].title
                                              .toString(),
                                          maxLines: 3,
                                          style: GoogleFonts.poppins(
                                            fontSize: 15,
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w700,
                                          )),
                                      Spacer(),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              snapshot.data!.articles![index]
                                                  .source!.name
                                                  .toString(),
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.poppins(
                                                fontSize: 14,
                                                color: Colors.blue,
                                                fontWeight: FontWeight.w600,
                                              )),
                                          Text(format.format(dateTime),
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.poppins(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                              )),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
            })
      ]),
    );
  }
}

const spinKit2 = SpinKitFadingCircle(
  color: Colors.amber,
  size: 50,
);
