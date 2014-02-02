require 'erb'

module VhdlConnector
  class View
    def initialize(template_path, presenter)
      @template_path = template_path
      @presenter = presenter
    end

    def run
      code = template
      @result = @presenter.instance_eval { code.result(binding) }
    end

    def template
      mk_template(File.read(@template_path))
    end

    def mk_template(text)
      ERB.new(text, nil, '-')
    end
  end
end
