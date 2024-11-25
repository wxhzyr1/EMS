import { Context } from '@ohos.arkui.UIContext'
import { request } from '@kit.BasicServicesKit'
import { BASE_URL, USER_TOKEN } from '../constants'
import { promptAction } from '@kit.ArkUI'
import { axios } from '../untils'
import { http } from '@kit.NetworkKit'
import { ImagesList, ImagesListModel } from '../models/Common'

export const uploadImg=async (Context:Context,imgList:request.File[])=>{
  const config:request.UploadConfig={
    url:`${BASE_URL}/files/imageUpload`,
    method:"POST",
    header:{
      'Authorization': AppStorage.get(USER_TOKEN)||'',
      "Content-Type": "multipart/form-data"
    },
    files:imgList,
    data:[]
  }
  try {
    // return new Promise(async (resolve,reject)=>{
      const task=await request.uploadFile(Context,config)
      task.on("complete",async (res)=>{
        const result=await Promise.all(imgList.map(item=>{
          axios<string>("/files/imageUrl",http.RequestMethod.GET,{
            fileName:item.filename.slice(0,item.filename.indexOf('.'))
          } as fileParam)
        }))
        promptAction.showDialog({
          message:JSON.stringify(result)
        })
        // resolve(result.map(item => new ImagesListModel({url:item})))
      })
      task.on("fail",error=>{
        promptAction.showDialog({
          message:"错误"+JSON.stringify(error)
        })
        // reject(new Error("上传失败"))
      })
    // })
  }catch (error){
    promptAction.showToast({
      message:JSON.stringify(error)
    })
  }
}
interface  fileParam{
  fileName:string
}