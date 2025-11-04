abstract class Failure implements Exception{
  const Failure();
}

class NetworkFailure extends Failure {
  const NetworkFailure();
}

class ServerFailure extends Failure {
  const ServerFailure();
}

class KeyFailure extends Failure{
  const KeyFailure();
}

class AIFailure extends Failure{
  const AIFailure();
}

class UnknownFailure extends Failure {
  const UnknownFailure();
}