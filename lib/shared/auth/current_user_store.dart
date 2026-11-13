import 'package:pizza_app/shared/auth/models/user.dart';
import 'package:rxdart/subjects.dart';

class CurrentUserStore {
  final _subject = BehaviorSubject<User?>();

  Stream<User?> get stream => _subject.stream;
  User? get value => _subject.valueOrNull;

  void set(User? user) => _subject.add(user);

  void update(User Function(User) change) {
    final u = _subject.valueOrNull;
    if (u != null) _subject.add(change(u));
  }
}
