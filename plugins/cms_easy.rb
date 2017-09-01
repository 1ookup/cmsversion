class CmsEasy < BaseCMS
  def initialize
    super self.class.to_s
    @current_version = self.getCurrentVersion
  end

  def getNewVersion
    resp = HTTP.get("http://www.cmseasy.cn/old-download/")
    resp.to_s.scan /href="(http:\/\/ftp.cmseasy.cn\/.*?)" target="_blank">CmsEasy_(.*?)</ do |item|
      next if versionExist? item[1]
      downloadFile(item[0], item[1])
    end
  end
end