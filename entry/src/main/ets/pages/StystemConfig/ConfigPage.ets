import { HmCard, HmCardItem,HmNavbarCard, UserDialog } from '../../components'
import { USER_TOKEN } from '../../constants'
import { router } from '@kit.ArkUI'

PersistentStorage.persistProp(USER_TOKEN,"")
@Preview
@Entry
@Component
struct ConfigPage {
  Controller:CustomDialogController=new CustomDialogController({
    builder:UserDialog({
      title:"确认退出登录？",
      Confirm:{
        show:true,
        handleClick:async ()=>{
          AppStorage.set(USER_TOKEN,"")
          this.Controller.close()
          router.replaceUrl({
            url:'pages/login'
          })
        }
      },
      Chancel:{
        show:true,
        handleClick:()=>{
          this.Controller.close()
        }
      }
    }),
    alignment:DialogAlignment.Center,
    autoCancel:false
  })
  build() {
    Column(){
      HmNavbarCard({showBack:true,NavbarTitle:'设置'})
      HmCard(){
        HmCardItem({leftTitle:"换绑手机",rightTitle:''})
        HmCardItem({leftTitle:"修改密码",rightTitle:''})
        HmCardItem({leftTitle:"消息通知设置",rightTitle:''})
        HmCardItem({leftTitle:"清理缓存",showBottomBorder:false,rightTitle:''})
      }
      Column(){
        Button("退出",{type:ButtonType.Normal})
          .width('100%')
          .height(60)
          .fontColor($r('app.color.black'))
          .backgroundColor($r('app.color.white'))
          .onClick(()=>this.Controller.open())
      }.padding({
        left:15,
        right:15
      })
    }.width('100%')
    .height('100%')
    .backgroundColor($r('app.color.background_divider'))
  }
}