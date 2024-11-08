import { promptAction } from '@kit.ArkUI'

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
          Text(name)
        }.tabBar(this.tabItem(name))
      })
    }.onChange(index=>{
      this.curBar=this.tabNameList[index]
    }).barWidth(200)

  }
}
export {taskFrame}