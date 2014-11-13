#require_relative "../lib/te_rex"
class CorpusTest < MicroTest::Test
  class MockErrorClassifier
  end

  @@error_corpus= TeRex::Corpus::Body.new(glob: '../test_modules/*.csv', format_klass: TeRex::Format::ErrorFile, category_klass: MockErrorClassifier)
  @@error_corpus.build

  test "Corpus has correct data before building" do
    corpus= TeRex::Corpus::Body.new(glob: 'test_modules/*.csv', format_klass: TeRex::Format::ErrorFile, category_klass: MockErrorClassifier)
    assert corpus.format_klass.name == "TeRex::Format::ErrorFile"
    assert corpus.category_klass.name == "CorpusTest::MockErrorClassifier"
  end

  test "data from csv files looks good" do
    @@error_corpus.set == false
  end

end
