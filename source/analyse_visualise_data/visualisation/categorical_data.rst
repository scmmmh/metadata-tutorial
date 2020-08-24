Categorical Data
================

In addition to numeric data it is also possible to visualise categorical data. This works similarly to the :math:`\chi^2` test in that we will visualise counts of values, rather than the actual values. Run the following code in a new cell:

.. sourcecode:: python

    seaborn.countplot(x='type', data=df)

As you can see in the resulting plot, the type of record is primarily "TEXT", with a few "IMAGE" and "SOUND" records.

We can also visualise a categorical numeric value, such as the "completeness", by running the following code in a new cell:

.. sourcecode::

    seaborn.countplot(x='completeness', data=df)

As we have already seen in other plots, the most common "completeness" value is 8.

Finally, it is also possible to further split each categorical value via another categorical column. Run the following code in a new cell:

.. sourcecode::

    seaborn.countplot(x='completeness', hue='type', data=df)

While this visualisation is not that easy to read, we can see that the "IMAGE" records tend to have more values around 6 and 0. This also shows one of the weaknesses of any kind of visualisation. If your data is very skewed in a value that you want to visualise (as is the "type"), then differences in values can often be hard to see.
