Loading data from disk
======================

We earlier looked at :doc:`storing data locally <writing>`, now we will quickly look at how to get that data back in. Add the following into the cell at the top

.. sourcecode:: python

    from polymatheia.data.reader import LocalReader

Then add a cell at the end of the notebook with the following code:

.. sourcecode:: python

    reader = LocalReader('digiz_eu')
    count = 0
    for record in reader:
        count = count + 1
    print(count)

Unlike the other readers, the :code:`LocalReader` only takes a single parameter, which is the directory the :code:`LocalWriter` stored the data in. The rest of the code example shows another pattern that is often useful. We first define a :code:`counter` and set it to 0 (line #2). Then we iterate over all records and increment the value of the :code:`counter` each time (line #3-4). Then, after :code:`for` loop completes, we print out the value of :code:`counter`.

The result should be 1000 is output, showing that the :code:`LocalWriter` did retrieve and store 1000 records.

Now that we know how to fetch data, store it locally, and then read that back in, we can move on to filtering to reduce the data we want to work with.
