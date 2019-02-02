require_relative 'cyclic_hue_assigner/version'

require 'prime'

# cyclic_hue_assigner のための名前空間。
module CyclicHueAssigner

  attr_accessor :primary # 優先 key

  # error 処理。
  class Error < StandardError; end
  # Your code goes here...

  # 色相を適切に割り当てる。
  class CyclicHueAssigner

    # 初期化。
    def initialize(primary: nil)
      # items を受け付けている間は false。
      # 1度でも hue を出力すると true。
      @frozen = false

      @items = []
      @hue_values = {}
      @primary = primary
    end

    # item 追加。
    # @param x [String] 文字列の追加
    # @param x [Array] 配列による追加
    def add(x)
      if (x.class == String) then
        @items << x unless @items.include?(x)
      elsif (x.class == Array) then
        x.each do |y|
          @items << y unless @items.include?(y)
        end
      else
        raise 'String 又は Array でないと受け付けません。'
      end
    end

    # item 個数。
    # @return [Integer] 個数
    def size
      @items.count
    end

    # 凍結の確認。
    # @return [Boolean] 凍結の有無
    def frozen?
      @frozen
    end

    # 優先 key の確認。
    # @return [Boolean] 優先 key 該当の有無
    def primary?(key:)
      (@primary == key)
    end

    # hue の取り出し。
    # @param x [String] 要素
    # @return [Integer] hue
    def hue(x)
      unless @frozen then
        assign
        @frozen = true
      end

      (x == @primary) ? 'white' : @hue_values[x]
    end

    # hue の決定。
    def assign
      unless @primary.nil?
        @items -= [@primary]
      end

      if (@items.count == 0) then
        #
      elsif (@items.count == 1) then
        @hue_values[@items[0]] = 0
      elsif (@items.count == 2) then
        @hue_values[@items[0]] = 0
        @hue_values[@items[1]] = 180
      elsif (@items.count == 3) then
        @hue_values[@items[0]] = 0
        @hue_values[@items[1]] = 120
        @hue_values[@items[2]] = 240
      elsif (@items.count == 4) then
        @hue_values[@items[0]] = 0
        @hue_values[@items[1]] = 180
        @hue_values[@items[2]] = 90
        @hue_values[@items[3]] = 270
      elsif (@items.count > 4) then
        cycle = @items.count
        until (cycle.prime?)
          cycle += 1
        end
        interval = (cycle * 0.4).round
        @items.each_with_index{|item, index|
          @hue_values[item] = (interval * index * 360 / cycle) % 360
        }
      else
        raise '要素の個数が足りません'
      end
    end
  end
end
