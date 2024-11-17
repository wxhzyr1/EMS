import router from '@ohos.router'
import { TaskListItem, TaskListItemModel, TaskTypeEnum } from '../../models/task'
@Component
struct TaskItemCard {
  item:TaskListItemModel = new TaskListItemModel({} as TaskListItem)
  getBtnEnable(){
    if(this.item.enablePickUp){
      return true
    }
    const value = this.item.status.toString()
    switch (value){
      case TaskTypeEnum.Line.toString():
      case TaskTypeEnum.Delivered.toString():
        return true
    }
    return false
  }
  getBtnText(){
    const value = this.item.status.toString()
    switch (value){
      case TaskTypeEnum.Waiting.toString():
      return "提货"
      case TaskTypeEnum.Line.toString():
        return "交货"
      case TaskTypeEnum.Delivered.toString():
        return "回车登记"
      default :
        return "提货"
    }
  }

  //
  toPickUp(){
    router.pushUrl({
      url:'pages/HomePage/taskDetails',
      params:{
        id:this.item.id
      }
    })
  }
  build() {
    Column({space: 10}){
      Text(`任务编号：${this.item.transportTaskId}`)
      .fontSize(16)
      .fontColor($r('app.color.text_primary'))
      .fontWeight(500)
      .lineHeight(22)
      Row({space:10}){
        Text("起")
          .fontSize(12)
          .fontColor(Color.White)
          .width(22)
          .aspectRatio(1)
          .backgroundColor(Color.Black)
          .borderRadius(11)
          .textAlign(TextAlign.Center)
        Text(this.item.startAddress)
          .fontSize(14)
          .fontColor($r('app.color.text_secondary'))
      }.width('100%')

      Row({space:10}){
        Text("止")
          .fontSize(12)
          .borderRadius(11)
          .textAlign(TextAlign.Center)
          .fontColor(Color.White)
          .width(22)
          .aspectRatio(1)
          .backgroundColor(Color.Red)
        Text(this.item.endAddress)
          .fontSize(14)
          .fontColor($r('app.color.text_secondary'))
      }.width('100%')

      Divider()
      .vertical(true)
      .height(2)
      .color($r('app.color.gray_1'))
      .opacity(0.6)
      .margin({
        left:8,
        right: 8,
        top:21
      })
      Row(){
        Column(){
          Text("提货时间")
            .fontSize(14)
            .fontColor($r('app.color.text_secondary'))
          Text(this.item.planDepartureTime)
            .fontSize(14)
            .fontColor($r('app.color.text_secondary'))
            .margin({
              top: 4
            })

        }
        .alignItems(HorizontalAlign.Start)
        Button(this.getBtnText())
          .backgroundColor(this.getBtnEnable()? $r('app.color.primary') : $r('app.color.primary_disabled'))
          .fontColor("#FFFFFF")
          .fontSize(14)
          .height(32)
          .enabled(this.getBtnEnable())
          .onClick(()=>{
            this.toPickUp()
          })

      }.width('100%')
      .justifyContent(FlexAlign.SpaceBetween)

    }
    .padding({
      top: 10,
      bottom: 10,
      left: 20,
      right: 20
    })


  }
}

export default  TaskItemCard