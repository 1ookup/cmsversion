class Joomla < GithubCms
  def initialize
    super self.class.to_s
    @current_version = self.getCurrentVersion
  end

  def getNewVersion
    @owner = "joomla"
    @repo = "joomla-cms"
    super @owner, @repo, @current_version
  end
end
