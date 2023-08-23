Compound Filters
================

Very often you will want to filter the records based on more than a single filter expression. To do this Polymatheia provides three compound filters:

* :code:`('not', filter_expression)`: Lets the record pass if the :code:`filter_expression` is not :code:`True`.
* :code:`('or', filter_expression_1, ..., filter_expression_n)`: Lets the record pass if one or more of the :code:`filter_expression_1` to :code:`filter_expression_n` is :code:`True`.
* :code:`('and', filter_expression_1, ..., filter_expression_n)`: Lets the record pass only if all :code:`filter_expression_1` to :code:`filter_expression_n` are :code:`True`.

Negation
--------

For most of the basic filters, the :code:`'not'` filter is not needed, as they come with their own negation equivalents. The exception is the :code:`'contains'` filter. For example if we want to find all records that are not in German, we would run the following code in a new cell:

.. sourcecode:: python

    fltr = ('not', ('contains', ['dcLanguage'], 'de'))
    not_german = RecordsFilter(reader, fltr)
    count = 0
    for record in not_german:
        count = count + 1
    print(count)

If you run the cell, you will see that there are 414 records that do not have a "dcLanguage" of "de".

OR filtering
------------

When we looked at filtering with the basic :code:`'contain'` filter, we noted that filtering by :code:`'de'` does not produce all German language records. This is because some are annotated with the three-letter language code :code:`'ger'`. Because the :code:`'contains'` filter only supports a single value, we need to use multiple :code:`'contains'` filters and then combine them using the :code:`'or'` filter. Add a new code cell with the following code:

.. sourcecode:: python

    fltr = ('or', ('contains', ['dcLanguage'], 'de'), ('contains', ['dcLanguage'], 'ger'))
    full_german = RecordsFilter(reader, fltr)
    count = 0
    for record in full_german:
        count = count + 1
    print(count)

You will see that the filtered data now contains 698 records. If you go back to the basic :code:`'contains'` filter code and try it with the two values, you will see that :code:`'de'` produces 595 records and :code:`'ger'` 103, which in sum is exactly the 698 records produced here. This might not always be the case, as it is possible that a record in your data matches more than one of the nested filter expressions, in which case the combined total will be less than the individual counts.

AND filtering
-------------

Similar to the scenario with the :code:`'or'` filter, you sometimes want to require that multiple filter expressions are :code:`True` on a record. For example, we might want to get all German language images. Create a new cell and add the following code:

.. sourcecode:: python

    fltr = ('and', ('contains', ['dcLanguage'], 'de'), ('eq', ['type'], 'IMAGE'))
    german_images = RecordsFilter(reader, fltr)
    count = 0
    for record in german_images:
        count = count + 1
    print(count)

As you can see when you run the cell, combining filter expressions can quickly reduce a large data-set to something small and more manageable.

Nesting all the way down
------------------------

Obviously in the last code sample we did not include all German language images, as we were missing the records with the "dcLanguage" "ger". To include all of them, we can create complex filter expressions that combine multiple operators. Create a new cell and add the following code:

.. sourcecode:: python

    fltr = ('and',
                ('or',
                    ('contains', ['dcLanguage'], 'de'),
                    ('contains', ['dcLanguage'], 'ger')),
                ('eq', ['type'], 'IMAGE'))
    full_german_images = RecordsFilter(reader, fltr)
    count = 0
    for record in full_german_images:
        count = count + 1
    print(count)

As you can see when you run the cell, this only includes a single extra image, but that image might be very important, so good to have found that too.

When we write more complex filters, such as this one, it is generally a good idea to use indentation to indicate how the filter expressions are nested. Compare the following line of code, which does **exactly** the same:

.. sourcecode:: python

    fltr = ('and', ('or', ('contains', ['dcLanguage'], 'de'), ('contains', ['dcLanguage'], 'ger')), ('eq', ['type'], 'IMAGE'))

The difference in readability is clear and applies to all other code as well. Remember to also add notes to your notebooks to document what you have done.

.. important::

   Experience from software development shows that code you wrote yourself, but haven't looked at for at least two weeks is as readable and understandable as code that somebody else wrote. Thus it is imperative to cleanly structure your code and provide comments as well, so that you can remember what you were thinking.
