module VhdlConnector::Helper
  RootPath = File.expand_path('../../..', __FILE__)
  TemplatePath = File.expand_path('./templates', RootPath)

  def template_path(path)
    File.expand_path(path, TemplatePath)
  end

  def options_of_args(args)
    args.reduce(Hash.new) { |arg, options| args.is_a? Hash ? options.merge(arg) : options }
  end

  def args_without_options(args)
    args.select { |arg| not args.is_a? Hash }
  end
end
