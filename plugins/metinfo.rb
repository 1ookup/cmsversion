class Metinfo < BaseCMS
  def initialize
    super self.class.to_s
    @current_version = self.getCurrentVersion
  end

  def getNewVersion
    resp = HTTP.get("https://www.metinfo.cn/download/")
    if resp.to_s =~ /btn-download.*?href="\.\.\/upload\/file\/(.*?)\.zip".*?当前版本：(.*?)<\/li>.*?<a href="(.*?)">历史版本</um
      new_version_url = "https://www.metinfo.cn/upload/file/" + $1 + ".zip"
      new_version = $2
      old_version_url = $3
    end
    unless versionExist? new_version
      downloadFile(new_version_url, new_version)
    end

    resp = HTTP.follow.get old_version_url
    resp.to_s.scan /www\.metinfo\.cn\/upload\/file\/update\/MetInfo(\d)((\.\d)*).zip/ do |item|
      item.pop
      version = item.join
      url = "http://www.metinfo.cn/upload/file/update/MetInfo#{version}.zip"
      next if versionExist? version
      downloadFile(url, version)
    end
  end
end