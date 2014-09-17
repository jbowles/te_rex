require_relative "../../lib/trex"
class ClassifierTest < MicroTest::Test

  def self.setup
    @@cls = Trex::Classifier::Bayes.new("Positive", "Negative")

    @pos_corpus = Trex::Corpus::Body.new('corpora/movie/positive/cv**', Trex::Corpus::MovieReviewFile)
    @pos_corpus.files
    @@pos_train = @pos_corpus.train_sentences
    @@pos_test = @pos_corpus.test_sentences

    @neg_corpus = Trex::Corpus::Body.new('corpora/movie/negative/cv**', Trex::Corpus::MovieReviewFile)
    @neg_corpus.files
    @@neg_train = @neg_corpus.train_sentences
    @@neg_test = @neg_corpus.test_sentences


    @@pos_train.each {|txt| @@cls.train("Positive", txt)}
    @@neg_train.each {|txt| @@cls.train("Negative", txt)}
  end

  def self.postest
    tmp =[]
    @@pos_test.each do |example| 
      tmp << @@cls.classify(example)
    end

    pos_count = tmp.select{|t| t == "Positive"}.count
    pos_count.to_f/tmp.count.to_f
  end

  def self.negtest
    tmp = []
    @@neg_test.each do |example| 
      tmp << @@cls.classify(example)
    end

    neg_count = tmp.select{|t| t == "Negative"}.count
    neg_count.to_f/tmp.count.to_f
  end

  setup

  test "positive training set should contain at least 60% 'positive' labels" do
    pos_ratio = ClassifierTest.postest
    assert pos_ratio > 0.60
  end

  test "negative training set should contain at least 60% 'negative' labels" do
    neg_ratio = ClassifierTest.negtest
    assert neg_ratio > 0.60
  end

end
