export interface userLogin{
  username:string,
  password:string
}
export class userLoginInfo implements userLogin{
  username: string=""
  password: string=""

  constructor(user:userLogin) {
    this.username=user.username
    this.password=user.password
  }
}