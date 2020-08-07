Loading data via OAI-PMH
========================

.. toctree::
   :hidden:

   formats
   records
   sets

`OAI-PMH`_ is a generic protocol for harvesting large amounts of metadata from an archive. Due to the generic nature, the OAI-PMH protocol provides only very limited facilities for filtering data on the server side. The standard pattern is thus to download all the data from the server and then to filter locally (which is what we are going to do here).

.. _`OAI-PMH`: https://www.openarchives.org/pmh/

The OAI-PMH protocol provides a number of functions for accessing aspects of the archive, but for our purposes we will only look at the following:

* Formats: What metadata formats are provided by the archive;
* Records: Loading the actual metadata records;
* Sets: What sets of records are available for filtering the metadata records.

For the tutorial we will use the OAI-PMH endpoint of the `DigiZeitschriften`_, which has its OAI-PMH endpoint at http://www.digizeitschriften.de/oai2/. If you click on the OAI-PMH endpoint link, you will see a human-readable version of the OAI-PMH responses and you can explore the data a bit through that interface as well, which is useful when you are starting out with a new archive.

.. _`DigiZeitschriften`: http://www.digizeitschriften.de/startseite/
