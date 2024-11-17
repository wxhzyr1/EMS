import { TaskDetailInfo, TaskDetailInfoModel, TaskListDataModel, TaskListParamsModel } from '../models'
import { axios } from '../untils'
import { http } from '@kit.NetworkKit'

export const getTaskList=(params:TaskListParamsModel)=>{
  return axios<TaskListDataModel>("/tasks/list",http.RequestMethod.GET,params)
}
export const getTaskDetails=(id:string)=>{
  return axios<TaskDetailInfoModel>(`/tasks/details/${id}`,http.RequestMethod.GET)
}