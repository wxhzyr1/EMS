import { http } from '@kit.NetworkKit'
import { UserInfoModel, userLogin, UserTaskInfoModel, UsertaskInfoParamsModel } from '../models'
import { axios } from '../untils'
export const login=(data:userLogin)=>{
  return axios<string>("/login/account",http.RequestMethod.POST,data)
}
export const getUserInfo=()=>{
  return axios<UserInfoModel>("/users",http.RequestMethod.GET)
}
export const getUserTaskInfo=(data:UsertaskInfoParamsModel)=>{
  return axios<UserTaskInfoModel>("/users/taskReport",http.RequestMethod.GET,data)
}