import { promptAction, router } from '@kit.ArkUI'
import { HmNavbarCard, HmToggle, HmUpload } from '../../components'
import { TaskDetailInfo,idParams, TaskDetailInfoModel } from '../../models'
import {getTaskDetails} from '../../api'
@Preview
@Entry
@Component
struct taskDetails{
  scrollController:Scroller=new Scroller()
  @State
  detailsData:TaskDetailInfoModel=new TaskDetailInfoModel({} as TaskDetailInfo)
  async getTaskDetails(){
    this.detailsData=await getTaskDetails((router.getParams() as idParams).id)
  }
  aboutToAppear(): void {
    this.getTaskDetails()
  }
  @Builder
  getBaseContent() {
    Row() {
      Column() {
        Row() {
          Text("起").baseTextOneStyle()
          Text(this.detailsData.startAddress)
            .baseTextTwoStyle()
        }.margin({ top: 21 })

        Row() {
          Text("止")
            .baseTextOneStyle().backgroundColor($r('app.color.primary'))
          Text(this.detailsData.endAddress)
            .baseTextTwoStyle()
        }
        .margin({ top: 14.5 })
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
      .margin({
        right: 20
      })

      Column() {
        Image($r("app.media.ic_navigation"))
          .width(22)
          .height(22)
        Text("开始导航")
          .fontSize(14)
          .margin({ top: 10, bottom: 10 })
      }
      .margin({ top: 20 })
      .justifyContent(FlexAlign.SpaceBetween)
      .onClick(()=>{
        router.pushUrl({
          url: 'pages/Navigation/NavigationPage',
          params:{
            start: this.detailsData.startAddress,
            end: this.detailsData.endAddress
          }

        })
      })

    }.justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .width('100%')

    Divider().vertical(true).height(4)
      .color($r('app.color.background_divider'))
      .margin({
        left: 8,
        right: 8
      })
    this.getBaseContentItem({
      title: '任务编号',
      value: this.detailsData.transportTaskId
    })
    this.getBaseContentItem({
      title: '联系人',
      value: this.detailsData.startHandoverName
    })
    this.getBaseContentItem({
      title: "联系电话",
      value: this.detailsData.startHandoverPhone,
      icon: $r('app.media.ic_phone'),
      itemClick: ()=>{
        // call.makeCall(this.detailsData.startHandoverPhone)
      }
    })

    this.getBaseContentItem({
      title: '提货时间',
      value: this.detailsData.planDepartureTime
    })
    this.getBaseContentItem({
      title: '预计送达时间',
      value: this.detailsData.planArrivalTime
    })
  }
  @Builder
  getBaseContentItem(item: BaseBuilderclass) {
    Row() {
      Text(item.title)
        .fontSize(14)
        .fontColor($r('app.color.text_secondary'))
        .lineHeight(20)
      Row() {
        Text(item.value).fontSize(14).fontColor($r('app.color.text_secondary'))
        if (item.icon) {
          Image(item.icon).width(24).height(24)
        }
      }
      .onClick(()=>{
        item.itemClick?.()
      })

    }.justifyContent(FlexAlign.SpaceBetween).width('100%').margin({
      top: 14
    })
  }
  @Builder
  getDriverContent() {
    Row() {
      Text("车牌号").fontSize(14).fontColor($r('app.color.text_secondary')).lineHeight(20)
      Text(this.detailsData.licensePlate).fontSize(14).fontColor($r('app.color.text_secondary'))
    }
    .justifyContent(FlexAlign.SpaceBetween).width('100%')
    .margin({ top: 14 })

    Row() {
      Text("司机姓名").fontSize(14).fontColor($r('app.color.text_secondary'))
        .lineHeight(20)
      Text(this.detailsData.driverName).fontSize(14).fontColor($r('app.color.text_secondary'))
    }
    .justifyContent(FlexAlign.SpaceBetween).width('100%')
    .margin({ top: 14 })

  }

  @Builder
  getTransLineContent() {
    Row() {
      Column() {
        Text(this.detailsData.startProvince)
          .fontSize(16)
          .fontColor($r('app.color.text_primary'))
          .lineHeight(22)
          .fontWeight(600)
        Text(this.detailsData.startCity).fontSize(14).lineHeight(22)
      }.width(50)

      Image($r("app.media.ic_right_arrow")).width(36).height(16)
      Column() {
        Text(this.detailsData.endProvince)
          .fontSize(16)
          .fontColor($r('app.color.text_primary'))
          .lineHeight(22)
          .fontWeight(600)
        Text(this.detailsData.endCity).fontSize(14).lineHeight(22)
      }.width(50)
    }
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .width('100%')
    .padding({ left: 60, right: 60 })
  }
  build() {
    Column(){
      HmNavbarCard({NavbarTitle:'任务详情',showBack:true})
      Scroll(this.scrollController){
        Column(){
          HmToggle({title:"基本信息" }){
            this.getBaseContent()
          }
          HmToggle({title:"路线信息" }){
            this.getTransLineContent()
          }
          HmToggle({title:"司机信息" }){
            this.getDriverContent()
          }
          HmToggle({title:"提货信息" }){
            HmUpload({title:"请拍照上传凭证"})
            HmUpload({title:"请拍照上传货品"})
          }
        }.width('100%').backgroundColor($r('app.color.gray_1'))
      }.padding({
        bottom:100,
      }).backgroundColor($r('app.color.gray_1'))
    }
  }
}
@Extend(Text) function baseTextOneStyle() {
  .fontSize(12)
  .fontColor($r('app.color.white'))
  .backgroundColor($r('app.color.text_primary'))
  .width(22)
  .height(22)
  .borderRadius(11)
  .textAlign(TextAlign.Center)
}
@Extend(Text) function baseTextTwoStyle() {
  .margin({ left: 11.5 }).fontColor($r('app.color.text_secondary'))
}

class BaseBuilderclass {
  title: string = ""
  value: string = ""
  icon?: ResourceStr = ""
  itemClick?: ()=>void = ()=>{}
}