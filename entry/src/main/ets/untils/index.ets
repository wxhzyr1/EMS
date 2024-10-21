import { http } from '@kit.NetworkKit'

export * from './setting'
export * from './http'
export class httpType<T>{
  code:number=0
  method:http.RequestMethod=http.RequestMethod.GET
  data?:T
}