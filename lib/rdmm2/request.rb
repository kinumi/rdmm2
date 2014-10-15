# coding: utf-8

require File.dirname(__FILE__) + '/response'

module RDMM2
  class Request

    def initialize(parameters)
      @parameters = parameters.dup
    end

    def execute
      @parameters[:timestamp] = Time.now.strftime('%Y/%m/%d %H:%M:%S')
      return RDMM2::Response.new(Nokogiri::XML(open("#{API_URI}#{URI.encode_www_form(@parameters)}"))).response.result
    end

    def method_missing(method_name, *args)
      @parameters[method_name] = args.first.to_s.encode('EUC-JP')
      return self
    end

  end
end
