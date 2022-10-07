// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hillfair2022_frontend/models/team_model.dart';
import 'package:hillfair2022_frontend/screens/team/teammembers.dart';
import 'package:hillfair2022_frontend/utils/colors.dart';
import 'package:hillfair2022_frontend/view_models/team_view_model.dart';
import 'package:provider/provider.dart';

import '../../components/loading_data.dart';

class TeamList extends StatelessWidget {
  TeamList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TeamViewModel teamViewModel = context.watch<TeamViewModel>();
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: Center(
            child: Text("Team List",
                style: TextStyle(
                    fontFamily: GoogleFonts.poppins().fontFamily,
                    fontWeight: FontWeight.bold))),
      ),
      body: Container(
        height: size.height,
        decoration: BoxDecoration(
            border: Border(),
            image: DecorationImage(
                fit: BoxFit.cover, image: AssetImage("assets/images/bg.png"))),
        child: _teamsGridView(size, teamViewModel),
      ),
    );
  }

  _teamsGridView(Size size, TeamViewModel teamViewModel) {
    if (teamViewModel.loading) {
      return const LoadingData();
    }

    return GridView.builder(
        itemCount: teamViewModel.teamsListModel.length,
        shrinkWrap: true,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) {
          TeamModel teamModel = teamViewModel.teamsListModel[index];
          return Padding(
            padding: EdgeInsets.only(left: 15, right: 15, top: 12, bottom: 12),
            child: InkWell(
              onTap: (() {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => TeamMembers()));
              }),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CircleAvatar(
                      backgroundColor: appBarColor,
                      radius: 45,
                      child: ClipRRect(borderRadius: BorderRadius.circular(45.0),child: CachedNetworkImage(
                        imageUrl: teamModel.image,
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: imageProvider,
                                alignment: Alignment.center,
                                fit: BoxFit.cover,)
                          ),
                        ),
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),)
                    ),
                    Text(
                      teamModel.clubName,
                      style: TextStyle(
                          fontFamily: GoogleFonts.poppins().fontFamily,
                          fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
