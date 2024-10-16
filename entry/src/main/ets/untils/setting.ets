import preferences from '@ohos.data.preferences';
import { USER_SETTING, USER_SETTING_AD } from '../constants';
import { AdvertClass } from '../models';

export class UserSettingClass{
  context:Context
  constructor(context:Context) {
    this.context=context
  }
  user_default_ad:AdvertClass={
    ad_show:true,
    ad_img:$r('app.media.start'),
    ad_time:5
  }
  getStore(){
    return preferences.getPreferences(this.context,USER_SETTING)
  }
  async getUserAd():Promise<AdvertClass>{
    const userStore=await this.getStore();
    const advise:AdvertClass= JSON.parse(await userStore.get(USER_SETTING_AD,JSON.stringify(this.user_default_ad)) as string) as AdvertClass
    return advise
  }
  async setUserAd(advise:AdvertClass){
    const store=await this.getStore();
    await store.put(USER_SETTING_AD,JSON.stringify(advise))
    await store.flush()
  }
}