import { getTaskList } from '../../api'
import { TaskListItemModel, TaskListParams, TaskListParamsModel, TaskTypeEnum } from '../../models'
import TaskItemCard from './TaskItemCard'
import { faceDetector } from '@kit.CoreVisionKit'
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
//   new TaskListItemModel({
//   actualArrivalTime : '2024/11/10',
//   actualDepartureTime : '2024/11/12',
//   created : '2024/11/8',
//   driverId : '1',
//   enablePickUp : false,
//   endAddress : '河南省信阳市平桥区',
//   endAgencyId : 0,
//   finishHandover : '',
//   id : '1',
//   planArrivalTime : '2024/11/10',
//   planDepartureTime : '2024/11/9',
//   startAddress : '2024/11/9',
//   startAgencyId : 0,
//   startHandover : '',
//   transportTaskId: '3',
//   status:"ok"
// })
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
  async getTaskList(){
    if(this.allPages<this.curPage){
      this.showEnd=true
      return
    }
    this.queryParams.page=this.curPage
    const res=await getTaskList(this.queryParams)
    this.allPages=res.pages
    //数组连接
    this.taskListData=this.taskListData.concat(res.items)
    this.curPage++
  }
  build() {
    Column(){
      List(){
        ForEach(this.taskListData,(item:TaskListItemModel)=>{
          ListItem(){
            TaskItemCard({item})
          }
        })
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
      }.onReachEnd(async ()=>{
        if(this.loading)return
        this.loading=true
        await this.getTaskList()
        this.loading=false
      })
    }
  }
}
export default waitingComponents