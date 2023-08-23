Loading data from disk
======================

After storing data, we obviously need to load it again, in order to make use of it. Polymatheia provides two methods for reading data from disk. The :code:`JSONReader` is used to load JSON data, and the :code:`CSVReader` for loading data from CSV files.

Loading JSON data
-----------------

As stated earlier, the :code:`JSONWriter` stores records as JSON files. In order to load these back into the notebook, add the following into the cell at the top and re-run the cell:

.. sourcecode:: python

    from polymatheia.data.reader import JSONReader

Then add and run a cell at the end of the notebook with the following code:

.. sourcecode:: python

    reader = JSONReader('digiz_eu')
    count = 0
    for record in reader:
        count = count + 1
    print(count)

Unlike the other readers, the :code:`JSONReader` only takes a single parameter, which is the directory the :code:`JSONWriter` stored the data in. The rest of the code example shows another pattern that is often useful. We first define a :code:`counter` and set it to 0 (line #2). Then we iterate over all records and increment the value of the :code:`counter` each time (line #3-4). Then, after the :code:`for` loop completes, we print out the value of :code:`counter`.

The result should be that "1000" is output, showing that the :code:`JSONWriter` did retrieve and store 1000 records.

.. note::

   While in this tutorial we used the :code:`JSONReader` to load data saved with the :code:`JSONWriter`, the :code:`JSONReader` will load any kind of JSON data. The only constraint is that each JSON file **must** contain exactly one record.

Loading CSV data
----------------

Polymatheia also provides functionality for loading data from CSV files. We won't be using it in this tutorial, but if you need to load data from a CSV file, then use the following code:

.. sourcecode:: python

    from polymatheia.data.reader import CSVReader
    reader = CSVReader('filename.csv')

The :code:`CSVReader` object can then be used wherever you have used any other readers.

Loading XML data
----------------

Polymatheia also provides functionality for loading data from XML files. As with the CSV access, we won't be using this in this tutorial, but if you do prefer XML over JSON, then you can replace any use of the :code:`JSONReader` with the :code:`XMLReader` and any use of the :code:`JSONWriter` with the :code:`XMLWriter`. As with the :code:`JSONReader`, the :code:`XMLReader` can load any XML data, as long as each XML file contains **exactly** one record.

.. note::

   While the JSON and XML reading and writing functionality is exchangeable, it is recommended that you use the JSON reading and writing functionality, as it is faster.
