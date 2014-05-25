require 'erb'
require 'ostruct'

module Gemstrap
  class Template < OpenStruct
    def self.render(template_path, hash)
      Template.new(hash).render(template_path)
    end

    def render(template_path)
      template = ERB.new(IO.read(template_path))
      template.result(binding)
    end
  end
end
