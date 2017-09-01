class OpenSNS < BaseCMS
  def initialize
    super self.class.to_s
    @current_version = self.getCurrentVersion
  end

  def getNewVersion
    resp = HTTP.get("http://os.opensns.cn/product/index/historyweb.html")
    resp.to_s.scan /row download-table.*?one">(\d\.\d\.\d).*?<a href="\/link\/(\w*?)".*?完整安装包</m do |item|
      url = "http://os.opensns.cn/link/" + item[1]
      next if versionExist? item[0]
      downloadFile(url, item[0])
    end
  end
end