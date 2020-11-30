:layout: tutorial-iframe
:iframe-src: /notebooks/DescriptiveStatistics.ipynb

Descriptive Statistics
======================

When analysing a data-set the first step should always be to generate some basic statistics that describe the data-set you are working with. The first step towards doing that is to make the data available to Pandas for the basic statistics. Create a new cell with the following content:

.. sourcecode:: python

    from collections import Counter
    from polymatheia.data.reader import JSONReader
    from polymatheia.data.writer import PandasDFWriter
    from polymatheia.filter import RecordsFilter
    from polymatheia.transform import RecordsTransform

    reader = JSONReader('europeana_test')

Two additions here that we have not used previously are the :code:`Counter` and the :code:`PandasDFWriter`. The :code:`PandasDFWriter` is used first to transform the source metadata records into the Pandas :code:`DataFrame` structure needed for all further analysis. The :code:`Counter` will be used later to determine frequencies.

First add the following code into a new cell and run it:

.. sourcecode:: python

    mapping = ('parallel', ('copy', 'id', 'id'),
                           ('copy', 'lang', 'dcLanguage[0]'),
                           ('custom', 'title_tokens', lambda record: len(record.title[0].split())),
                           ('copy', 'completeness', 'europeanaCompleteness'),
                           ('copy', 'type', 'type'))
    transformed = RecordsTransform(reader, mapping)
    df = PandasDFWriter().write(transformed)

The addition to what we have covered previously is line \#6, where we create a new :code:`PandasDFWriter` and then use its :code:`write` method to convert the :code:`transformed` records into a Pandas :code:`DataFrame`, which we store in the :code:`df` variable.

This will not have output anything, unless there is an error somewhere. Add and run the following code in a new cell:

.. sourcecode:: python

    df

The result you will see is an overview over the :code:`DataFrame` we created. You can see that each field created in the transformed data has been converted into a column. If you look at the bottom of the output, you will see that it is 1009 rows and 5 columns, which is exactly the same as the input data.

Categorical data
----------------

We will first generate some summary information about categorical data, looking at the "lang" column. Add a new cell with the following content:

.. sourcecode:: python

    Counter(df['lang']).most_common()

When you run it, you will see that it prints out a long list of all "lang" values, together with how often they occur. Looking at the data, there are some interesting things you can see immediately. First of all, while we have previously treated "de" and "ger" as German-language codes, there is also "deu" and "Deutsch". Second, the second-most-frequent category is "mul", which stands for "multiple", indicating that there are multiple languages, but not specifying which ones they are.

Looking at the data, we can see a few more filters that we could apply. We probably want to filter those where the language is set to multiple and those that have no language at all. We would probably also want to combine the various language values that all refer to the same language. Finally we would like to filter out those languages that have less than 10 occurrences. However, before we modify the data any more, it is worth looking at the other columns as well, before we make any decisions.

Numeric data
------------

Our dataframe has two numeric columns. The number of "title_tokens" and the "completeness"" score. Let us look at the "completeness" first. To generate summary statistics for a numeric column, add a new cell with the following code:

.. sourcecode:: python

    df['completeness'].describe()

The first row shows the number of values (which might be less than the number of rows, if some rows are empty).

The second and third row show the mean and standard deviation (std). The mean is what is commonly known as the average. It is calculated by summing up all values and dividing by the number of values. The standard deviation is a measure that indicates how much the actual values differ from the mean value. A higher standard deviation indicates that many values are further away from the mean, while a lower value indicates that the values cluster closely to the mean. The standard deviation is essentially the average of the difference between the mean and each value.

The next five rows are the most common "percentiles". The percentiles are calculated by sorting the values lowest to highest. The "min" value (also the 0th percentile) is the first value in the ordered list. Likewise the "max" is the last value in the ordered list. The other three are the value at specific points in that ordered list. The 25th percentile is the value :math:`\frac{1}{4}` of the way through the list, the 50th percentile half way, and the 75th percentile :math:`\frac{3}{4}` of the way. The 50th percentile is also called the "median" and the difference between the 75th and 25th percentiles is the so-called "inter-quartile range". Median and inter-quartile range have the same role as mean and standard deviation.

The question is do we use mean/standard deviation or median/inter-quartile range to interpret the data. The fundamental difference between the two is that the mean is much more sensitive to variation in the data. For example if the values we were looking at were :code:`[1, 1, 1, 1, 1, 100]`, then the mean is 17.5 (std 36.9), while the median is 1 (iqr 0). If you know that you don't have any extreme outliers and fractional values in the result make sense, then the mean is the way to go. If neither of these are true, then the median is better.

For an example with outliers, we can look at the lengths of the titles. Add and run a new cell with the following code:

.. sourcecode:: python

    df['title_tokens'].describe()

If you look at the output, you will see that the mean is about 2 words longer than the median. You will also see that the maximum title length is 249. Clearly our mean is being skewed and we need to filter out some outliers. The question is where to we draw the line? One way is to look at the 95th percentile. Update the code cell to look like this:

.. sourcecode:: python

    df['title_tokens'].describe(percentiles=[0.25, 0.5, 0.75, 0.95])

You can now see that 95% of all titles have 29 or less words. If we filter out anything with more than 29 words, we will loose 5% of the data, but at the same time any analysis is less influenced by the outliers.
