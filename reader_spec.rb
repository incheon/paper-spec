require_relative 'reader'

describe Reader do
  before { @reader = Reader.new("./abstract.tex") }
  subject { @reader.content }

  describe 'check format' do
    it { is_expected.to     match(/[，．()]+/) }
    it { is_expected.not_to match(/[。、（）]+/) }
    it { is_expected.to     match(/\d+,\d+/) }
    it { is_expected.not_to match(/\.$/) }
    it { is_expected.to     match(/\d+\.\d+/) }
    it { is_expected.not_to match(/@pending/i) }
  end

  describe 'check expression' do
    describe "of (sectioning) element" do
      it { is_expected.to     include("セクショニング要素") }
      it { is_expected.not_to include("セクショニングタグ") }
      it { is_expected.to     match(/(article|aside|section|nav|html|body|script|style|noscript)要素/) }
      it { is_expected.not_to match(/(article|aside|section|nav|html|body|script|style|noscript)タグ/) }
    end

    describe "of main content" do
      it { is_expected.to     include("主要コンテンツ") }
      it { is_expected.not_to include("主要部分") }
    end

    describe "of threshold" do
      # it { is_expected.to     include("閾値") }
      it { is_expected.not_to include("しきい値") }
    end

    describe "of root node" do
      it { is_expected.to     include("ルートノード") }
      it { is_expected.not_to include("根ノード") }
    end

    describe "of cite tags" do
      it { is_expected.to match(/[\p{Han}\p{Hiragana}\p{Katakana}\w\d]\\cite{[\w\d]+}ら/) }
      it { is_expected.not_to  match(/^\\cite{[\w\d]+}ら/) }
      it { is_expected.not_to match(/\W\\cite{[\w\d]+}ら/) }
    end

    describe "of ref tags" do
      it { is_expected.not_to match(/[^図表]\\ref{[\w\d]+}/) }
    end

    describe "of learn and recognize" do
      it { is_expected.to include("学習") }
      it { is_expected.to include("認識") }
    end
  end

  describe 'check header content' do
    it { is_expected.to include("西山研究室") }
    it { is_expected.to include("HTML5のセクショニング要素を用いたWebページの主要コンテンツ抽出手法の提案") }
    it { is_expected.to include("7410009") }
    it { is_expected.to include("今泉") }
    it { is_expected.to include("智博") }
  end
end