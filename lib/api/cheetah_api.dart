import 'dart:async';

Future<String> getProfileUserName() async {
  await Future.delayed(Duration(seconds: 5));

  return "ghofrane";
}

Stream<int> getSessionTime() {
  return Stream.periodic(Duration(seconds: 1), (sessionTime) => sessionTime++);
}
