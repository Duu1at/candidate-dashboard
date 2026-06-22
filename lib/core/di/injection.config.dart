// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:candidate_dashboard/core/di/register_module.dart' as _i436;
import 'package:candidate_dashboard/data/datasources/local_datasource.dart'
    as _i293;
import 'package:candidate_dashboard/data/datasources/local_datasource_impl.dart'
    as _i704;
import 'package:candidate_dashboard/data/datasources/remote_datasource.dart'
    as _i84;
import 'package:candidate_dashboard/data/datasources/remote_datasource_impl.dart'
    as _i98;
import 'package:candidate_dashboard/data/repositories/candidate_repository.dart'
    as _i891;
import 'package:candidate_dashboard/data/repositories/candidate_repository_impl.dart'
    as _i367;
import 'package:candidate_dashboard/features/candidate_detail/cubit/candidate_detail_cubit.dart'
    as _i160;
import 'package:candidate_dashboard/features/candidates_list/cubit/candidates_list_cubit.dart'
    as _i864;
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
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i361.Dio>(() => registerModule.dio);
    gh.lazySingleton<_i84.RemoteDatasource>(
      () => _i98.RemoteDatasourceImpl(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i979.Box<String>>(
      () => registerModule.candidatesBox(),
      instanceName: 'candidates_box',
    );
    gh.lazySingleton<_i979.Box<String>>(
      () => registerModule.statusesBox(),
      instanceName: 'statuses_box',
    );
    gh.lazySingleton<_i293.LocalDatasource>(
      () => _i704.LocalDatasourceImpl(
        gh<_i979.Box<String>>(instanceName: 'candidates_box'),
        gh<_i979.Box<String>>(instanceName: 'statuses_box'),
      ),
    );
    gh.lazySingleton<_i891.CandidateRepository>(
      () => _i367.CandidateRepositoryImpl(
        gh<_i84.RemoteDatasource>(),
        gh<_i293.LocalDatasource>(),
      ),
    );
    gh.factory<_i160.CandidateDetailCubit>(
      () => _i160.CandidateDetailCubit(gh<_i891.CandidateRepository>()),
    );
    gh.factory<_i864.CandidatesListCubit>(
      () => _i864.CandidatesListCubit(gh<_i891.CandidateRepository>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i436.RegisterModule {}
