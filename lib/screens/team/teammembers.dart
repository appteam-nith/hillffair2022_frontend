// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hillfair2022_frontend/components/loading_data.dart';
import 'package:hillfair2022_frontend/models/team_member_model.dart';
import 'package:hillfair2022_frontend/utils/colors.dart';
import 'package:hillfair2022_frontend/view_models/team_member_view_model.dart';
import 'package:provider/provider.dart';

class TeamMembers extends StatefulWidget {
  String selectedTeam;
  TeamMembers(this.selectedTeam, {super.key});

  @override
  State<TeamMembers> createState() => _TeamMembersState();
}

class _TeamMembersState extends State<TeamMembers> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    TeamMemberViewModel teamMemberViewModel =
        context.watch<TeamMemberViewModel>();

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: true,
        title:
            Text("Team Members", style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: _teamMemberListView(size, teamMemberViewModel),
    );
  }

  _teamMemberListView(Size size, TeamMemberViewModel teamMemberViewModel) {
    if (teamMemberViewModel.loading) {
      return const LoadingData();
    }

    return ListView.builder(
        shrinkWrap: true,
        itemCount: teamMemberViewModel.teamMembersListModel.where((element) => element.teamName == widget.selectedTeam)
              .toList().length,
        itemBuilder: (context, index) {
          TeamMemberModel teamMemberModel = teamMemberViewModel
              .teamMembersListModel
              .where((element) => element.teamName == widget.selectedTeam)
              .toList()[index]
          ;

          return Padding(
            padding: const EdgeInsets.all(13),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15), color: Colors.white),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Image.asset(
                  //   "assets/images/member.png",
                  //   height: size.height * .1,
                  // ),
                  CircleAvatar(
                    backgroundColor: appBarColor,
                    radius: 45,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(45.0),
                      child: CachedNetworkImage(
                        imageUrl: teamMemberModel.image,
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                            image: imageProvider,
                            alignment: Alignment.center,
                            fit: BoxFit.cover,
                          )),
                        ),
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * .15,
                    width: size.width * .56,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          teamMemberModel.name,
                          style: TextStyle(
                              color: appBarColor,
                              fontSize: size.width * .05),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          teamMemberModel.position,
                          style: TextStyle(
                              color: appBarColor,
                              fontSize: size.width * .037),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
