class CONFIG {
  static final String domain = "https://nbl.fanhall.app/";
  //Authentications
  static final String createUser = "api/users/register";
  static final String loginUser = "api/users/login";
  static final String getCountries = "api/nationality/countries";
  static final String getTeamAll = "api/teams";
  static final String getSeasons = "api/seasons/getByTeam/";
  static final String gethalloffame = "api/certificates/halloffame/all";
  static final String gethalloffamebyyears =
      "api/certificates/halloffame/ByClass/";
  static final String getSurvey = "api/draft/getSurvey";
  static final String getarticle = "api/draft/getArticle";
  static final String getTeamPoster = "api/draft/getArticle";
  static final String getYear = "api/score/getYear";
  static final String getweek = "api/score/getWeek";
  static final String getCerti = "api/certificates/getByType/";
  static final String getFanMatchcertificate =
      "api/fanmatch/certificates/getAll/";
  static final String getFanMatchcertificateforvideos =
      "api/fanmatch/certificates/video/getAll/";
  static final String getCertbyhalloffame = "api/certificates/halloffame/";
  static final String getShowcase = "api/certificates/getFanShowCase";
  static final String getShowcaseFanMatch =
      "api/fanmatch/certificates/getFanMatchShowCase";
  static final String getCertiorder = "api/certificates/getCertificateOrder";
  static final String buyCerti = "api/certificates/buyCertificate";
  static final String getsingleTeam = "api/teams/getSingleTeam/";
  static final String checkusername = "api/users/checkUserName";
  static final String checkusernameemail = "api/users/checkEmail";
  static final String getfeeds = "api/users/getNewsFeed";
  static final String getsingle = "api/users/getSinglePost/";
  static final String getCertiByHero = "api/certificates/getByHero/";
  static final String getCertiPdf = "api/certificates/createCertificatePdf/";
  static final String getCertiPdfforFAnmatch =
      "api/fanmatch/certificates/createCertificatePdf/";
  static final String getCertiByMoments =
      "api/certificates/getAwesomeCertificate/";
  static final String getHeros = "api/heroes/";
  static final String getMoments = "api/awesome-moments/getAll";
  static final String getCity = "api/nationality/countries/city/";
  static final String deletepost = "api/users/deleteUserPhoto/";
  static final String deletecert = "api/certificates/userCertificate/delete/";
  static final String getLogedUser = "api/users/getLoggedIn";
  static final String getleague = "api/leagues/getAll";
  static final String forgotPassword = "api/users/reset-password";
  static final String changePassword = "api/users/change-password";
  static final String checkotp = "api/users/check-otp?otp";
  static final String updateData = "api/users/update-profile";
  static final String getPhotos = "api/users/photos/getAll";
  static final String uploadPhotos = "api/users/upload-photos";
  static final String createAlbum = "api/users/create-album";
  static final String likephoto = "api/users/photoLike";
  static final String getAlbum = "api/users/album/getAll";
  static final String uploadVideos = "api/users/vclips/store";
  static final String getVideos = "api/users/vclips/getAll";
  static final String getchatList = "api/chat/getMessageList";
  static final String getuserList = "api/chat/getUserList";
  static final String getteamScore = "api/score/getAllScoreList";
  static final String getteamScorebyweek = "api/score/getWeekDayScore/";

  static final String getuserListbyteam = "api/users/getTeamUser/";
  static final String sendMessage = "api/chat/sendMessage";
  static final String deleteMessage = "api/chat/deleteMessage/";
  static final String sendSurvey = "api/draft/takeSurvey";
  static final String CheckSeen = "api/chat/seenMessage";
  static final String sendComment = "api/users/photoComment";
  static final String getchatHistory = "api/chat/getChatHistory/";
  static final String getScanCertificate = "api/certificates/scanCertificate/";

  static final String uploadAlbumPhotos = "api/users/album-photos";
  static final String getAlbumPhotos = "api/users/album-photos/getAll/1";

  //Events EndPoint

  static final int timeoutDuration = 10;
}
