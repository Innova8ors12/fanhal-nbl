class Constants{
  Constants._();

  static List<String> gender = ["Male", "Female","Others"];
  static List<String> nationalities = ["American", "Australian", "British", "Chinese", "Japanese"];
  static List<String> regionsA = ["All", "AFC East", "AFC West", "AFC North", "AFC South"];
  static List<String> regionsN = ["All", "NFC East", "NFC West", "NFC North", "NFC South"];
  static List<String> certType = ["Digital","WallArt" ];
  static List<String> certTypeformatch = ["All","Team","Player","Game"];
  static List<String> season = [ "Season 2023"];
  static List<String> teams = ["2023","2022","2021"];
  static List<String> events = ["Event 1", "Event 2", "Event 3"];
  static List<String> years = ["1991", "1992", "1994"];
  static List<String> cities = ["City 1", "City 2", "City 3"];

  var teamData = {
    "leagues": [
      {
        "name": "National",
        "icon": "",
        "regions": ["NFC East", "NFC West", "NFC North", "NFC South"],
        "teams": [
          {
            "name": "Arizona Cardinals",
            "icon": "",
            "region": "NFC East",
            "teamCode": "ac"
          },
          {
            "name": "Atlanta Falcons",
            "icon": "",
            "region": "NFC East",
            "teamCode": "af"
          },
          {
            "name": "Carolina Panthers",
            "icon": "",
            "region": "NFC West",
            "teamCode": "cp"
          },
          {
            "name": "Chicago Bears",
            "icon": "",
            "region": "NFC West",
            "teamCode": "cbe"
          },
          {
            "name": "Dallas Cowboys",
            "icon": "",
            "region": "NFC West",
            "teamCode": "dc"
          },
          {
            "name": "Detroit Lions",
            "icon": "",
            "region": "NFC West",
            "teamCode": "dl"
          },
          {
            "name": "Green Bay Packers",
            "icon": "",
            "region": "NFC West",
            "teamCode": "gbp"
          },
          {
            "name": "Los Angeles Rams",
            "icon": "",
            "region": "NFC West",
            "teamCode": "lar"
          },
          {
            "name": "Minnesota Vikings",
            "icon": "",
            "region": "NFC West",
            "teamCode": "mv"
          },
          {
            "name": "New Orleans Saints",
            "icon": "",
            "region": "NFC West",
            "teamCode": "nos"
          },
          {
            "name": "New York Giants",
            "icon": "",
            "region": "NFC West",
            "teamCode": "nyg"
          },
          {
            "name": "Philadelphia Eagles",
            "icon": "",
            "region": "NFC West",
            "teamCode": "pe"
          },
          {
            "name": "San Francisco 49ers",
            "icon": "",
            "region": "NFC West",
            "teamCode": "sf4"
          },
          {
            "name": "Seattle Seahawks",
            "icon": "",
            "region": "NFC West",
            "teamCode": "ss"
          },
          {
            "name": "Tampa Bay Buccaneers",
            "icon": "",
            "region": "NFC West",
            "teamCode": "tbb"
          },
          {
            "name": "Washington Commanders",
            "icon": "",
            "region": "NFC West",
            "teamCode": "wc"
          }
        ]
      },
      {
        "name": "American",
        "icon": "",
        "regions": ["AFC East", "AFC West", "AFC North", "AFC South"],
        "teams": [
          {
            "name": "Baltimore Ravens",
            "icon": "",
            "region": "NFC East",
            "teamCode": "br"
          },
          {
            "name": "Buffalo Bills",
            "icon": "",
            "region": "NFC East",
            "teamCode": "bb"
          },
          {
            "name": "Cincinnati Bengals",
            "icon": "",
            "region": "NFC East",
            "teamCode": "cb"
          },
          {
            "name": "Cleveland Browns",
            "icon": "",
            "region": "NFC East",
            "teamCode": "cbr"
          },
          {
            "name": "Denver Broncos",
            "icon": "",
            "region": "NFC East",
            "teamCode": "db"
          },
          {
            "name": "Houston Texans",
            "icon": "",
            "region": "NFC East",
            "teamCode": "ht"
          },
          {
            "name": "Indianapolis Colts",
            "icon": "",
            "region": "NFC East",
            "teamCode": "ic"
          },
          {
            "name": "Jacksonville Jaguars",
            "icon": "",
            "region": "NFC East",
            "teamCode": "jj"
          },
          {
            "name": "Kansas City Chiefs",
            "icon": "",
            "region": "NFC East",
            "teamCode": "kcc"
          },
          {
            "name": "Las Vegas Raiders",
            "icon": "",
            "region": "NFC East",
            "teamCode": "lvr"
          },
          {
            "name": "Los Angeles Chargers",
            "icon": "",
            "region": "NFC East",
            "teamCode": "lac"
          },
          {
            "name": "Miami Dolphins",
            "icon": "",
            "region": "NFC East",
            "teamCode": "md"
          },
          {
            "name": "New England Patriots",
            "icon": "",
            "region": "NFC East",
            "teamCode": "nep"
          },
          {
            "name": "New York Jets",
            "icon": "",
            "region": "NFC East",
            "teamCode": "nyj"
          },
          {
            "name": "Pittsburgh Steelers",
            "icon": "",
            "region": "NFC East",
            "teamCode": "ps"
          },
          {
            "name": "Tennessee Titans",
            "icon": "",
            "region": "NFC East",
            "teamCode": "tt"
          },
        ]
      }
    ]
  };
}