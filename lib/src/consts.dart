final String _apiBaseUrl = 'http://10.0.2.2:8080/';

final String loginUrl = _apiBaseUrl + 'login'; 
final String registerUrl = _apiBaseUrl + 'api/users/register';
final String usersUrl = _apiBaseUrl + 'api/users';
final String activateUserUrl = _apiBaseUrl + 'api/users/activate/'; // + userId
final String deactivateUserUrl = _apiBaseUrl + 'api/users/deactivate/'; // + userId
final String getUserByEmail = _apiBaseUrl + 'api/users/email/'; // + email
