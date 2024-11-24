import { Context } from '@ohos.arkui.UIContext'
import { request } from '@kit.BasicServicesKit'
import { BASE_URL, USER_TOKEN } from '../constants'
import { promptAction } from '@kit.ArkUI'

export const uploadImg=async (Context:Context,imgList:request.File[])=>{
  const config:request.UploadConfig={
    url:`${BASE_URL}/files/imageUplaod`,
    method:"POST",
    header:{
      'Authorization': AppStorage.get(USER_TOKEN)||'',
      "Content-Type": "multipart/form-data"
    },
    files:imgList,
    data:[]
  }
  try {
    const task=await request.uploadFile(Context,config)
    task.on("complete",res=>{
      promptAction.showDialog({
        message:"完成"+JSON.stringify(res)
      })
    })
    task.on("fail",error=>{
      promptAction.showDialog({
        message:"错误"+JSON.stringify(error)
      })
    })
  }catch (error){
    promptAction.showToast({
      message:JSON.stringify(error)
    })
  }
}