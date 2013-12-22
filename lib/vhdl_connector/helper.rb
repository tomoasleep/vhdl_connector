module VhdlConnector::Helper
  RootPath = File.expand_path('../../..', __FILE__)
  TemplatePath = File.expand_path('./templates', RootPath)

  def template_path(path)
    File.expand_path(path, TemplatePath)
  end
end
