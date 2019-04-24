from keras.datasets import imdb
import dask_ml.model_selection as dcv
import numpy as np
from sklearn.feature_extraction.text import CountVectorizer
from sklearn.preprocessing import MaxAbsScaler
from sklearn.ensemble import GradientBoostingClassifier
from sklearn.pipeline import Pipeline

# for parallelization
from dask.distributed import Client
client = Client(processes=False,
                threads_per_worker=1,
                n_workers=4,
                memory_limit='2GB')
client

# get data
(x_train, y_train), (x_test, y_test) = imdb.load_data(path="imdb.npz",
                                                      num_words=None,
                                                      skip_top=0,
                                                      maxlen=None,
                                                      seed=113,
                                                      start_char=1,
                                                      oov_char=2,
                                                      index_from=3)
print("data loaded")
print("number of training examples " + str(len(x_train)))

# How many times to tune in a real application
# we would tune many more times than 2
n_iter = 2
# set hyper param ranges
max_depths = np.linspace(1, 32, 32)
min_samples_splits = np.linspace(0.1, 1.0, 10)
min_samples_leafs = np.linspace(0.1, 0.5, 10)
lr = np.linspace(0.005, 0.2, 30)
n_estimators = np.random.randint(low=150, high=400, size=30)

tuned_parameters = {
    'gbc__learning_rate': lr,
    'gbc__n_estimators': n_estimators,
    'gbc__max_depth': max_depths,
    'gbc__min_samples_split': min_samples_splits,
    'gbc__min_samples_leaf': min_samples_leafs,
}

# create model
gbc = Pipeline([
    ('vect', CountVectorizer(analyzer=lambda x: x)),
    ('scale', MaxAbsScaler()),
    ('gbc', GradientBoostingClassifier(verbose=1, random_state=7))
])

print("Tuning Model")

# Cross validation
clf = dcv.RandomizedSearchCV(gbc,
                             tuned_parameters,
                             cv=5,
                             n_iter=n_iter,
                             refit=True,
                             scoring='accuracy',
                             cache_cv=True,
                             scheduler=client)

clf.fit(x_train, y_train)

# Print results

for param, score in zip(clf.cv_results_['params'],
                        clf.cv_results_['mean_test_score']):
    print(param, score)

print("the best model is" + str(clf.best_params_))

score = clf.best_estimator_.score(x_test, y_test)

print("On the test data it got an accuracy score of " + str(score))
