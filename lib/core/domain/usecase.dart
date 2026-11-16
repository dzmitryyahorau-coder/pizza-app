abstract class Usecase<Output, Params> {
  Future<Output> call(Params params);
}

class NoParams {
  const NoParams();
}
