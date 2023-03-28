class User {
  String _firstName;
  String _lastName;
  String _email;
  String _password;
  String _gender;
  String _profileImageUrl =
      "https://this-person-does-not-exist.com/img/avatar-gen11571b13d1ed1c76e1411b91391b343c.jpg";
  DateTime _dateOfBirth;
  double _weight;
  double _height;

  User(this._firstName, this._lastName, this._email, this._password,
      this._gender, this._dateOfBirth, this._weight, this._height);

  String get profileImageUrl => _profileImageUrl;
  set profileImageUrl(String value) => _profileImageUrl = value;

  String get firstName => _firstName;
  set firstName(String value) => _firstName = value;

  String get lastName => _lastName;
  set lastName(String value) => _lastName = value;

  String get email => _email;
  set email(String value) => _email = value;

  String get password => _password;
  set password(String value) => _password = value;

  String get gender => _gender;
  set gender(String value) => _gender = value;

  DateTime get dateOfBirth => _dateOfBirth;
  set dateOfBirth(DateTime value) => _dateOfBirth = value;

  double get weight => _weight;
  set weight(double value) => _weight = value;

  double get height => _height;
  set height(double value) => _height = value;
}
