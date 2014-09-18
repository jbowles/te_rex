# Testing
This branch is for testing large data sets. Merge master into it and run tests containing corpora and other large data sets.
```sh
***** POS Trained on 18775 instances, test on 6275, number of Positive categories: 18775
***** Accuracy of Positive classifier: 1.0
  6.9339 positive training set should contain at least 60% 'positive' labels


***** NEG Trained on 26285 instances, test on 8785 instances, number of Negative categories: 26285
***** Accuracy of Negative classifier: 1.0
  6.8382 negative training set should contain at least 60% 'negative' labels
```


## Run tests
Using `micro_test` for testing. larger data set testing in `test/large_data_set_test`

```sh
  #run tests
  mt
```
