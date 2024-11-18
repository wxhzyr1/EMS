@Component
struct HmUpload{
  title:string=""
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
      .justifyContent(FlexAlign.Center)
    }.width('100%').alignItems(HorizontalAlign.Start)
  }
}
export {
  HmUpload
}