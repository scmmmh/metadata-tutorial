:layout: tutorial-iframe
:iframe-src: http://localhost:8888/notebooks/FilterTransform.ipynb

Filtering & Transformation
==========================

Whether you fetch the data from an OAI-PMH server, a specific API like Europeana, or have the data available locally, the next step in working with the data is to filter out those records that are of no interest and transform the relevant records into the required format for analysis and visualisation.

Let's get started by adding a new cell to the new notebook on the right and running the following code:

.. sourcecode:: python

    from polymatheia.data.reader import LocalReader
    from polymatheia.filter import RecordsFilter
    from polymatheia.transform import RecordsTransform

Then add and run another cell to read in the data we will use for the filtering and transformation:

.. sourcecode:: python

    reader = LocalReader('europeana_test')

While the tutorial will first look at filtering and then at transforming, in practice it is more common that these two steps are performed alternatingly and repeatedly in order to produce the final data-set for analysis.

.. toctree::
   :hidden:

   filter/index
