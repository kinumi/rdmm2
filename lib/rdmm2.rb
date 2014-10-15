# coding: utf-8

require 'uri'
require 'open-uri'

require 'rubygems'
require 'nokogiri'

require File.dirname(__FILE__) + '/rdmm2/request'
require File.dirname(__FILE__) + '/rdmm2/version'

module RDMM2
  API_URI     = 'http://affiliate-api.dmm.com/?'
  API_VERSION = '2.00'

  class ItemListOperation

    OPERATION       = 'ItemList'

    SITE_DMM_COM    = 'DMM.com'
    SITE_DMM_CO_JP  = 'DMM.co.jp'
    DEFAULT_SITE    = SITE_DMM_COM

    def initialize(account_id, affiliate_id)
      @account_id = account_id
      @affiliate_id = affiliate_id
    end

    def request(options = {})
      params = {
          :account_id => @account_id,
          :affiliate_id => @affiliate_id,
          :version => API_VERSION,
          :operation => OPERATION,
          :site => DEFAULT_SITE,
      }
      params.merge(options)
      RDMM2::Request.new(params)
    end

  end
end
