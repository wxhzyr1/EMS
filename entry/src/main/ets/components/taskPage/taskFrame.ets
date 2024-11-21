import { promptAction } from '@kit.ArkUI'
import { TaskListParams, TaskListParamsModel, TaskTypeEnum } from '../../models'
import waitingComponents from './waitingCompontents'

@Preview
@Component
struct taskFrame{
  @State
  curBar:string='待提货'
  @Builder
  tabItem(name:string){
    Column(){
      Text(name).animation({
        duration:500
      })
      if(this.curBar===name)
      Divider().margin({
        top:1,
        left:1,
        right:1,
      }).height(2).width(20).backgroundColor($r('app.color.success'))
        .animation({
          duration:500
        })
    }
  }
  tabNameList:string[]=['待提货','在送','已完成']
  build() {
    Tabs({barPosition:BarPosition.Start}){
      ForEach(this.tabNameList,(name:string)=>{
        TabContent(){
          if(name===this.tabNameList[0])
            waitingComponents()
          else if(name===this.tabNameList[1])
            waitingComponents({queryParams:new TaskListParamsModel(
              {
                page:1,
                pageSize:5,
                status:TaskTypeEnum.Line
              } as TaskListParams
            )})
        }.tabBar(this.tabItem(name))
      })
    }.onChange(index=>{
      this.curBar=this.tabNameList[index]
    }).barWidth(200)

  }
}
export {taskFrame}