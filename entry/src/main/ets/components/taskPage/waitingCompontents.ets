import { getTaskList } from '../../api'
import { TaskListItem, TaskListItemModel, TaskListParams, TaskListParamsModel, TaskTypeEnum } from '../../models'
import TaskItemCard from './TaskItemCard'
import { HmLoading } from '../HmLoading'

@Preview
@Component
struct waitingComponents{
  @State
  queryParams:TaskListParamsModel=new TaskListParamsModel({
    pageSize:5,
    page:1,
    status:TaskTypeEnum.Waiting
  } as TaskListParams)
  @State
  taskListData:TaskListItemModel[]=[]
  aboutToAppear(): void {
    this.getTaskList()
  }
  allPages:number=1
  curPage:number=1
  @State
  loading:boolean=false
  @State
  showEnd:boolean=false
  @State
  showTopLoading:boolean=false
  async getMoreData(end:boolean){
    if(this.loading)return
    if(end)
    this.loading=true
    else {
      this.showEnd=false
      this.taskListData=[]
      this.curPage=1
      this.allPages=1
    }
    try {
      await this.getTaskList()
    }catch (error){
      this.taskListData=[new TaskListItemModel({"id":"4051509263315617565",startAgencyId:1024984540818568481,"startAddress":"辽宁抚顺顺城鸭绿江北街58-8号",endAgencyId:1024993422324415489,"endAddress":"湖北武汉武昌友谊大道194号附近","status":"1","driverId":"4051509263290324173","transportTaskId":"4051509263315485805","startHandover":"","finishHandover":"","planDepartureTime":"2024-05-15 20:00:00","actualDepartureTime":"","planArrivalTime":"2024-05-16 06:00:00","actualArrivalTime":"","created":"2024-05-15 09:26:33","enablePickUp":true})]
    } finally {
      this.loading=false
      this.showTopLoading=false
    }
  }
  async reachEnd(page:number){
    return await getTaskList(this.queryParams)
  }
  async getTaskList(){
    if(this.allPages<this.curPage){
      this.showEnd=true
      return
    }
    this.queryParams.page=this.curPage
    const res=await getTaskList(this.queryParams)
    this.allPages=res.pages
    //数组连接
    if(res.items.length)
    this.taskListData=this.taskListData.concat(res.items)
    this.curPage++
  }
  build() {
    Column(){
      Refresh({refreshing:$$this.showTopLoading}){
        List(){
          if(this.taskListData.length>0)
          ForEach(this.taskListData,(item:TaskListItemModel)=>{
            ListItem(){
              TaskItemCard({item})
            }
          })
          else{
            if(!this.loading){
              ListItem(){
                Text("暂无数据").width("100%").textAlign(TextAlign.Center)
              }.width("100%")
            }
          }
          if(this.showEnd)
          ListItem(){
            Text("人家也是有底线哒~~").width('100%').height(40).textAlign(TextAlign.Center)
          }
          if(this.loading)
          ListItem(){
            Row(){
              Text("正在加载中")
              HmLoading({hwidth:20})
            }.width('100%').justifyContent(FlexAlign.Center)
          }
        }.onReachEnd(()=>this.getMoreData(true)).height("100%")
      }.onStateChange(value=>{
        if(value===RefreshStatus.Refresh)this.getMoreData(false)
      }).height("100%")
    }.height("100%")
  }
}
export default waitingComponents