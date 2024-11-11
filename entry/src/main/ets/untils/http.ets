import { http } from '@kit.NetworkKit'
import { USER_TOKEN,BASE_URL } from '../constants';
import { promptAction, router } from '@kit.ArkUI';
import { httpType } from '.';

const httpRequest=http.createHttp()
async  function requestHttp<T>(url:string,method:http.RequestMethod=http.RequestMethod.GET,data?:object):Promise<T>{
  let httpUrl=BASE_URL+url;
  if(method===http.RequestMethod.GET&&data){
    const arr=Object.keys(data);
    let getUrl=arr.reduce((str:string,item:string)=>{

      return data[item]===undefined?str:str+item+"="+data[item]+"&"
      // return str+item+"="+data[item]+"&"
    },httpUrl+"?")
    httpUrl=getUrl.substring(0,getUrl.length-1)
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
    // AlertDialog.show({
    //   message:httpUrl+"--"+JSON.stringify(httpConfig)
    // })
    // httpUrl="https://slwl-api.itheima.net/driver/tasks/list?page=1&pageSize=5&status=1"
    const res=await httpRequest.request(httpUrl,httpConfig)
    const result=JSON.parse(res.result as string) as httpType<T>
    console.log(JSON.stringify(result))
    if(result.code===200){
      promptAction.showToast({
        message:"成功"
      })
      return Promise.resolve(result.data as T)
    }
    else if(res.responseCode===404){
      router.pushUrl({
        url:'pages/notFound'
      })
      return Promise.reject(new Error("404"))
    }
    else {
      // AlertDialog.show({
      //   message:JSON.stringify(result)
      // })
      // promptAction.showToast({
      //   message:"错误"
      // })
      return Promise.reject(new Error("未知错误"))
    }
  }catch (error){
    promptAction.showToast({
      message:"错误"
    })
    return Promise.reject(error)
  }
}
export function axios<T>(url:string,method:http.RequestMethod,data?:object):Promise<T>{
  console.log(JSON.stringify(data))
  return requestHttp<T>(url,method,data)
}