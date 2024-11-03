import { router } from '@kit.ArkUI'

@Preview
@Component
struct HmNavbarCard{
  @Prop
  showBack:boolean=false
  NavbarTitle:string="测试标题"
  build() {
    Stack({alignContent:Alignment.Start}){
      Column(){
        Text(this.NavbarTitle)
      }.width('100%').alignItems(HorizontalAlign.Center)
      if (this.showBack)
      Image($r('app.media.ic_btn_nav_back')).width(40).height(40)
        .onClick(()=>{
          router.back()
        })
    }.width('100%')
    .height(50)
    .backgroundColor($r('app.color.white'))
  }
}
export {
  HmNavbarCard
}