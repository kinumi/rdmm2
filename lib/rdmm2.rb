# coding: utf-8

require 'rubygems'
require 'bundler/setup'
Bundler.require

require File.dirname(__FILE__) + '/rdmm2/response'
require File.dirname(__FILE__) + '/rdmm2/version'

module RDMM2
  API_URI     = 'http://affiliate-api.dmm.com/?'
  API_VERSION = '2.00'

  class ItemListOperation

    OPERATION = 'ItemList'

    def initialize(account_id, affiliate_id)
      @parameters = {
          :account_id => account_id,
          :affiliate_id => affiliate_id,
          :version => API_VERSION,
          :operation => OPERATION,
      }
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
