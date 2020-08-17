Categorical Data
================

In addition to numeric data it is also possible to visualise categorical data. This works similarly to the :math:`\chi^2` test in that we will visualise counts of values, rather than the actual values. Run the following code in a new cell:

.. sourcecode:: python

    seaborn.countplot(x='type', data=df)

We can also visualise a categorical numeric value, such as the "completeness", by running the following code in a new cell:

.. sourcecode::

    seaborn.countplot(x='completeness', data=df)

Finally, it is also possible to further split each categorical value via another categorical column. Run the following code in a new cell:

.. sourcecode::

    seaborn.countplot(x='completeness', hue='type', data=df)
