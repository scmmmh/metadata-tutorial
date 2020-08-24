Numerical Data
==============

Distributionplots
------------------

We will start with numerical data. For numerical columns, we can use the :code:`distplot` to plot the distribution of the values in the "title_tokens". Run the following code in a new cell:

.. sourcecode:: python

    seaborn.distplot(df['title_tokens'], bins=range(0, max(df['title_tokens']), 1))

The :code:`distplot` merges two plots into a single one. The bars are a histogram plot and the line is a density plot. A histogram plot is created by splitting the range of values into a number of :code:`bins` and then assigning each value to the appropriate bin. The size of each bar then represents the fraction of values that are in that bin. By default the number of bins is estimated from the data, but we can also specify what bins we want:

.. sourcecode:: python

    seaborn.distplot(df['title_tokens'], bins=range(0, max(df['title_tokens']), 1))

Here we use the :code:`range` function to create a list of values from 0 to the maximum value in "title_tokens", with a step size of 1 (:code:`[0, 1, 2, 3, ... n]`). Try running the code to see how the plot compares. Then in a new cell, run the same code, but with a step size of 2 and compare the resulting diagrams. You can see that by increasing the step size, we are essentially smoothing the individual values.

The second part of the diagram is the line which represents a density estimate. Essentially it shows the same as the histogram, but smoothened out even more. The density estimate is calculated as a weighted sum of the values within a certain distance from the current value. That means that values that are further away from the current value are down-weighted, while closer values are given a higher weight. This is also the reason that the curve continues below 0 (even though that makes no sense), as there are still values within the density function's range whose influence slowly reduces until the density estimate hits 0.

Looking at this kind of diagram is a good way to develop an understanding of how the data looks, but any kind of interpretation is exactly that. To draw conclusions you should go back to the statistical analysis.

Scatterplots
------------

Sometimes you will want to see how two variables are distributed at the same time. For this we use the :code:`scatterplot`. Run the following code in a new cell:

.. sourcecode:: python

    seaborn.scatterplot(x='title_tokens', y='completeness', data=df)

This code-example also shows how most plots are generated in Seaborn. You specify the DataFrame to visualise via the :code:`data` parameter and then the columns to plot along the :code:`x` and :code:`y` axes using the respective parameters to specify the column names.

One of the limitations of the scatterplot is that where multiple records have the same pair of values, a single point is shown, giving no indication of how many values might be there. To get a bit of an insight into this, we can add histograms on the outside of the plot with the following code:

.. sourcecode:: python

    seaborn.jointplot(x='title_tokens', y='completeness', data=df)

By taking into account both plots at the same time, we can see where there are more or less values. We can also visualise this another way, using a two-dimensional density estimate plot. Run the following in a new cell:

.. sourcecode:: python

    seaborn.kdeplot(df['title_tokens'], df['completeness'], shade=True)

In the density plot, the more values there are at a certain point, the darker the shade of the area. The plot shows a peak around 8 "completeness" and 10 "title_tokens", but it also shows that there is a separate area of interest with 0 "completeness" and between 3 and 8 "title_tokens".

Just as with the scatterplot, we can add the density estimates for the individual values on the outside with the following code in a new cell:

.. sourcecode:: python

    seaborn.jointplot(x='title_tokens', y='completeness', data=df, kind='kde')

This kind of plot also shows that second peak in the "completeness" very cleanly.

Boxplots
--------

A different way of visualising the distribution of values is the :code:`boxplot`. Run the following code in a new cell:

.. sourcecode:: python

    seaborn.boxplot(y='title_tokens', data=df)

In the :code:`boxplot` the thick horizontal line in the middle is the median value, while the top and bottom ends of the main box are the 25 and 75 percentiles. The whiskers indicate either the maximum or minimum value. The exception to this is if there are values that are more than 1.5 times the inter-quartile-range (IQR, the difference between the 75 and 25 percentiles) higher or lower than the 25 and 75 percentiles. In this case, the whisker is drawn at the value of the 75 percentile plus 1.5 times the IQR and any values greater than that are marked out as dots, indicating outliers. The same is done at the lower end.

One thing we can do with the :code:`boxplot` is to use it to visualise differences in the distributions for a second categorical variable. For example to see the distribution of the "title_tokens" split by language, run the following in a new cell:

.. sourcecode:: python

    seaborn.boxplot(y='title_tokens', x='lang', data=df)

Violinplots
-----------

One thing the :code:`boxplot` does not show in detail is how the values are distributed. To also see this we use the :code:`violinplot`. Run the following in a new cell:

.. sourcecode:: python

    seaborn.violinplot(y='title_tokens', x='lang', data=df)

The :code:`violinplot` basically combine a boxplot (the white dot is the median, the thick bar indicates the 25 and 75 percentiles, the line the min/max, and dots for outliers) with a density estimate.
