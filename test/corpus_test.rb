#require_relative "../lib/te_rex"
class CorpusTest < MicroTest::Test
  class MockErrorClassifier
  end

  @@error_corpus = TeRex::Corpus::Body.new(glob: "test/test_modules/*.csv", format_klass: TeRex::Format::ErrorFile, category_klass: MockErrorClassifier)
  @@error_corpus.build

  test "Corpus has correct data before building" do
    assert @@error_corpus.format_klass.name == "TeRex::Format::ErrorFile"
    assert @@error_corpus.category_klass.name == "CorpusTest::MockErrorClassifier"
  end

  test "total count of sentences is correct" do
    assert @@error_corpus.total_sentences == 12
  end

  test "ratio of training to testing is within 70%" do
    ratio = @@error_corpus.testing.count.to_f / @@error_corpus.training.count.to_f
    assert (60...80).map{|i| i}.include?((ratio * 100).to_i)
  end

  test "sentence counts are correct" do
    assert @@error_corpus.set.count == 3
    assert @@error_corpus.training.count == 12
    assert @@error_corpus.testing.count == 8
  end

  @@sent_corpus = TeRex::Corpus::Body.new(glob: "test/test_modules/*.csv", partition: :sentence, format_klass: TeRex::Format::ErrorFile, category_klass: MockErrorClassifier)
  @@sent_corpus.build

  test "Corpus has correct data before building" do
    assert @@sent_corpus.format_klass.name == "TeRex::Format::ErrorFile"
    assert @@sent_corpus.category_klass.name == "CorpusTest::MockErrorClassifier"
  end

  test "total count of sentences is correct" do
    assert @@sent_corpus.total_sentences == 12
  end

  test "ratio of training to total is about 75%" do
    ratio = @@sent_corpus.training.count.to_f / @@sent_corpus.total_sentences
    assert (72...77).map{|i| i}.include?((ratio * 100).to_i)
  end

  test "ratio of training to total is about 25%" do
    ratio = @@sent_corpus.testing.count.to_f / @@sent_corpus.total_sentences
    assert (22...27).map{|i| i}.include?((ratio * 100).to_i)
  end

  test "sample size equals size of training set" do
    sample = @@sent_corpus.total_sentences.to_f * 0.75
    assert @@sent_corpus.sample_size == sample
  end

  test "sentence counts are correct" do
    assert @@sent_corpus.set.count == 3
    assert @@sent_corpus.training.count == 9
    assert @@sent_corpus.testing.count == 3
  end

end
