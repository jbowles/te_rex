require_relative "../../lib/trex"
class ClassifierTest < MicroTest::Test

  def self.setup
    @@cls = Trex::Classifier::Bayes.new("Positive", "Negative")

    @@pos_corpus = Trex::Corpus::Body.new("corpora/movie_reviews/pos/cv*", Trex::Format::BasicFile)
    @@pos_corpus.build

    #@pos_corpus.get_files
    #@@pos_train = @pos_corpus.partition_train
    #@@pos_test = @pos_corpus.partition_test

    @@neg_corpus = Trex::Corpus::Body.new("corpora/movie_reviews/neg/cv*", Trex::Format::BasicFile)
    @@neg_corpus.build

    #@neg_corpus.get_files
    #@@neg_train = @neg_corpus.partition_train
    #@@neg_test = @neg_corpus.partition_test


    #@@pos_train.each {|txt| @@cls.train("Positive", txt)}
    @@pos_corpus.training_set.each {|txt| @@cls.train("Positive", txt)}
    #@@neg_train.each {|txt| @@cls.train("Negative", txt)}
    @@neg_corpus.training_set.each {|txt| @@cls.train("Negative", txt)}
  end

  def self.postest
    pos_tmp =[]
    #@@pos_test.each do |example| 
    @@pos_corpus.testing_set.each do |example|
      pos_tmp << @@cls.classify(example)
    end

    pos_count = pos_tmp.select{|t| t == "Positive"}.count
    [pos_count, pos_count.to_f/pos_tmp.count.to_f]
  end

  def self.negtest
    neg_tmp = []
    #@@neg_test.each do |example| 
    @@neg_corpus.testing_set.each do |example|
      neg_tmp << @@cls.classify(example)
    end

    neg_count = neg_tmp.select{|t| t == "Negative"}.count
    [neg_count, neg_count.to_f/neg_tmp.count.to_f]
  end

  setup

  test "positive training set should contain at least 60% 'positive' labels" do
    pos_count, pos_ratio = ClassifierTest.postest
    puts "***** POS Trained on #{@@pos_corpus.training_set.count} instances, test on #{@@pos_corpus.testing_set.count}, number of Positive categories: #{@@cls.category_counts[:Positive]}"
    puts "***** Accuracy of Positive classifier: #{pos_ratio} with #{pos_count} positive labels"
    assert pos_ratio > 0.60
  end

  test "negative training set should contain at least 60% 'negative' labels" do
    neg_count, neg_ratio = ClassifierTest.negtest
    puts "***** NEG Trained on #{@@neg_corpus.training_set.count} instances, test on #{@@neg_corpus.testing_set.count} instances, number of Negative categories: #{@@cls.category_counts[:Negative]}"
    puts "***** Accuracy of Negative classifier: #{neg_ratio} with #{neg_count} negative labels"
    assert neg_ratio > 0.60
  end

  test "Training categories should NOT be undertrained" do
    res = @@cls.training_description
    puts "\nUndertraining data for LARGE DATA SET (Movie Reviews): #{res}"
    final_result = res.select {|ut| ut.first == true}

    assert final_result.empty?
  end

end
