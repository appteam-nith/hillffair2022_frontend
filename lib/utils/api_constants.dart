//api_documentation  ---- "http://anmolcoder.pythonanywhere.com/swagger/"

// Events
const String eventUrl = "https://hillffair2k22.herokuapp.com/events/";

//teams
const String teamUrl = "https://hillffair2k22.herokuapp.com/teams/team/";
const String teamMembersUrl =
    "https://hillffair2k22.herokuapp.com/teams/member/";

//userFeed
const String userFeedUrl = "https://hillffair2k22.herokuapp.com/imagefeed/";
const String postImgUrl = "https://hillffair2k22.herokuapp.com/imagefeed/";
const String postCommentUrl =
    "https://hillffair2k22.herokuapp.com/imagefeed/comment/";
const String getCommentUrl =
    "https://hillffair2k22.herokuapp.com/imagefeed/getcomment";
const String postLikeUrl = "https://hillffair2k22.herokuapp.com/imagefeed/like";
const String getLikerUrl =
    "https://hillffair2k22.herokuapp.com/imagefeed/get-likers/";

//user

const String postUserUrl = "https://hillffair2k22.herokuapp.com/user/";
const String checkUserUrl =
    "https://hillffair2k22.herokuapp.com/user/checkUser/";

//chatting
const String getChatRoomUrl =
    "https://hillffair2k22.herokuapp.com/chat/getRoom/";
const String getMessagesUrl =
    "https://hillffair2k22.herokuapp.com/chat/getMessages";
const String postChatUrl = "https://hillffair2k22.herokuapp.com/chat/send/";

// Status-Codes
const postSuccessCode = 201;
const getSuccessCode = 200;
const invalidResponse = 100;
const noInternet = 101;
const invalidFormat = 102;
const unknownError = 103;
