// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:candidate_dashboard/core/core.dart' as _i712;
import 'package:candidate_dashboard/core/di/network_module.dart' as _i839;
import 'package:candidate_dashboard/data/data.dart' as _i846;
import 'package:candidate_dashboard/data/datasources/local/local_datasource_impl.dart'
    as _i581;
import 'package:candidate_dashboard/data/datasources/remote/remote_datasource_impl.dart'
    as _i673;
import 'package:candidate_dashboard/data/repositories/candidate_repository_impl.dart'
    as _i367;
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:hive/hive.dart' as _i979;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final networkModule = _$NetworkModule();
    gh.lazySingleton<_i712.MockInterceptor>(
      () => networkModule.mockInterceptor,
    );
    gh.lazySingleton<_i712.ConnectionService>(
      () => networkModule.connectionService,
    );
    gh.lazySingleton<_i979.Box<String>>(
      () => networkModule.candidatesBox(),
      instanceName: 'candidates_box',
    );
    gh.lazySingleton<_i979.Box<String>>(
      () => networkModule.statusesBox(),
      instanceName: 'statuses_box',
    );
    gh.lazySingleton<_i361.Dio>(
      () => networkModule.dio(gh<_i712.MockInterceptor>()),
    );
    gh.lazySingleton<_i712.ApiClient>(
      () => networkModule.apiClient(
        gh<_i361.Dio>(),
        gh<_i712.ConnectionService>(),
      ),
    );
    gh.lazySingleton<_i846.LocalDatasource>(
      () => _i581.LocalDatasourceImpl(
        gh<_i979.Box<String>>(instanceName: 'candidates_box'),
        gh<_i979.Box<String>>(instanceName: 'statuses_box'),
      ),
    );
    gh.lazySingleton<_i846.RemoteDatasource>(
      () => _i673.RemoteDatasourceImpl(gh<_i712.ApiClient>()),
    );
    gh.lazySingleton<_i846.CandidateRepository>(
      () => _i367.CandidateRepositoryImpl(
        remote: gh<_i846.RemoteDatasource>(),
        local: gh<_i846.LocalDatasource>(),
        connection: gh<_i712.ConnectionService>(),
      ),
    );
    return this;
  }
}

class _$NetworkModule extends _i839.NetworkModule {}
