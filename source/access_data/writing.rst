Storing data locally
====================

Fetching data remotely is a comparatively slow process, so in practice it is better to fetch the data once and store it locally.

First, we need to import the :code:`LocalWriter` class into the first cell of the notebook and re-run the cell:

.. sourcecode:: python

    from polymatheia.data.writer import LocalWriter

Next, add a new cell to the end of the notebook and add the following content and run the cell:

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
    writer = LocalWriter('digiz_eu', 'header.identifier._text')
    writer.write(reader)

Lets have a look at that new elements in the code:

* Line #2 creates a new :code:`LocalWriter` in the :code:`writer` variable, which takes two parameters. The first is the name of the directory into which to store the data. The second is the dotted path used to access the identifier value.
* Line #3 instructs the :code:`writer` to write all the records returned by the :code:`reader`.

If you run the cell, this will take a few seconds and if everything worked, it will produce no visible output. You can, however, see that it is working by the "[*]" indicator to the left of the cell.

Let us now fetch a slightly larger dataset that we can then work with. Update the cell, increasing the ``max_records`` to 1000 and re-run the cell:

.. sourcecode:: python

    reader = OAIRecordReader('http://www.digizeitschriften.de/oai2/', max_records=1000, metadata_prefix='mets', set_spec='EU')
    writer = LocalWriter('digiz_eu', 'header.identifier._text')
    writer.write(reader)

This will take a while.
