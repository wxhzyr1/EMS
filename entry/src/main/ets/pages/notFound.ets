@Entry
@Component
struct NotFound {
  @State message: string = '404';

  build() {
    RelativeContainer() {
      Text(this.message)
        .id('NotFoundHelloWorld')
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
        .alignRules({
          center: { anchor: '__container__', align: VerticalAlign.Center },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        })
    }
    .height('100%')
    .width('100%')
  }
}