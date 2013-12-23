module VhdlConnector::Helper
  RootPath = File.expand_path('../../..', __FILE__)
  TemplatePath = File.expand_path('./templates', RootPath)

  def template_path(path)
    File.expand_path(path, TemplatePath)
  end

  def options_of_args(args)
    args.reduce(Hash.new) { |options, arg| (arg.is_a? Hash) ? options.merge(arg) : options }
  end

  def args_without_options(args)
    args.select { |arg| not (arg.is_a? Hash) }
  end
end

class Hash
  def symbolize_keys
    Hash[self.map { |k, v| [k.to_sym, v]}]
  end
end
