import { AbilityConstant, UIAbility, Want } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { window } from '@kit.ArkUI';
import { UserSettingClass } from '../untils';
import { AdvertClass } from '../models';

export default class EntryAbility extends UIAbility {
  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onCreate');
  }

  onDestroy(): void {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onDestroy');
  }

  async onWindowStageCreate(windowStage: window.WindowStage): Promise<void> {
    // Main window is created, set main page for this ability
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageCreate');
    const preference= new UserSettingClass(this.context)
    const Online_Ad=await new Promise<AdvertClass>((resolve)=>{
      setTimeout(()=>{
        resolve({
          ad_show:true,
          ad_img:$r("app.media.1"),
          ad_time:5
        })
      },500)
    })
    await preference.setUserAd(Online_Ad);
    const advertise=await preference.getUserAd();
    if(advertise.ad_show)
      windowStage.loadContent('pages/advertise')
    else
      windowStage.loadContent('pages/login');
    // if(await preference.getToken())
    //   windowStage.loadContent('pages/HomePage/HomePage')
    // else
    //   windowStage.loadContent('pages/login');
  }

  onWindowStageDestroy(): void {
    // Main window is destroyed, release UI related resources
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
  }

  onForeground(): void {
    // Ability has brought to foreground
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onForeground');
  }

  onBackground(): void {
    // Ability has back to background
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onBackground');
  }
}
