import { picker } from '@kit.CoreFileKit'
import { fileIo as fs } from '@kit.CoreFileKit';
import { util } from '@kit.ArkTS';
import { promptAction } from '@kit.ArkUI';
import { request } from '@kit.BasicServicesKit';
import { uploadImg } from '../api';

@Component
struct HmUpload{
  title:string=""
  @State imgList:string[]=[]
  async selectImg(){
    let imgUpload:request.File[]=[]
    const imgPicker=new picker.PhotoViewPicker()
    const res=await imgPicker.select({
      MIMEType:picker.PhotoViewMIMETypes.IMAGE_TYPE,
      maxSelectNumber:3
    })
    this.imgList=res.photoUris
    const addFileName="lh"
    const defaultUri=getContext(this).cacheDir+"/"+addFileName
    if(this.imgList?.length){
      if(!fs.listFileSync(getContext(this).cacheDir).includes(addFileName)){
        fs.mkdirSync(defaultUri)
      }
      this.imgList.forEach(item=>{
        const file=fs.openSync(item,fs.OpenMode.READ_ONLY)
        const templateName=util.generateRandomUUID()+'.jpg'
        const fileName=defaultUri+"/"+templateName
        //文件描述符、目标路径
        fs.copyFileSync(file.fd,fileName)
        imgUpload.push({
          name:"file",
          filename:templateName,
          type:"jpg",
          uri:`internal://cache/${addFileName}/${templateName}`
        })
      })
    }
    // promptAction.showDialog({
    //   message:JSON.stringify(fs.listFileSync(defaultUri))
    // })
    uploadImg(getContext(this),imgUpload)
  }
  build() {
    Column(){
      Text(this.title).fontSize(14).fontColor($r('app.color.text_secondary'))
        .margin({
          top:16,
          bottom:16
        })
      Column(){
        Image($r('app.media.ic_add_img')).width(30).height(30)
      }.width(95).height(95).backgroundColor($r('app.color.gray_1'))
      .justifyContent(FlexAlign.Center).onClick(()=>this.selectImg())
    }.width('100%').alignItems(HorizontalAlign.Start)
  }
}
export {
  HmUpload
}