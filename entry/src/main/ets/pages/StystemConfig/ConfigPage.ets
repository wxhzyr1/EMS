import { HmCard, HmCardItem,HmNavbarCard } from '../../components'

@Preview
@Entry
@Component
struct ConfigPage {
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
      }.padding({
        left:15,
        right:15
      })
    }.width('100%')
    .height('100%')
    .backgroundColor($r('app.color.background_divider'))
  }
}