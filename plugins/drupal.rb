class Drupal < GithubCms
  def initialize
    super self.class.to_s
    @current_version = self.getCurrentVersion
  end

  def getNewVersion
    @owner = "drupal"
    @repo = "drupal"
    super @owner, @repo, @current_version
  end
end