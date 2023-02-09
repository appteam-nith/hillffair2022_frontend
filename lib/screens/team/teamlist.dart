import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hillfair2022_frontend/models/teams/team_model.dart';
import 'package:hillfair2022_frontend/screens/team/contributors.dart';
import 'package:hillfair2022_frontend/screens/team/teamMembers.dart';
import 'package:hillfair2022_frontend/utils/colors.dart';
import 'package:hillfair2022_frontend/view_models/team_view_model/team_view_model.dart';
import 'package:provider/provider.dart';

import '../../components/loading_data.dart';

class TeamList extends StatelessWidget {
  TeamList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TeamViewModel teamViewModel = context.watch<TeamViewModel>();
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text("Teams", style: TextStyle(fontWeight: FontWeight.w600)),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Contributors()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff9E9EEE),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                "Developers",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          // SizedBox(
          //   height: size.height * .01,
          //   child: TextButton(
          //       style: ButtonStyle(
          //           shape: MaterialStateProperty.all(StadiumBorder()),
          //           side: MaterialStateProperty.all(
          //               BorderSide(color: Colors.white))),
          //       onPressed: () {},
          //       child: Text(
          //         "Developers",
          //         style: TextStyle(color: Colors.white),
          //       )),
          // )
          // IconButton(
          //     splashRadius: 1,
          //     onPressed: () {
          //       Navigator.push(context,
          //           MaterialPageRoute(builder: ((context) => Contributors())));
          //     },
          //     icon: Icon(Icons.person))
        ],
      ),
      body: _teamsGridView(size, teamViewModel),
    );
  }

  _teamsGridView(Size size, TeamViewModel teamViewModel) {
    if (teamViewModel.loading) {
      return const LoadingData();
    }

    if (teamViewModel.teamsListModel.isEmpty) {
      return Center(
        child: Text(
          "No Data Present",
          style: TextStyle(
              color: Colors.white,
              fontSize: size.height * .025,
              fontWeight: FontWeight.bold),
        ),
      );
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TeamMembers(teamModel)));
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
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(45.0),
                          child: CachedNetworkImage(
                            imageUrl: teamModel.image,
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                image: imageProvider,
                                alignment: Alignment.center,
                                fit: BoxFit.cover,
                              )),
                            ),
                            placeholder: (context, url) => LoadingData(),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        )),
                    Text(
                      teamModel.clubName,
                      style: TextStyle(fontWeight: FontWeight.bold),
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
