part of 'wrapper_bloc.dart';

sealed class WrapperState {}

final class WrapperInitialState extends WrapperState {}

//mobilepages
final class HomePageSelectedMobile extends WrapperState {}

final class UploadPageSelectedMobile extends WrapperState {}

final class ExplorePageSelectedMobile extends WrapperState {}

final class ProfilePageSlectedMobile extends WrapperState {}

//web pages
final class HomePageSelectedWeb extends WrapperState {}

final class UploadPageSelectedWeb extends WrapperState {}

final class ExplorePageSelectedWeb extends WrapperState {}

final class NotificationPageSelectedWeb extends WrapperState {}

final class MessagePageSelectedWeb extends WrapperState {}

final class SearchPageSelectedWeb extends WrapperState {}

final class ProfilePageSelectedWeb extends WrapperState {}
