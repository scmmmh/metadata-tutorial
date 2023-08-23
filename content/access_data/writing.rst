Storing data locally
====================

Fetching data remotely is a comparatively slow process, so in practice it is better to fetch the data once and store it locally.

To do that we first need to import the :code:`JSONWriter` class into the first cell of the notebook and re-run the cell:

.. sourcecode:: python

    from polymatheia.data.writer import JSONWriter

The :code:`JSONWriter` requires a unique identifier for each record, which it then uses to structure how the data is stored locally. Since we are dealing with OAI-PMH data at the moment, this information is best found in the header. Add and run the following code in a new cell:

.. sourcecode:: python

    reader = OAIRecordReader('http://www.digizeitschriften.de/oai2/', max_records=10, metadata_prefix='mets', set_spec='EU')
    for record in reader:
        print(record.header)

The code will print out 10 headers in a row. You can see in the output that each record's header has an "identifier" entry, which contains the unique identifier for that record. This is something we need, so update the code so that it looks as follows:

.. sourcecode:: python

    reader = OAIRecordReader('http://www.digizeitschriften.de/oai2/', max_records=10, metadata_prefix='mets', set_spec='EU')
    for record in reader:
        print(record.header.identifier._text)

Re-run the cell and you will see 10 identifiers printed out. Now that we know where to get the unique identifier for a record, add a cell with the following code:

.. sourcecode:: python

    reader = OAIRecordReader('http://www.digizeitschriften.de/oai2/', max_records=10, metadata_prefix='mets', set_spec='EU')
    writer = JSONWriter('digiz_eu', 'header.identifier._text')
    writer.write(reader)

Lets have a look at that new elements in the code:

* Line #2 creates a new :code:`JSONWriter` in the :code:`writer` variable, which takes two parameters. The first is the name of the directory into which to store the data. The second is the dotted path used to access the identifier value.
* Line #3 instructs the :code:`writer` to write all the records returned by the :code:`reader`.

If you run the cell, this will take a few seconds and if everything worked, it will produce no visible output. You can, however, see that it is working by the "[*]" indicator on the left side of the cell. The :code:`JSONWriter` saves each record as a JSON (JavaScript Object Notation) file on the local filesystem and on the next page of the tutorial we will look at loading this data gain.

Let us now fetch a slightly larger dataset that we can then work with. Update the cell, increasing the ``max_records`` to 1000 and re-run the cell:

.. sourcecode:: python

    reader = OAIRecordReader('http://www.digizeitschriften.de/oai2/', max_records=1000, metadata_prefix='mets', set_spec='EU')
    writer = JSONWriter('digiz_eu', 'header.identifier._text')
    writer.write(reader)

This will take a while, so this is probably a good time to take a short break.

.. note::

   The code here writes OAI-PMH records to the local disk. However, the :code:`JSONWriter` does not actually care about the type of records it writes and will work just as well with data read from any of the other data-sources that Polymatheia provides.
