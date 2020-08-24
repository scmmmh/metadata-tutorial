Loading data from disk
======================

After storing data, we obviously need to load it again, in order to make use of it. Polymatheia provides two methods for reading data from disk. The :code:`LocalReader` is used to load JSON data, and the :code:`CSVReader` for loading data from CSV files.

Loading JSON data
-----------------

As stated earleir, the :code:`LocalWriter` stores records as JSON files. In order to load these back into the notebook, add the following into the cell at the top and re-run the cell:

.. sourcecode:: python

    from polymatheia.data.reader import LocalReader

Then add and run a cell at the end of the notebook with the following code:

.. sourcecode:: python

    reader = LocalReader('digiz_eu')
    count = 0
    for record in reader:
        count = count + 1
    print(count)

Unlike the other readers, the :code:`LocalReader` only takes a single parameter, which is the directory the :code:`LocalWriter` stored the data in. The rest of the code example shows another pattern that is often useful. We first define a :code:`counter` and set it to 0 (line #2). Then we iterate over all records and increment the value of the :code:`counter` each time (line #3-4). Then, after the :code:`for` loop completes, we print out the value of :code:`counter`.

The result should be that "1000" is output, showing that the :code:`LocalWriter` did retrieve and store 1000 records.

.. note::

   While in this tutorial we used the :code:`LocalReader` to load data saved with the :code:`LocalWriter`, the :code:`LocalReader` will load any kind of JSON data. The only constraint is that each JSON file **must** contain exactly one record.

Loading CSV data
----------------

Polymatheia also provides functionality for loading data from CSV files. We won't be using it in this tutorial, but if you need to load data from a CSV file, then use the following code:

.. sourcecode:: python

    from polymatheia.data.reader import CSVReader
    reader = CSVReader('filename.csv')

The :code:`CSVReader` object can then be used wherever you have used any other readers.
