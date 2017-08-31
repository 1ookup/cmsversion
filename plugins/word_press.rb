class WordPress < GithubCms
  def initialize
    super self.class.to_s
    @current_version = self.getCurrentVersion
  end

  def getNewVersion
    @owner = "WordPress"
    @repo = "WordPress"
    super @owner, @repo, @current_version
  end
end