require 'erb'

module VhdlConnector
  class View
    def initialize(template_path, presenter)
      @template_path = template_path
      @presenter = presenter
    end

    def run
      erb = ERB.new(File.read(@template_path), nil, '-')
      @result = @presenter.instance_eval { erb.result(binding) }
    end
  end
end
