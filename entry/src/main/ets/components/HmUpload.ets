import { picker } from '@kit.CoreFileKit'
import { PickerOptions } from '@kit.MediaLibraryKit'
import { promptAction } from '@kit.ArkUI'

@Component
struct HmUpload{
  title:string=""
  selectImg(){
    promptAction.showToast({
      message:"ok"
    })
    const imgPicker=new picker.PhotoViewPicker()
    imgPicker.select({
      MIMEType:picker.PhotoViewMIMETypes.IMAGE_TYPE,
      maxSelectNumber:3
    })
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