import { HmCardItem } from '.'

@Preview
@CustomDialog
@Component
struct UserDialog{
  Controller:CustomDialogController=new CustomDialogController({
    builder:HmCardItem
  })
  @Prop
  title:string='测试'
  Confirm:buttonClass={
    show:false,
    handleClick:()=>{}
  }
  Chancel:buttonClass={
    show:false,
    handleClick:()=>{}
  }

  build() {
    Column(){
      Text(this.title).height(88)
      Row(){
        if(this.Chancel.show)
        Button('取消',{type:ButtonType.Normal}).border({
          width:{
            right:this.Confirm.show&&this.Chancel.show?0.5:0
          },
          color:$r('app.color.text_placeholder')
        }).backgroundColor($r('app.color.white'))
          .height('100%').fontColor($r('app.color.black'))
          .layoutWeight(1).onClick(this.Chancel.handleClick)
        if(this.Confirm.show)
        Button('确定',{type:ButtonType.Normal})
          .backgroundColor($r('app.color.white'))
          .height('100%').layoutWeight(1).fontColor($r('app.color.primary'))
          .onClick(this.Confirm.handleClick)
      }.height(49)
      .justifyContent(FlexAlign.SpaceAround)
    }.width(278).borderRadius(12)
    .alignItems(HorizontalAlign.Center)
  }
}
export {UserDialog}
class buttonClass{
  show:boolean=false
  handleClick:()=>void=()=>{}
}