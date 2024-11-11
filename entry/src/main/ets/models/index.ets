export * from './advert'
export * from './user_login'
export * from './task'
export class ResponseData<T>{
  code:number=0
  msg:string=''
  data:T|null=null
}