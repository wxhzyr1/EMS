import { getUserInfo, getUserTaskInfo } from '../../api'
import { HmCard, HmCardItem } from '../../components'
import { UserInfo, UserInfoModel, UserTaskInfo, UserTaskInfoModel, UsertaskInfoParamsModel } from '../../models'
import { promptAction, router } from '@kit.ArkUI'

@Preview
@Entry
@Component
struct MyPage {
  queryTaskParam:UsertaskInfoParamsModel=new UsertaskInfoParamsModel({
    month:(new Date().getMonth()+1).toString(),
    year:new Date().getFullYear().toString()
  })
  @State
  userMessage:UserInfoModel=new UserInfoModel({} as UserInfo)
  @State
  userTask:UserTaskInfoModel=new UserTaskInfoModel({} as UserTaskInfo)
  async getUserMessage(){
    this.userMessage=await getUserInfo()
  }
  async getUserTask(){
    this.userTask=await getUserTaskInfo(this.queryTaskParam)
  }
  aboutToAppear(): void {
    this.getUserMessage()
    this.getUserTask()
  }
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
          Text(this.userMessage.name?.toString())
            .fontColor($r('app.color.white'))
            .fontSize(16)
          Text(`司机编号：${this.userMessage.number?.toString()}`)
            .fontSize(14)
            .fontColor($r('app.color.white'))
          Text(`手机号：${this.userMessage.phone?.toString()}`)
            .fontSize(14)
            .fontColor($r('app.color.white'))
        }
        .alignItems(HorizontalAlign.Center)
        .position({
          y: 10
        }).width('100%')
      HmCard(){
        Column({space: 20}){
          Text("-本月任务-")
            .fontColor($r('app.color.text_primary'))
            .fontSize(14)
          Row(){
            Column({space: 20}){
              Text(this.userTask.taskAmounts?.toString()||"0")
                .fontSize(14)
                .fontColor($r('app.color.text_primary'))
              Text("任务总量")
                .fontSize(12)
                .fontColor($r('app.color.text_primary'))
            }.width(80)
            Column({space: 20}){
              //可选值不加问好调用方法crash
              Text(this.userTask.completedAmounts?.toString()||"0")
                .fontSize(14)
                .fontColor($r('app.color.text_primary'))
              Text("完成任务量")
                .fontSize(12)
                .fontColor($r('app.color.text_primary'))
            }.width(80)
            Column({space: 20}){
              Text(this.userTask.transportMileage?.toString()||"0")
                .fontSize(14)
                .fontColor($r('app.color.text_primary'))
              Text("运输历程(km)")
                .fontSize(12)
                .fontColor($r('app.color.text_primary'))
            }.width(80)
          }

          .width('100%')
          .padding({
            top: 10,
            left: 20,
            right: 20,
            bottom: 10
          })
          .justifyContent(FlexAlign.SpaceBetween)
        }
        .padding({
          top: 20,
          bottom: 20
        })
      }
      HmCard(){
          HmCardItem({
            leftTitle:"车辆信息",
            showBottomBorder:false,
          })
        HmCardItem({
          leftTitle:"任务数量",
          showBottomBorder:false
        })
        HmCardItem({
          leftTitle:"系统设置",
          showBottomBorder:false,
          onRightClick:()=>{
            router.pushUrl({
              url:'pages/StystemConfig/ConfigPage'
            })
          }
        })
      }
    }.width('100%')
    .height('100%')
    .backgroundColor($r('app.color.background_page'))
    .alignItems(HorizontalAlign.Center)
  }
}
export  default MyPage