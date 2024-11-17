import { promptAction, router } from '@kit.ArkUI'
import { HmNavbarCard, HmToggle } from '../../components'
import { TaskDetailInfo,idParams, TaskDetailInfoModel } from '../../models'
import {getTaskDetails} from '../../api'
@Preview
@Entry
@Component
struct taskDetails{
  @State
  detailsData:TaskDetailInfoModel=new TaskDetailInfoModel({} as TaskDetailInfo)
  async getTaskDetails(){
    this.detailsData=await getTaskDetails((router.getParams() as idParams).id)
  }
  aboutToAppear(): void {
    this.getTaskDetails()
  }
  build() {
    Column(){
      HmNavbarCard({NavbarTitle:'任务详情',showBack:true})
      Column(){
        HmToggle({title:"测试" }){
          Text("测试")
        }
        HmToggle({title:"测试" }){
          Text("测试")
        }
        HmToggle({title:"测试" }){
          Text("测试")
        }
      }.width('100%').backgroundColor($r('app.color.gray_1'))
    }
  }
}