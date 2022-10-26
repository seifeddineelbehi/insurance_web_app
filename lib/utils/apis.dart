//end points

const String localURL = "http://127.0.0.1:8000";
//const String localURL = "https://assurance-backend.herokuapp.com";
//const String localURL = "https://assurance-backend.herokuapp.com";
//const String localURL = "https://assurance-backend.softago.tech";

const String hostURL = "https://assurance-backend.herokuapp.com";

//Admins

const String LoginAdmin = "/admin/login/";

const String DetailAdmin = "/admin/protected/";

const String AllConstatNonTraite = "/admin/AccidentNonTraite/";
const String AllVolsNonTraite = "/admin/VolNonTraite/";
const String AllBrisesNonTraite = "/admin/BrisesNonTraite/";
const String AllIncendiesNonTraite = "/admin/IncendiesNonTraite/";

const String AllConstatTraite = "/admin/AccidentTraite/";
const String AllVolsTraite = "/admin/VolsTraite/";
const String AllBrisesTraite = "/admin/BrisesTraite/";
const String AllIncendiesTraite = "/admin/IncendiesTraite/";

const String AllConstatRejete = "/admin/AccidentRejete/";
const String AllVolsRejete = "/admin/VolRejete/";
const String AllBrisesRejete = "/admin/BrisesRejete/";
const String AllIncendiesRejete = "/admin/IncendiesRejete/";

const String lengthConstat = "/admin/ConstatLengthDetails/";
const String lengthVolsApi = "/admin/VolsLengthDetails/";
const String lengthBriseApi = "/admin/BrisesLengthDetails/";
const String lengthIncendiesApi = "/admin/IncendiesLengthDetails/";

const String updateConstatAccident = "/admin/updateAccident/";
const String updateVolsApi = "/admin/updateVol/";
const String updateBriseApi = "/admin/updateBrise/";
const String updateIncendieApi = "/admin/updateIncendie/";

const String AllAdmins = "/admin/allAdmin/";

const String AddNewAdmin = "/admin/createAdmin";
const String UpdateAdminApi = "/admin/updateAdmin";

const String AddNewClient = "/admin/createClient";

const String getAllClientsApi = "/admin/allClients";
const String getDetailClientsApi = "/admin/clientDetailByCodeClient/";
