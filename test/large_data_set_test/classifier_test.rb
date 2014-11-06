require_relative "../../lib/te_rex"
class ClassifierTest < MicroTest::Test

  def self.setup
    @@cls = TeRex::Classifier::Bayes.new(
      {:tag => "Positive", :msg => "Much Smiles"},
      {:tag => "Negative", :msg => "Such Negative"}
    )

    @pos_corpus = TeRex::Corpus::Body.new("corpora/movie_reviews/pos/cv**", TeRex::Format::BasicFile)
    @pos_corpus.get_files
    @@pos_train = @pos_corpus.partition_train
    @@pos_test = @pos_corpus.partition_test

    @neg_corpus = TeRex::Corpus::Body.new("corpora/movie_reviews/neg/cv**", TeRex::Format::BasicFile)
    @neg_corpus.get_files
    @@neg_train = @neg_corpus.partition_train
    @@neg_test = @neg_corpus.partition_test


    @@pos_train.each {|txt| @@cls.train("Positive", txt)}
    @@neg_train.each {|txt| @@cls.train("Negative", txt)}
  end

  def self.postest
    tmp =[]
    @@pos_test.each do |example| 
      tmp << @@cls.classify(example)
    end

    pos_count = tmp.select{|t| t[0] == "Positive"}.count
    pos_count.to_f/tmp.count.to_f
  end

  def self.negtest
    tmp = []
    @@neg_test.each do |example| 
      tmp << @@cls.classify(example)
    end

    neg_count = tmp.select{|t| t[0] == "Negative"}.count
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
