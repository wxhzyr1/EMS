@Component
struct HmCard{
  @BuilderParam
  content:Function
  build() {
    Column(){
      Column(){
        if(this.content)
        this.content()
      }.width('100%')
      .backgroundColor($r('app.color.white'))
      .borderRadius(10)
      .padding({
        left:15,
        right:15
      })
    }.width('100%')
    .padding(15)
  }
}
export {HmCard}