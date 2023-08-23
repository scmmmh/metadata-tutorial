Available Metadata Formats
==========================

The first step when accessing an OAI-PMH archive is to determine which formats you can request the metadata in, when you later fetch the actual metadata records. The first step to doing this is to import the :code:`OAIMetadataFormatReader` class, provided by the Polymatheia library, into our notebook. To do this, add the following code into the first cell of the notebook:

.. sourcecode:: python

    from polymatheia.data.reader import OAIMetadataFormatReader

Then run the cell. If you do not get an error, then this has worked perfectly. Otherwise check for typos and then re-run the cell.

.. note::

   It is generally good practice to put all your imports together at the top of your notebook. That means that later in the tutorial, when we import additional classes, simply add the import statements into this same cell and re-run the cell.

Now that we have our reader class for the metadata we can use this to find out which metadata formats the archive supports. Into a new cell in the notebook add the following:

.. sourcecode:: python
    :linenos:

    reader = OAIMetadataFormatReader('http://www.digizeitschriften.de/oai2/')
    for format in reader:
        print(format)

Now run the cell and the output should look something like this:

.. sourcecode:: json

    {
      "schema": "http://www.openarchives.org/OAI/2.0/dc.xsd",
      "metadataPrefix": "oai_dc",
      "metadataNamespace": "http://purl.org/dc/elements/1.1/"
    }
    {
      "schema": "http://www.loc.gov/mets/mets.xsd http://www.loc.gov/standards/mods/v3/mods-3-2.xsd",
      "metadataPrefix": "mets",
      "metadataNamespace": "http://www.loc.gov/METS/ http://www.loc.gov/mods/v3"
    }

Before we look at the output in a bit more detail, let us have a quick look at the code we use:

* In line #1 we first create a new :code:`OAIMetadataFormatReader` object with a single parameter, the base URL of the OAI-PMH endpoint. This new object is then assigned to the :code:`reader` variable. At this point no data has been fetched from the OAI-PMH server. That will only happen in line \#2.
* In line #2 we use a "for" loop to loop over the format objects provided by the :code:`reader` object we created in the previous line. It is at this point that the :code:`OAIMetadataFormatReader` fetches the list of available metadata formats from the OAI-PMH server and makes them available to the :code:`for` loop.

  The "for" loop is one of the core concepts of programming. It allows us to apply a series of instructions to a list of things. In this case the things are the format objects provided by the :code:`reader`. In each iteration of the loop one format object is made available via the :code:`format` variable. Then the so-called body of the loop, which are those instructions that follow the :code:`for` line and are indented by at least 4 spaces, is run. In our case there is only one instruction in the body of the loop, which is line #3. This line will be run once for each :code:`format` object provided by the :code:`reader`.
* In line #3 we simply print out the content of the :code:`format` variable. In each iteration of the loop the :code:`format` will have different content, but the same code will be applied, here printing out the :code:`format` object.

If you look at the output, you can see that two metadata formats are provided by the OAI-PMH server. This means that the body of the for loop was run two times, each time printing out the content of one format object. If you look at the output of the individual format objects, you can see that they have three properties:

* *schema*: The schema definition for the metadata format;
* *metadataPrefix*: The prefix used to identify this metadata format, which we will later on use to fetch records in a specific format;
* *metadataNamespace*: The XML namespace the schema uses.

In practice we will only use the *metadataPrefix*, so let us try to output only this in the for loop. Add the following code into a new cell:

.. sourcecode:: python

    for format in reader:
        print(format.metadataPrefix)

If you run the cell, the output will look as follows:

.. sourcecode:: text

    oai_dc
    mets

There are two differences between the two cells. First, in the second cell we don't create the :code:`reader` object. Instead, we will simply re-use the :code:`reader` object created in the previous cell. This illustrates an important aspect of the notebook, namely that while there are individual cells, all cells in a notebook share the same execution environment, thus anything defined in a cell that has been run is available to all other cells.

The second difference is line #2. In the second example we use "dot-notation" to access a specific field within the format object (:code:`format.metadataPrefix`). You can try replacing the "metadataPrefix" with one of the other two properties in the format object ("schema" or "metadataNamespace"). Then re-run the cell to see what the output looks like.

Now that we know which metadata formats are available we can move on to loading some actual metadata records.
