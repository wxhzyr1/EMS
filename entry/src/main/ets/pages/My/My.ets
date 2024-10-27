import { HmCard, HmCardItem } from '../../components'

@Preview
@Entry
@Component
struct MyPage {
  build() {
    Column(){
        Image($r('app.media.bg_page_my'))
          .width('100%')
          .backgroundColor($r('app.color.background_page'))
        Column({space: 10}){
          Image($r('app.media.ic_avatar_driver'))
            .width(50)
            .height(50)
            .borderColor(25)
            .margin({
              top: 80
            })
          Text("用户")
            .fontColor($r('app.color.white'))
            .fontSize(16)
          Text(`司机编号：11111`)
            .fontSize(14)
            .fontColor($r('app.color.white'))
          Text(`手机号：22222`)
            .fontSize(14)
            .fontColor($r('app.color.white'))
        }
        .alignItems(HorizontalAlign.Center)
        .position({
          y: 10
        }).width('100%')
      HmCard(){
          HmCardItem({
            leftTitle:"车辆信息",
            showBottomBorder:false
          })
        HmCardItem({
          leftTitle:"车辆信息",
          showBottomBorder:false
        })
        HmCardItem({
          leftTitle:"车辆信息",
          showBottomBorder:false
        })
        HmCardItem({
          leftTitle:"车辆信息"
        })
      }
    }.width('100%')
    .height('100%')
    .backgroundColor($r('app.color.background_page'))
    .alignItems(HorizontalAlign.Center)
  }
}
export  default MyPage