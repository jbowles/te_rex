# Testing
This branch is for testing large data sets. Merge master into it and run tests containing corpora and other large data sets.
=======
# TeRex
[![te_rex API Documentation](https://www.omniref.com/ruby/gems/te_rex.png)](https://www.omniref.com/ruby/gems/te_rex)

A lot of power with a little reach.

A little reach with a big bite.

**If for some reason you have been using this, teh change from version `0.5` to `0.8` broke the initiallization of the classifier. See the git tags, tests, and examples.**

The Bayes classifier is written to solve some small domain specific problems. This means it is not a classififer to be used for general problems where domain context is either unknown, general, or requires large data sets. In other words, you shouldn't use this gem.

## Bayes
This Bayes classifier was written specifically to classify `cancellation policies` and `error messages` from Hotel reservation providers. This doesn't mean it can't be used for other things, but it **does mean it should NOT be used a general solution for text classification.**

The the small domain focus of this classifier can most be gleaned from the `BayesData` class. It cleans the text in way specific to the goals I had in mind.

## Tests
Just run `mt` [micro\_test](https://github.com/hopsoft/micro_test). For tests against some pre-built larger corpora, which I consider the full test suite, you'll want to switch to the `testing` branch... then run the tests just as you would here in master: `mt`.

## Usage
For usage see tests; though here is a snippet below. Also, if you don't know what Bayesian Classification is you should probably check it out (just google it): your classifier is only as good as your training data and training methods!

```ruby
cls = TeRex::Classifier::Bayes.new(
  {:tag => "Refund", :msg => "You'll get a refund"},
  {:tag => "Nonrefund", :msg => "You won't get a refund"}
)

["You will get a refund.","Full refund for you!","You will receive a full refund.","You may only get a partial refund."].each {|txt| cls.train("Refund", txt)}
["You will not get a refund.","There are no refunds.","Refunds not available.","You will not get a refund."].each {|txt| cls.train("Nonrefund", txt)}


cls.classify("We understand that you work hard for your money, but we will not give you a refund.")
```


## Examples
The corpus builder is mostly used to test the classification on a larger data sets. I need to verify the classifier actually works to some degree and so running it against some well known corpora and comparing resutls with other classifiers provides feedback on `te_rex`. 

### Corpus builder

```rb
pos_corpus = TeRex::Corpus::Body.new(glob: '/Users/jbowles/x/training_data/corpora/words/en*', format_klass: TeRex::Format::BasicFile)
pos_corpus.build

# Then look at what you've got:
pos_corpus.training.count #Array of sentences
pos_corpus.testing.count  #Array of sentences
pos_corpus.files.count    #Array of file paths
pos_corpus.sample_size    #total files multiplied by 0.75; used to split files for test/train (0.25 for test, rest for train)


#Or you could do all this
pos_corpus.get_files
pos_train = pos_corpus.partition_train
pos_test = pos_corpus.partition_test
```

## Stopwords
A class provided so you can append or delete from it if needed. I typically go for smaller stop lists than larger and this one is no exception. However, due the custom nature of this classifier the stop list also contains weekday and month names with usual abbreviations (i.e., nov, november, wed, monday,...).


## Corpora
Some notes on corpora to download for testing.

### Brown and Movie datasets
Downloadable from the [NLTK svn trunk index](http://nltk.googlecode.com/svn/trunk/nltk_data/index.xml).

Brown corpus is for part of speech tagging and is not organized for text classification.

Movie Review labelled as:
* pos (1000 text files) -- Positive
* neg (1000 text files) -- Negative


### 4UDS dataset
Downloadable from the [CMU 4 Universities Data Set](http://www.cs.cmu.edu/afs/cs.cmu.edu/project/theo-19/www/data/).

Labelled as:
* student (1641 html files)
* faculty (1124 html files)
* staff (137 html files)
* department (182 html files)
* course (930 html files)
* project (504 html files)
* other (3764 html files)

They suggest "Since each university's web pages have their own idiosyncrasies, we do not recommend training and testing on pages from the same university. We recommend training on three of the universities plus the misc collection, and testing on the pages from a fourth, held-out university. There is a simple [Perl script](http://www.cs.cmu.edu/afs/cs.cmu.edu/project/theo-20/www/data/make-x-val) for creating a directory structure, which should make it easier to do this four-fold cross validation. No guarantees."

I've organized the directory as `corpora/4uds/COLLEGE/LABEL`. so far only have `staff` and 'student` moved over.

### 20Newsgroups
Downloadable from the [20Newsgroups Homepage](http://qwone.com/~jason/20Newsgroups/)
