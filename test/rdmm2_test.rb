# coding: utf-8
require 'test/unit'
require File.dirname(__FILE__) + '/../lib/rdmm2'

#
# テストを実行するには、ホームディレクトリに設定ファイルが必要です。
#
# $ cat ~/.rdmm2_test
# {:api_id => 'your api id', :affiliate_id => 'your affiliate id'}
#
class Rdmm2Test < Test::Unit::TestCase

  def setup
    test_info = eval(File.read(File.expand_path('~/.rdmm2_test')))
    @client = RDMM2::ItemListOperation.new(test_info[:api_id], test_info[:affiliate_id])
  end

  def teardown
    # Do nothing
  end

  def test_test
    result = @client.site('DMM.co.jp').keyword("エロ").run
    assert_equal "1", result.first_position
    result.items.item.each do |item|
      assert_not_nil item.title
    end
  end

end
