import { TaskListDataModel, TaskListParamsModel } from '../models'
import { axios } from '../untils'
import { http } from '@kit.NetworkKit'

export const getTaskList=(params:TaskListParamsModel)=>{
  return axios<TaskListDataModel>("/tasks/list",http.RequestMethod.GET,params)
}