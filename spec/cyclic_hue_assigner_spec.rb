RSpec.describe CyclicHueAssigner do
  it "has a version number" do
    expect(CyclicHueAssigner::VERSION).not_to be nil
  end

  describe '5個の要素を追加' do
    a1 = CyclicHueAssigner::CyclicHueAssigner.new
    a1.add('ja')
    a1.add('en')
    a1.add('ru')
    a1.add('ko')
    a1.add('zh')

    it "class から生成できる" do
      expect(a1.class).to eq(CyclicHueAssigner::CyclicHueAssigner)
    end

    it "5個の要素がある" do
      expect(a1.size).to eq(5)
    end

    it "出力していなければ frozen ではない" do
      expect(a1.frozen?).to eq(false)
    end

    it "1個目 (ja) は 0 である" do
      expect(a1.hue('ja')).to eq(0)
    end

    it "2個目 (en) は 144 である" do
      expect(a1.hue('en')).to eq(144)
    end

    it "3個目 (ru) は 288 である" do
      expect(a1.hue('ru')).to eq(288)
    end

    it "4個目 (ko) は 72 である" do
      expect(a1.hue('ko')).to eq(72)
    end

    it "5個目 (zh) は 216 である" do
      expect(a1.hue('zh')).to eq(216)
    end
  end
end
