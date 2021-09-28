import 'package:bloc/bloc.dart';
import 'package:profiles_app/blocs/states/accountStates.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountCubit extends Cubit<AccountStates>{
  AccountCubit():super(AccountInitialState());

  bool isHidePassword = true;
  late SharedPreferences saveLoginOnSharedPreferences;


  void hidePassword(){
    isHidePassword = !isHidePassword;
    emit(HidePasswordState());
  }

  Future<void> saveLoginOnMyDevice(bool saveLogin)async{
    saveLoginOnSharedPreferences = await SharedPreferences.getInstance();
    saveLoginOnSharedPreferences.setBool('saveLogin',saveLogin);
    emit(SaveLoginState());
  }

  Future<bool?> isLoginSaved()async{
    saveLoginOnSharedPreferences = await SharedPreferences.getInstance();
    emit(SaveLoginState());
    return saveLoginOnSharedPreferences.getBool('saveLogin');
  }

}