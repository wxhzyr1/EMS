import { login } from '../api';
import { USER_TOKEN } from '../constants';
import { userLoginInfo } from '../models';
import { UserSettingClass } from '../untils';
import { promptAction, router } from '@kit.ArkUI';

PersistentStorage.persistProp(USER_TOKEN,"")
@Entry
@Component
struct Login {
  @State
  @Watch('loginChange')
  login_message:userLoginInfo=new userLoginInfo({account:"yugege",password:"123456"})
  @State
  loading:boolean=false
  @State
  enabled_login:boolean=false
  store=new UserSettingClass(getContext())
  loginChange(){
    this.enabled_login=!!(this.login_message.account&&this.login_message.password)
  }
  setToken(){
    AppStorage.set<string>(USER_TOKEN,"token")
  }
   async login(){
    const token:string=await login(this.login_message)
    // promptAction.showToast({
    //   message:token
    // })
     AppStorage.set(USER_TOKEN,token)
     this.loading=false
     router.replaceUrl({
       url:'pages/HomePage/HomePage'
     })
  }
  build() {
    Column() {
      // 顶部标题
      Text("神领快递").fontColor($r('app.color.text_primary')).fontSize(18).height(25)
      // 账号登录
      Row() {
        Text('账号登录').fontColor($r('app.color.text_primary')).fontSize(24).fontWeight(FontWeight.Bold)
        Row() {
          Text("账号登录").fontColor($r('app.color.primary')).fontSize(16).fontWeight(FontWeight.Bold)
          Image($r("app.media.ic_angle")).width(10).height(10).margin({ left: 5 })
        }
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .margin({ top: 50, bottom: 50 })

      // 用户名输入框
      TextInput({ placeholder: '请输入账号',text:this.login_message.account }).margin({
        bottom:20
      }).onChange(val=>this.login_message.account=val)
      // 密码框
      TextInput({ placeholder: '请输入密码',text:this.login_message.password})
        .type(InputType.Password) // 密码框
        .showPasswordIcon(true) // 显示密码按钮
        .onChange(val=>this.login_message.password=val)
      // Text(JSON.stringify(this.login_message))
      // 登录按钮
      Button({ type: ButtonType.Capsule }) {

        Row() {
          if(this.loading)
          LoadingProgress().width(20).height(20).margin({ right: 12 }).color($r('app.color.white'))
          Text('登录').fontColor($r('app.color.white'))
        }
      }
      .stateStyles({
        normal: {.backgroundColor($r('app.color.primary'))
        },
        disabled: {.backgroundColor($r('app.color.text_secondary'))
        }
      })
      .width('100%')
      .enabled(this.enabled_login)
      .height(50)
      .margin({ top: 50 })
      .onClick(() =>{
        this.loading=true
        this.login()
      })
    }
    .padding({ left: 32, right: 32 })
    .margin({ top: 40 })
  }
}