import { http } from '@kit.NetworkKit'
import { userLogin } from '../models'
import { axios } from '../untils'
export const login=(data:userLogin)=>{
  return axios<string>("/login/account",http.RequestMethod.POST,data)
}