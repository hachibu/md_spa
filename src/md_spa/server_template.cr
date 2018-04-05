require "ecr"

class MdSpa::ServerTemplate
  def initialize(@html_file : String, @mode : Symbol)
    @html_file = File.expand_path(@html_file)
    @html = File.read(@html_file)
  end

  ECR.def_to_s("src/md_spa/server_template.ecr")
end
