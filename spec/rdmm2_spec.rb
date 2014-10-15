require File.dirname(__FILE__) + '/../lib/rdmm2'
require 'rspec'

describe 'ItemListOperation' do
  before :all do
    @test_info = eval(File.read(File.expand_path('~/.rdmm2_test')))
    @client = RDMM2::ItemListOperation.new(@test_info[:api_id], @test_info[:affiliate_id])
  end

  describe '検索条件無し' do
    let(:result) do
      @client.request.execute
    end

    it '主要なレスポンスフィールドを持っている' do
      # 取得件数
      expect(result.result_count).to be_a(String)
      # 全体件数
      expect(result.total_count).to be_a(String)
      # 検索開始位置
      expect(result.first_position).to be_a(String)
      # 商品情報
      expect(result.items).to be_a(RDMM2::Response)
      # |- 商品
      expect(result.items.item).to be_a(RDMM2::Response)
      begin
        # |- サービス名
        expect(result.items.item[0].service_name).to be_a(String)
        # |- フロア名
        expect(result.items.item[0].floor_name).to be_a(String)
        # |- カテゴリ名
        expect(result.items.item[0].category_name).to be_a(String)
        # |- 商品ID
        expect(result.items.item[0].content_id).to be_a(String)
        # |- 品番
        expect(result.items.item[0].product_id).to be_a(String)
        # |- タイトル
        expect(result.items.item[0].title).to be_a(String)
        # |- 商品ページURL
        expect(result.items.item[0].URL).to be_a(String)
        # |- アフィリエイトリンクURL
        expect(result.items.item[0].affiliateURL).to be_a(String)
        # |- スマホ向け商品ページURL（ある場合）
        # expect(result.items.item[0].URLsp).to be_a(String)
        # |- スマホ向けアフィリエイトリンクURL（ある場合）
        # expect(result.items.item[0].affiliateURLsp).to be_a(String)
        # |- 画像URL
        expect(result.items.item[0].imageURL).to be_a(RDMM2::Response)
        begin
          # |- リスト用
          expect(result.items.item[0].imageURL.list).to be_a(String)
          # |- 末端用（小）
          expect(result.items.item[0].imageURL.small).to be_a(String)
          # |- 末端用（大）
          expect(result.items.item[0].imageURL.large).to be_a(String)
        end
      end
    end

    it '(おそらく) 20個の結果を持つ' do
      expect(result.result_count).to eq('20')
      expect(result.items.item.size).to eq(20)
    end
  end

  describe 'DMM.com 通販(スマホ向けページが有る)' do
    let(:result) do
      @client.request.service(:mono).floor(:dvd).execute
    end

    it 'スマホ向けページが取得できる' do
      # |- 商品
      expect(result.items.item).to be_a(RDMM2::Response)
      begin
        # |- スマホ向け商品ページURL（ある場合）
        expect(result.items.item[0].URLsp).to be_a(String)
        # |- スマホ向けアフィリエイトリンクURL（ある場合）
        expect(result.items.item[0].affiliateURLsp).to be_a(String)
      end
    end
  end

  describe 'DMM.com PCソフト(スマホ向けページが無い)' do
    let(:result) do
      @client.request.service(:pcsoft).floor(:pcgame).execute
    end

    it 'スマホ向けページが無い(nil)' do
      # |- 商品
      expect(result.items.item).to be_a(RDMM2::Response)
      begin
        # |- スマホ向け商品ページURL（ある場合）
        expect(result.items.item[0].URLsp).to eq(nil)
        # |- スマホ向けアフィリエイトリンクURL（ある場合）
        expect(result.items.item[0].affiliateURLsp).to eq(nil)
      end
    end
  end

  describe '取得件数指定あり' do
    let(:result) do
      @client.request.site('DMM.com').keyword('AKB').hits(100).execute
    end

    it '検索結果が100個となる' do
      expect(result.result_count).to eq('100')
      expect(result.items.item.size).to eq(100)
    end
  end

  describe '検索開始位置指定あり' do
    let(:result) do
      @client.request.site('DMM.com').keyword('AKB').offset(100).execute
    end

    it '検索開始位置が100となる' do
      expect(result.first_position).to eq('100')
    end
  end

  describe 'ソート条件あり' do
    let(:result_not_ordered) do
      @client.request.site('DMM.com').keyword('AKB').execute
    end
    let(:result_ordered) do
      @client.request.site('DMM.com').keyword('AKB').sort(:date).execute
    end

    it '並び順が変更されている' do
      expect(result_ordered.items.item[0].title).not_to eq(result_not_ordered.items.item[0].title)
    end
  end

  describe 'eachで回せる' do
    let(:result) do
      @client.request.execute
    end

    it 'eachで回せる' do
      result.items.item.each do |item|
        expect(item.title).to be_a(String)
      end
    end
  end
end
