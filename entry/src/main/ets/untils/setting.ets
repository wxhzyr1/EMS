import preferences from '@ohos.data.preferences';
export class UserSettingClass{
  context:Context
  constructor(context:Context) {
    this.context=context
  }
  getStore(){
    return preferences.getPreferences(this.context,"")
  }
}