import { taskFrame } from '../../components'
import MyPage from '../My/My'

interface bars{
  title:string,
  name:string,
  icon:Resource
}
@Entry
@Component
struct HomePage {
  @State
  currentBar:string="task"
  @Builder
  barCard(item:bars){
    Column(){
      Image(item.icon).width(22).height(22).margin({
        bottom:5
      }).fillColor(this.currentBar===item.name?$r('app.color.primary'):$r('app.color.text_secondary'))
      Text(item.title).fontSize(10)
    }
  }
  tabBars:bars[]=[
    {
      title:'任务',
      name:'task',
      icon:$r('app.media.ic_tab_btn_task'),
    },
    {
      title:'信息',
      name:'message',
      icon:$r('app.media.ic_tab_btn_mess_nor')
    },
    {
      title:'我的',
      name:'mine',
      icon:$r('app.media.ic_tab_btn_mine_nor')
    }
  ]
  build() {
    Tabs({barPosition:BarPosition.End}){
      ForEach(this.tabBars,(item:bars)=>{
        TabContent(){
          if(item.name==="task")
          taskFrame()
          else if(item.name==="message")
            Text(item.name)
          else MyPage()
        }.tabBar(this.barCard(item))
      })
    }.onChange(index=>{
      this.currentBar=this.tabBars[index].name
    })
  }
}