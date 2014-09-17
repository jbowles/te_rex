require_relative "../../lib/trex"
class ClassifierTest < MicroTest::Test

  def self.setup
    @@cls = Trex::Classifier::Bayes.new("Positive", "Negative")

    @pos_corpus = Trex::Corpus::Body.new("corpora/movie_reviews/pos/cv**", Trex::Corpus::MovieReviewFile)
    @pos_corpus.files
    @@pos_train = @pos_corpus.train_sentences
    @@pos_test = @pos_corpus.test_sentences

    @neg_corpus = Trex::Corpus::Body.new("corpora/movie_reviews/neg/cv**", Trex::Corpus::MovieReviewFile)
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
    puts "***** POS Trained on #{@@pos_train.count} instances, test on #{@@pos_test.count}, number of Positive categories: #{@@cls.category_counts[:Positive]}"
    puts "***** Accuracy of Positive classifier: #{pos_ratio}"
    assert pos_ratio > 0.60
  end

  test "negative training set should contain at least 60% 'negative' labels" do
    neg_ratio = ClassifierTest.negtest
    puts "***** NEG Trained on #{@@neg_train.count} instances, test on #{@@neg_test.count} instances, number of Negative categories: #{@@cls.category_counts[:Negative]}"
    puts "***** Accuracy of Negative classifier: #{neg_ratio}"
    assert neg_ratio > 0.60
  end


  test "Training categories should NOT be undertrained" do
    res = @@cls.training_description
    puts "\nUndertraining data for LARGE DATA SET (Movie Reviews): #{res}"
    final_result = res.select {|ut| ut.first == true}

    assert final_result.empty?
  end

end
