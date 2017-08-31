class GithubCms < BaseCMS
  def getNewVersion(owner, repo, current_version)
    tags_url = "https://api.github.com/repos/#{owner}/#{repo}/git/refs/tags"
    resp = HTTP.get(tags_url)
    resp = JSON.parse(resp.body)
    down = false
    resp.each do |item|
      #ap item
      version = item["ref"][10..-1]
      next if versionExist? version
      download_url = "https://api.github.com/repos/#{owner}/#{repo}/zipball/#{version}"
      puts "[#] Version: #{version}. Download #{download_url}"
      downloadFile(download_url, version)
      sleep 0.1
    end
  end

  def downloadFile(url, version)
    filename = Digest::MD5.hexdigest(version).upcase + ".zip"
    filepath = "files/" + self.class.to_s + "/"
    unless Dir.exist?(filepath)
      FileUtils.mkdir_p(filepath)
    end
    # resp = HTTP.follow.get(url)
    # File.open(filepath + filename, 'w') do |f|
    #   f.write(resp.body)
    # end
    `wget #{url} -O #{filepath + filename}`

    self.setCurrentVersion(version, filepath + filename)
  end
end