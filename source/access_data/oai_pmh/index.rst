:iframe-src: /../notebooks/Loading.ipynb

Loading data via OAI-PMH
========================

The first metadata format we will look at loading is `OAI-PMH`_. It is a generic protocol designed for harvesting large amounts of metadata from an archive and was initially intended primarily as an archive-to-archive metadata exchange protocol. As a result of this focus, the OAI-PMH protocol provides only very limited facilities for filtering data on the server side. Instead the standard pattern is to download complete data-sets from the server and then filter and transform locally (which is what we are going to do here).

.. _`OAI-PMH`: https://www.openarchives.org/pmh/

The OAI-PMH protocol provides a number of functions for accessing aspects of the archive, but for our purposes we will only look at the following:

* Formats: What metadata formats are provided by the archive;
* Records: Loading the actual metadata records;
* Sets: What sets of records are available for filtering the metadata records.

For the tutorial we will use the OAI-PMH endpoint of the `DigiZeitschriften`_ project, which has its OAI-PMH endpoint at http://www.digizeitschriften.de/oai2/. If you click on the OAI-PMH endpoint link, you will see a human-readable version of the OAI-PMH responses and you can explore the data a bit through that interface as well, which is useful when you are starting out with a new archive.

.. _`DigiZeitschriften`: http://www.digizeitschriften.de/startseite/

.. toctree::
   :hidden:

   formats
   records
   sets
