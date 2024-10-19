import { http } from '@kit.NetworkKit'
import { USER_TOKEN } from '../constants';
import { BASE_URL } from '../models'
import { promptAction, router } from '@kit.ArkUI';

const httpRequest=http.createHttp()
export async  function requestHttp<T>(url:string,method:http.RequestMethod=http.RequestMethod.GET,data?:object,headers?:object){
  let httpUrl=BASE_URL+url;
  if(method===http.RequestMethod.GET&&data){
    const arr=Object.keys(data);
    let getUrl=arr.reduce((str:string,item:string)=>{
      return str+item+"="+data[item]+"&"
    },httpUrl+"?")
    getUrl=getUrl.substring(0,getUrl.length-2)
  }
  const httpConfig:http.HttpRequestOptions={
    method,
    extraData:method===http.RequestMethod.POST?data:"",
    connectTimeout:15000,
    header:{
      'Content-Type':"application/json",
      'Authorization': AppStorage.get(USER_TOKEN)
    }
  }
  try {
    const res=await httpRequest.request(httpUrl,httpConfig)
    if(res.responseCode===200){
      promptAction.showToast({
        message:"成功"
      })
      return Promise.resolve(JSON.parse(res.result as string))
    }
    else if(res.responseCode===404){
      router.pushUrl({
        url:'pages/notFound'
      })
    }
    else {
      promptAction.showToast({
        message:"错误"
      })
      return Promise.reject(new Error("未知错误"))
    }
  }catch (error){
    promptAction.showToast({
      message:"错误"
    })
    return Promise.reject(error)
  }
}