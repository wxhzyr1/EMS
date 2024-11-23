import { promptAction, router } from '@kit.ArkUI'
import { HmNavbarCard, HmToggle, HmUpload } from '../../components'
import { TaskDetailInfo,idParams, TaskDetailInfoModel, TaskTypeEnum } from '../../models'
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
  //获取提货状态
  getPickUpState() {
    return true
    // return this.taskDetailData.cargoPickUpPictureList?.length &&
    //         this.taskDetailData.cargoPictureList?.length &&
    //         this.taskDetailData.cargoPickUpPictureList.every(item => !!item.url) &&
    //         this.taskDetailData.cargoPictureList.every(item =>!!item.url)
  }
  //获取提货状态
  getDeliveryState() {
    return true
    // return this.taskDetailData.deliverPictureList?.length &&
    // this.taskDetailData.deliverPictureList?.length &&
    // this.taskDetailData.certificatePictureList.every(item => !!item.url) &&
    // this.taskDetailData.certificatePictureList.every(item =>!!item.url)
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
  getBottomBtn() {
    //已完成不显示任何按钮
    Row() {
      if (this.detailsData.status === TaskTypeEnum.Waiting) {
        Button("延迟收货", { type: ButtonType.Capsule })
          .backgroundColor($r('app.color.btn_gray'))
          .fontColor($r('app.color.text_primary'))
          .fontSize(16)
          .height(50)
          .width(125)
          .onClick(()=>{
            router.pushUrl({
              url: 'pages/deliay/Delay',
              params:{
                id:this.detailsData.id,
                oldTime:this.detailsData.planDepartureTime
              }
            })
          })
        Button("提货", { type: ButtonType.Capsule })
          .backgroundColor(this.getPickUpState() ? $r('app.color.primary') : $r('app.color.primary_disabled'))
          .fontColor($r('app.color.white'))
          .height(50)
          .flexGrow(1)
          .margin({ left: 13 })
          .enabled(this.getPickUpState())
          .onClick(() => {
            // this.btnPickUp()
          })
      } else if (this.detailsData.status === TaskTypeEnum.Line) {
        Button("上报异常", { type: ButtonType.Capsule })
          .backgroundColor($r('app.color.btn_gray'))
          .fontColor($r('app.color.text_primary'))
          .fontSize(16)
          .height(50)
          .width(125)
          .onClick(()=> {
            router.pushUrl({
              url: 'pages/ExceptionReport/ExceptionReport',
              params: {
                id: this.detailsData.transportTaskId
              }
            })
          })
        Button("交付", { type: ButtonType.Capsule })
          .backgroundColor(this.getDeliveryState() ? $r('app.color.primary') : $r('app.color.primary_disabled'))
          .fontColor($r('app.color.white'))
          .height(50)
          .flexGrow(1)
          .margin({ left: 13 })
          .enabled(this.getDeliveryState())
          .onClick(() => {
            // this.btnDeliver()

          })
      } else if (this.detailsData.status === TaskTypeEnum.Delivered) {

        Button("回车登记")
          .backgroundColor($r('app.color.primary'))
          .fontColor($r('app.color.white'))
          .height(50)
          .enabled(this.getDeliveryState())
          .onClick(() => {
            // this.toCarRecord()
          })
      }


    }
    .width('100%')
    .padding({ left: 15, right: 15 })
    .height(70)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor($r('app.color.white'))
    .position({ y: '100%' })
    .translate({ y: -70 })
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
          if(this.detailsData.status===TaskTypeEnum.Waiting)
          HmToggle({title:"提货信息" }){
            HmUpload({title:"请拍照上传凭证"})
            HmUpload({title:"请拍照上传货品"})
          }
          else if(this.detailsData.status===TaskTypeEnum.Line)
          HmToggle({title:"交货信息" }){
            HmUpload({title:"请拍照上传交货凭证"})
            HmUpload({title:"请拍照上传交货货品"})
          }
        }.width('100%').backgroundColor($r('app.color.gray_1'))
      }.padding({
        bottom:100,
      }).backgroundColor($r('app.color.gray_1'))
      this.getBottomBtn()
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