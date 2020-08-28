Mann-Whitney-U
==============

The Mann-Whitney-U test is used to compare two independent samples of ordinal values (ordinal meaning that for any two values you can determine which one is greater than the other or equal to each other). We will use this to investigate whether the language of the record influences the length of title. First, let us quickly remind ourselves of which languages are still in our dataset by running the following code in a new cell:

.. sourcecode:: python

    Counter(df['lang'])

You will see that there are four languages: German (680 records), Hungarian (19 records), Polish (12 records), and French (10 records). To apply the test, we need to split the data for each language out of the DataFrame. Add a new cell with the following code:

.. sourcecode:: python

    de_title_lengths = df[df['lang'] == 'de']['title_tokens']
    hu_title_lengths = df[df['lang'] == 'hu']['title_tokens']
    pl_title_lengths = df[df['lang'] == 'pl']['title_tokens']
    fr_title_lengths = df[df['lang'] == 'fr']['title_tokens']

You can see that the four expressions are all the same, except for the varying language codes. They all create Series of "title_tokens", but each filtered to include only one of the four languages. We will now look at the first expression in detail:

* First the following part of the expression creates a filter mask that defines which records we want to have included in our sub-set:

  .. sourcecode:: python

      df['lang'] == 'de'

  (You can actually run this in a separate cell and you will see that you get a long list of :code:`True` and :code:`False` values).

* Next, we apply the filter mask to our DataFrame:

  .. sourcecode:: python

      df[df['lang'] == 'de']

  This will create a new DataFrame, which only includes those rows where the filter mask is :code:`True`, but still includes all columns.

* Finally, we select only the "title_tokens" column from our filtered DataFrame:

  .. sourcecode:: python

      df[df['lang] == 'de']['title_tokens']

Now that we have our Series of "title_tokens" values for the four languages, we can run the Mann-Whitney-U test. Run the following code in a new cell:

.. sourcecode:: python

    stats.mannwhitneyu(de_title_lengths, hu_title_lengths, alternative='two-sided')

The :code:`stats.mannwhitneyu` function takes three parameters. The first two are the samples that we wish to compare. Here we are comparing the lengths of the German and Hungarian titles. The third specifies the *alternative hypothesis* that we want the test to consider. This can be either :code:`'two-sided'` meaning that we believe the two samples to have different values, but we don't know whether larger or smaller, :code:`'less'` meaning that we believe the values from the first sample to be smaller than the values from the second, or :code:`'greater'` meaning that we believe the values from the first sample to be greater than the values from the second. Initially it is often good to use :code:`'two-sided'`, which makes less assumptions about the data.

The result of running the test should look like this:

.. sourcecode::

    MannwhitneyuResult(statistic=4545.0, pvalue=0.026990873270466658)

The :code:`statistic` is a mathematical value that the test calculates based on the input samples. The :code:`pvalue` indicates how likely it is that the *null-hypothesis* is correct and that there is no significant difference between the two samples. Here we have a value of 0.027, indicating that the difference is statistically significant at :math:`p < 0.05`. So it is likely that there is some kind of effect here that we can investigate further.

The next step is to look at the median values for the two samples. Run the following code in a new cell:

.. sourcecode:: python

    print(de_title_lengths.median(), hu_title_lengths.median())

You will see that the German titles have a median length of 8 and the Hungarian ones a median length of 13. We can thus adapt our *alternative hypothesis* to indicate that we believe the German titles to be shorter. Run the following code in a new cell:

.. sourcecode:: python

    stats.mannwhitneyu(de_title_lengths, hu_title_lengths, alternative='less')

which produces the following result:

.. sourcecode::

    MannwhitneyuResult(statistic=4545.0, pvalue=0.013495436635233329)

The *p-value* here is lower than in the previous test. This indicates that the it is likely that the German titles are shorter than the Hungarian ones.

We would now need to apply the pair-wise test to all combinations of two languages. For example to see a pair with very significant differences run the following:

.. sourcecode:: python

    stats.mannwhitneyu(de_title_lengths, fr_title_lengths, alternative='less')

This will result in:

.. sourcecode::

    MannwhitneyuResult(statistic=1177.5, pvalue=0.00018441519206957308)

Indicating a highly significant difference between the two (again German being shorter than French).

When reporting results it is important to always report the sample size, median values of the two samples, the test :code:`statistic` and the :code:`pvalue`. In this example, while we are seeing statistically significant differences, the number of observations in the non-German samples are much smaller than for German, which has to be taken into consideration when reporting and discussing the results.
