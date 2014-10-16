# RDMM2

A Ruby client for DMM Web Service API 2.0

DMM Web Service 2.0の、Ruby用クライアントライブラリです。


## Installation

Add this line to your application's Gemfile:

    gem 'rdmm2'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rdmm2


## Usage

使い方については、specも参照してください。

```ruby
## クライアントの生成

client = RDMM2::ItemListOperation.new(YOUR_API_ID, YOUR_AFFILIATE_ID)


## 検索の実行

# 設定できる検索条件はDMM Web Service 2.0仕様を参照してください。
# 下記は検索条件設定の一例です。

# 'DMM.com'を条件無しで検索 (デフォルト)
result = client.request.execute 
# 'DMM.co.jp'をキーワード検索
result = client.request.site('DMM.co.jp').keyword('AV').execute
# 取得件数、オフセット、ソート条件の指定
result = client.request.hits(100).offset(:date).execute

# リクエストの構築と実行を分割することも可能
request = client.request
request = request.keyword('AKB')
request = request.hits(100)
request = request.offset(101)
result  = request.execute

## 検索結果の取得

# 取得できる情報はDMM Web Service 2.0仕様を参照してください。
# 下記は一例です。

result.result_count                 # => 取得件数(String)
result.total_count                  # => 全体件数(String)
result.first_position               # => 検索開始位置(String)

result.items.item[0].service_name   # => サービス名(String)
result.items.item[0].floor_name     # => フロア名(String)
result.items.item[0].category_name  # => カテゴリ名(String)
result.items.item[0].content_id     # => 商品ID(String)
result.items.item[0].product_id     # => 品番(String)
result.items.item[0].title          # => タイトル(String)
result.items.item[0].URL            # => 商品ページURL(String)
result.items.item[0].affiliateURL   # => アフィリエイトリンクURL(String)
result.items.item[0].URLsp          # => スマホ向け商品ページURL（あればString, なければnil）
result.items.item[0].affiliateURLsp # => スマホ向けアフィリエイトリンクURL（あればString, なければnil）
result.items.item[0].imageURL.list  # => 画像URLリスト用(String)
result.items.item[0].imageURL.small # => 画像URL末端用(小)(String)
result.items.item[0].imageURL.large # => 画像URL末端用(大)(String)
```


## Contributing

1. Fork it ( https://github.com/kinumi/rdmm2/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
