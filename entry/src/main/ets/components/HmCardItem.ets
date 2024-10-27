@Preview
@Component
struct HmCardItem{
  @Prop
  rightTitle:string="XXXX"
  leftTitle:string="车辆信息"
  showIcon:boolean=true
  onRightClick:Function=()=>{}
  showBottomBorder:boolean=true
  build() {
    Row(){
      Text(this.leftTitle).fontSize(14)
        .fontColor($r('app.color.text_primary'))
      Row(){
        if(this.rightTitle)
        Text(this.rightTitle).fontColor($r('app.color.text_secondary'))
        if(this.showIcon)
        Image($r('app.media.ic_btn_more')).width(24)
          .height(24)
      }.onClick(this.onRightClick())
    }.backgroundColor($r('app.color.white'))
    .height(60).width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .border({
      color:$r('app.color.background_divider'),
      width:{
        bottom:this.showBottomBorder?1:0
      }
    })
  }
}
export {HmCardItem}