export interface userLogin{
  account:string,
  password:string
}
export class userLoginInfo implements userLogin{
  account: string=""
  password: string=""

  constructor(user:userLogin) {
    this.account=user.account
    this.password=user.password
  }
}