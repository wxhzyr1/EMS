import { AdvertClass } from '../models'
import { UserSettingClass } from '../untils'
import { router } from '@kit.ArkUI'

@Entry
@Component
struct Advertise {
  @State
  advertise:AdvertClass={
    ad_url:'',
    ad_img:'',
    ad_time:5,
    ad_show:true
  }
  interval:number=0
  async aboutToAppear(): Promise<void> {
    const preference=await new UserSettingClass(getContext(this))
    this.advertise=await preference.getUserAd()
    this.interval=setInterval(()=>{
      this.advertise.ad_time--;
      if(!this.advertise.ad_time){
        clearInterval(this.interval);
        router.replaceUrl({
          url:"pages/Index"
        })
      }
    },1000)
  }
  build() {
    Stack({alignContent:Alignment.TopEnd}){
      Image(this.advertise.ad_img).height("100%").width("100%").objectFit(ImageFit.Cover)
      Text(this.advertise.ad_time+"秒后跳过").margin("10").backgroundColor($r("app.color.btn_gray"))
        .borderRadius(10).padding({
        left:8,
        right:8,
        top:2,
        bottom:2
      }).onClick(()=>{
        router.replaceUrl({
          url:"pages/Index"
        })
      })
    }
  }
}