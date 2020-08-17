Chi-square
==========

The second test we will look at is the :math:`\chi^2` (chi-square) test. This test is used when we want to compare two or more samples of categorical data. As it is impossible to order categorical data, we cannot apply Mann-Whitney-U. Instead we will count how often the different values appear and place those values into what is known as a contingency table. We will use this to test whether the language of the record influences the type of record. To do that, we first need to count how often each type of record appears in each language. Run the following code in a new cell:

.. sourcecode:: python
    :linenos:

    for lang in ['de', 'hu', 'pl', 'fr']:
        print(lang)
        print(Counter(df[df['lang'] == lang]['type']).most_common())

You are already familiar with most of the concepts here. In line \#1 we loop through a list with the language codes. In each iteration the :code:`lang` variable will hold on language code, which we print out in line \#2. In line \#3 we first create a filter mask comparing the "lang" column to our :code:`lang` variable, then we apply that filter to the DataFrame, select the "type" column, pass that into a :code:`Counter` and print out the :code:`most_common()` values. The result will look like this:

.. sourcecode::

    de
    [('TEXT', 663), ('IMAGE', 12), ('SOUND', 5)]
    hu
    [('TEXT', 19)]
    pl
    [('TEXT', 12)]
    fr
    [('TEXT', 10)]

Based on these we can now create a new DataFrame to hold our contingency table. Run the following code in a new cell:

.. sourcecode:: python

    df2 = DataFrame([{'text': 663, 'image': 12, 'sound': 5},
                     {'text': 19, 'image': 0, 'sound': 0},
                     {'text': 12, 'image': 0, 'sound': 0},
                     {'text': 10, 'image': 0, 'sound': 0}])

When creating a new :code:`DataFrame`, we pass a list to the :code:`DataFrame`. Each element in the list represents one row in the resulting :code:`DataFrame`. Inside each element, we specify a dictionary, mapping keys to frequencies. It is important to explicitly provide the :code:`0` values, as otherwise those would be seen as missing values by the :code:`DataFrame` and the :math:`\chi^2` test does not work with missing values. If you run the following code in a new cell, you will see our contingency table:

.. sourcecode:: python

    df2

This kind of table is known as a "contingency table", because it tests whether the column categories (here the record type) are contingent (meaning they depend on) with the row categories (the record language). To apply the :math:`\chi^2` test, run the following code in a new cell:

.. sourcecode:: python

    stats.chi2_contingency(df2)

The result will look something like this:

.. sourcecode::

    (1.049751420454546,
     0.983655785107175,
     6,
     array([[6.63966713e+02, 1.13176144e+01, 4.71567268e+00],
            [1.85520111e+01, 3.16227462e-01, 1.31761442e-01],
            [1.17170596e+01, 1.99722607e-01, 8.32177531e-02],
            [9.76421637e+00, 1.66435506e-01, 6.93481276e-02]]))

The first value is the :math:`\chi^2` statistic, the second value the *p-value*, the third the degrees of freedom, and the fourth a representation of the expected frequencies that the test used to determine whether there was any significant differences. A *p-value* of 0.98 indicates that there is no significant link between the type and language of the record.

To see how the :math:`\chi^2` behaves with different values, try changing and re-running the cell where we defined our new DataFrame. Then re-run the test. See how much you need to change the values to make the differences statistically significant.

The nice thing about the :math:`\chi^2` test is that you can feed in multiple values in both the rows and columns. However, the resulting *p-value* will only tell you whether there is any significant difference somewhere in the contingency table, not where it is. To determine that, you then need to create multiple contingency tables for each pair of two rows and run the :math:`\chi^2` test on each one. That will tell you where significant differences exist.
