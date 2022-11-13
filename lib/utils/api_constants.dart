// const String apiConstant = "https://hillffair2k22.herokuapp.com";
const String apiConstant = "https://appteam.mhsalmaan.me";

// Events
const String eventUrl = "$apiConstant/events/";

//teams
const String teamUrl = "$apiConstant/teams/team/";
const String teamMembersUrl = "$apiConstant/teams/member/";

//userFeed
const String userFeedUrl = "$apiConstant/imagefeed";
const String postImgUrl = "$apiConstant/imagefeed/addpost/";
const String deletePostUrl = "$apiConstant/imagefeed/post/";
const String postCommentUrl = "$apiConstant/imagefeed/comment/";
const String getCommentUrl = "$apiConstant/imagefeed/getcomment";
const String postLikeUrl = "$apiConstant/imagefeed/like";
const String getLikerUrl = "$apiConstant/imagefeed/get-likers/";

//teamfeed
const String teamFeedLikeUrl = "$apiConstant/TeamFeed/like";
const String teamFeedUrl = "$apiConstant/TeamFeed";

//user

const String postUserUrl = "$apiConstant/user/";
const String checkUserUrl = "$apiConstant/user/checkUser/";

//chatting
const String getChatRoomUrl = "$apiConstant/chat/getRoom";
const String getMessagesUrl = "$apiConstant/chat/getMessages";
const String postChatUrl = "$apiConstant/chat/send/";
const String checkChater = "$apiConstant/chat/checkchater";

//
const String refreshTokenUrl = "$apiConstant/user/api/token/";
const String accessTokenUrl = "$apiConstant/user/api/token/refresh/";

// Status-Codes
const postSuccessCode = 201;
const getSuccessCode = 200;
const invalidResponse = 100;
const noInternet = 101;
const invalidFormat = 102;
const unknownError = 103;
