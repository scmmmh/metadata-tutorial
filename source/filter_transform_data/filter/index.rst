Filtering
=========

We shall start by looking at the filtering possibilities provided by Polymatheia. Add a new cell with the following code and then run it:

.. sourcecode:: python
    :linenos:

    fltr = ('true',)
    filtered = RecordsFilter(reader, fltr)
    count = 0
    for record in filtered:
        count = count + 1
    print(count)

You will see that the output is 1009, the same number of records that the original Europeana query returned and that we stored locally.

The only real difference to the code we have written in previous parts of the tutorial are lines \#2 and \#3. In line \#2 we define a new variable :code:`fltr` (the mis-spelling is on purpose, as :code:`filter` is a reserved keyword in Python) and assign it the value :code:`('true',)`. The round brackets of the filter expression define what in Python is known as a "tuple". A tuple is an ordered list of values that *cannot* be changed after being created. In polymatheia all filters are defined as tuples and the simplest filter is the :code:`'true'` filter we use here, which simply lets any record pass.

Next in line \#3 we create a new :code:`RecordsFilter`, passing it the :code:`reader` and a :code:`fltr`, storing the new :code:`RecordsFilter` in the :code:`filtered` variable. The :code:`RecordsFilter` instance can then be used like any other reader, thus we can use it in the :code:`for` loop. The :code:`record` variable in the :code:`for` loop is then assigned each of the records provided by the :code:`reader` that match the filter expression. Because we use the :code:`'true'` filter, all 1009 records are passed through by the filter.

The :code:`'true'` filter is not that interesting and is mainly used internally by Polymatheia for performance reasons. Polymatheia implements two groups of filters that we will now look at: :doc:`basic_filters` and :doc:`compound_filters`.

.. toctree::
   :hidden:

   basic_filters
   compound_filters
