require 'model/cms_name'
require 'model/cms_version'

class BaseCMS
  def initialize(name)
    @name = name
    @cms = CmsName.find_by(name: @name)
    if @cms.nil?
      @cms = CmsName.new(name: @name)
      @cms.save
    end
  end

  def getCurrentVersion()
    return '0' if @cms.cms_versions.size == 0
    @cms.cms_versions.last
  end

  def versionExist?(version)
    version = @cms.cms_versions.find_by(version: version)
    unless version.nil?
      if File.exist? version.filename
        return true
      end
    end
    false
  end

  def setCurrentVersion(new_version, filename)
    @cms.cms_versions.new(version: new_version, filename: filename).save
  end

  def getNewVersion()

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