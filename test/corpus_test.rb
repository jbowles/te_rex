#require_relative "../lib/te_rex"
class CorpusTest < MicroTest::Test
  class MockErrorClassifier
  end

    #@pos_corpus = TeRex::Corpus::Body.new("corpora/movie_reviews/pos/cv**", TeRex::Format::BasicFile)
  @@error_corpus = TeRex::Corpus::Body.new(glob: "test/test_modules/*.csv", format_klass: TeRex::Format::ErrorFile, category_klass: MockErrorClassifier)
  @@error_corpus.build

  test "Corpus has correct data before building" do
    assert @@error_corpus.format_klass.name == "TeRex::Format::ErrorFile"
    assert @@error_corpus.category_klass.name == "CorpusTest::MockErrorClassifier"
  end

  test "ratio of training to testing is within 70%" do
    ratio = @@error_corpus.testing.count.to_f / @@error_corpus.training.count.to_f
    assert (60...80).map{|i| i}.include?((ratio * 100).to_i)
  end

  test "sentence counts are correct" do
    assert @@error_corpus.set.count == 3
    @@error_corpus.training.count == 10
    @@error_corpus.testing.count == 7
  end

end
