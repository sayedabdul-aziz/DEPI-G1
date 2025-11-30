enum EnvironmentConfig { production, staging }

abstract class Environment {
  String get baseUrl;
}

class ProductionEnvironment extends Environment {
  @override
  String get baseUrl => 'https://se7ety.com';
}


class StagingEnvironment extends Environment {
  @override
  String get baseUrl => 'https://staging.se7ety.com';
}
