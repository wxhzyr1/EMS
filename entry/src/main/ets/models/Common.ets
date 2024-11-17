
export interface ImagesList {
  /** 图片url */
  url: string;
}

export class ImagesListModel implements ImagesList {
  url: string = ''

  constructor(model: ImagesList) {
    this.url = model.url
  }
}
