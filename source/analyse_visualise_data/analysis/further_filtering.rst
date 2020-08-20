:layout: tutorial-iframe
:iframe-src: /notebooks/ComparativeStatistics.ipynb

Further Filtering
=================

We have now identified a number of additional filters and transforms we wish to apply to our data-set:

* Remove all rows with multiple languages or no language
* Merge language codes
* Remove all titles with 30 or more tokens
* Remove languages that have less than 10 entries

Start by adding a new cell importing everything we will need:

.. sourcecode:: python

    from collections import Counter
    from pandas import DataFrame
    from polymatheia.data.reader import LocalReader
    from polymatheia.data.writer import PandasDFWriter
    from polymatheia.filter import RecordsFilter
    from polymatheia.transform import RecordsTransform
    from scipy import stats

Then add and run a cell with the following code:

.. sourcecode:: python

    reader = LocalReader('europeana_test')
    mapping = ('parallel', ('copy', 'id', 'id'),
                           ('copy', 'lang', 'dcLanguage[0]'),
                           ('custom', 'title_tokens', lambda record: len(record.title[0].split())),
                           ('copy', 'completeness', 'europeanaCompleteness'),
                           ('copy', 'type', 'type'))
    transformed = RecordsTransform(reader, mapping)
    fltr = ('and', ('exists', ['lang']),
                   ('neq', ['lang'], 'mul'),
                   ('lt', ['title_tokens'], 30))
    filtered = RecordsFilter(transformed, fltr)
    df = PandasDFWriter().write(filtered)

As you can see, we have added a :code:`RecordsFilter` that requires that there is a language, the languages is not multiple languages, and the number of title tokens is less than 30. Let us see what effect this has by adding and running another cell with the following code:

.. sourcecode:: python

    df

You will see that this filters the data-set down to 767 rows (75%). The next step is to merge the languages. To do that, we need a full list of languages used. Add and run a new cell with the following code:

.. sourcecode:: python

    Counter(df['lang']).most_common()

We will use the two-letter codes, meaning we need to find mappings for "ger", "und", "deu", "fre", "Deutsch", "pol", "cat", "swe", "lat", "hun", "zxx", and "ita". Of these "zxx" actually means that the record has no linguistic content, so we don't need to map, but we do need to filter that. Similarly "und" means "undefined", which we should also get rid of. Update the code in the read/transform/filter cell to look like this:

.. sourcecode:: python
    :linenos:

    def map_language(record):
        if record.lang == 'ger' or record.lang == 'deu' or record.lang == 'Deutsch':
            return 'de'
        elif record.lang == 'hun':
            return 'hu'
        elif record.lang == 'swe':
            return 'sv'
        elif record.lang == 'pol':
            return 'pl'
        elif record.lang == 'fre':
            return 'fr'
        elif record.lang == 'cat':
            return 'ca'
        elif record.lang == 'lat':
            return 'la'
        elif record.lang == 'ita':
            return 'it'
        return record.lang

    reader = LocalReader('europeana_test')
    mapping = ('parallel', ('copy', 'id', 'id'),
                           ('sequence', ('copy', 'lang', 'dcLanguage[0]'),
                                        ('custom', 'lang', map_language)),
                           ('custom', 'title_tokens', lambda record: len(record.title[0].split())),
                           ('copy', 'completeness', 'europeanaCompleteness'),
                           ('copy', 'type', 'type'))
    transformed = RecordsTransform(reader, mapping)
    fltr = ('and', ('exists', ['lang']),
                   ('neq', ['lang'], 'mul'),
                   ('neq', ['lang'], 'zxx'),
                   ('neq', ['lang'], 'und'),
                   ('lt', ['title_tokens'], 30))
    filtered = RecordsFilter(transformed, fltr)
    df = PandasDFWriter().write(filtered)

The big change is the new function we have defined in lines \#1-\#18. When we looked at custom transforms, we used lambda functions, but it is also possible to use a full function in a custom transform. Just as with the lambda function, the full function takes a single parameter, which is the record to transform. Inside our function we have a list of :code:`if` statements. An :code:`if` statement is a control structur that tells the computer that if a given condition is :code:`True`, then run the code that is in the :code:`if` body (in Python indicated through indentation). If the condition is not :code:`True`, skip the body. The :code:`elif` is an extension of that which you should read as "if the previous :code:`if` condition was not :code:`True` and this :code:`if` statement's condition is :code:`True`, then run the nested block". If the language does not match any of the specific language codes we check, then we simply return the existing language value.

We use our :code:`map_language` function in the :code:`mapping`, running the language :code:`'copy'` and then our :code:`'custom'` transform in sequence. Additionally in the :code:`fltr` we have filtered out the "zxx" and "und" language codes.

Run the cell and then run the :code:`df` cell as well. You will see that now our dataframe has 754 rows, indicating that the unneeded language codes have been filtered out. However, we will still have some language codes that occur only very infrequently.

To filter those out, first run the :code:`Counter(df['lang']).most_common()` cell again and look at the output. The languages "sv", "la", "da", "ca", "nl", "es", "it", "en", and "et" all have less than 10 occurences, so should be filtered. Update the load/transform/filter cell to look like this:

.. sourcecode:: python

    def map_language(record):
        if record.lang == 'ger' or record.lang == 'deu' or record.lang == 'Deutsch':
            return 'de'
        elif record.lang == 'hun':
            return 'hu'
        elif record.lang == 'swe':
            return 'sv'
        elif record.lang == 'pol':
            return 'pl'
        elif record.lang == 'fre':
            return 'fr'
        elif record.lang == 'cat':
            return 'ca'
        elif record.lang == 'lat':
            return 'la'
        elif record.lang == 'ita':
            return 'it'
        return record.lang

    reader = LocalReader('europeana_test')
    mapping = ('parallel', ('copy', 'id', 'id'),
                           ('sequence', ('copy', 'lang', 'dcLanguage[0]'), ('custom', 'lang', map_language)),
                           ('custom', 'title_tokens', lambda record: len(record.title[0].split())),
                           ('copy', 'completeness', 'europeanaCompleteness'),
                           ('copy', 'type', 'type'))
    transformed = RecordsTransform(reader, mapping)
    fltr = ('and', ('exists', ['lang']),
                   ('neq', ['lang'], 'mul'),
                   ('neq', ['lang'], 'zxx'),
                   ('neq', ['lang'], 'und'),
                   ('neq', ['lang'], 'la'),
                   ('neq', ['lang'], 'sv'),
                   ('neq', ['lang'], 'es'),
                   ('neq', ['lang'], 'da'),
                   ('neq', ['lang'], 'nl'),
                   ('neq', ['lang'], 'ca'),
                   ('neq', ['lang'], 'it'),
                   ('neq', ['lang'], 'et'),
                   ('neq', ['lang'], 'en'),
                   ('lt', ['title_tokens'], 30))
    filtered = RecordsFilter(transformed, fltr)
    df = PandasDFWriter().write(filtered)

If you run the cell again and also re-run the :code:`df` cell, then you will see that we have now reduced the size of our analysis data-set to 721 rows. We can also see the effect this filtering has had on the number of tokens in the tiles by adding a new cell with the following code:

.. sourcecode:: python

    df['title_tokens'].describe()

As you can see in the output, the mean length has reduced by 2 and the median by 1.

.. important::

   One of the advantages of Jupyter Notebooks is that you can trace the steps of your analysis. However, you should also make notes of the reasoning for the various changes, as it is important to be able to trace your analysis, otherwise it is hard to put any trust in the results (as the filtering will affect and may bias results).
