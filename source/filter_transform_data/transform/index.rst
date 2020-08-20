:layout: tutorial-iframe
:iframe-src: /notebooks/Transform.ipynb

Transformation
==============

For the analysis and visualisation the data generally needs to be in a tabular format. As we have seen, this is generally not the case for the source metadata. However, even if the source metadata is already tabular, it is often useful to transform it into a simpler form for the analysis.

We will first look at some :doc:`basic_transforms` and then :doc:`complex_transforms`.

Let's get started by adding a new cell to the new notebook on the right and running the following code:

.. sourcecode:: python

    from polymatheia.data.reader import LocalReader
    from polymatheia.filter import RecordsFilter
    from polymatheia.transform import RecordsTransform

Then add and run another cell to read in the data we will use for the filtering and transformation:

.. sourcecode:: python

    reader = LocalReader('europeana_test')

.. toctree::
   :hidden:

   basic_transforms
   complex_transforms
