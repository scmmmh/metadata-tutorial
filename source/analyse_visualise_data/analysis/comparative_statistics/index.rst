:layout: tutorial-iframe
:iframe-src: /notebooks/ComparativeStatistics.ipynb

Comparative Statistics
======================

Now that we have a filtered-down and cleaned data-set, we can look at doing some comparative statistical analysis on the data-set. We will look at two tests in this section: Mann-Whitney-U and :math:`\chi^2` (chi-square).

Before we look at the tests in detail, we need to have a quick look at some basic concepts in this area of statistics. The fundamental assumption in all these statistical tests is that you do **not** have access to a complete view of the world, instead you are relying on a sample of the data. This aligns nicely with any archival work, because archiving is always a sampling process. At the same time there is an important caveat here. The statistical tests assume that there is no explicit or implicit bias in the archival sampling process. That means that statistical tests may report that there are significant effects, when in reality those are caused by an explicit or implicit bias in how the digital archive was created. It is thus important when reporting statistical results, to check for and discuss the effects of any potential biases.

Here are some of the most important concepts in this area of statistics:

* *population*: the full set of all values, which you generally do not have access to.
* *sample*: a sub-set of the full set of values in the *population*. The *sample* should be selected from the *population* using an unbiased method, based upon one or more criteria.
* *independent samples*: two or more *samples* that have been acquired in such a way that acquiring the values in one did not influence the values in the other(s). Two values calculated using the same formula from two separate texts are *independent*. Two values calculated using different formulas from the same text are *dependent*.
* *null-hypothesis*: the default assumption when comparing the *samples*. Generally the *null-hypothesis* is that the *samples* have been taken from the same population and do not show any differences.
* *alternative hypothesis*: our hypothesis as to what the difference between the *samples* will be. The *alternative hypothesis* is what we actually believe the relationship between the *samples* to be. For example we may believe that the values of the first sample are smaller than the values of the second sample and that is the *alternative hypothesis*, while the *null hypoethesis* is that there is no difference.
* *statistical test*: a mathematical model that calculates how likely it is that the *null-hypothesis* is wrong and that the *alternative hypoethesis* is correct.
* *p-value*: the probability that any differences between the *samples* are due to bad luck in the sampling process and are not actually indicative of any real difference between the two samples. For example a *p-value* of 0.05 means that there is a 1 in 20 chance of seeing the observed *samples* just by chance and not due to any actual differences between the samples.
* *statistical significance*: is used to indicate when a *p-value* implies that there is an actual difference between the *samples*, meaning that there are two distinct groups within the *population*. Generally for *statistical significance* the *p-value* is expected to be smaller than 0.05 (1 in 20), 0.01 (1 in 100), or 0.001 (1 in 1000). Which boundary you choose depends upon how definite you require your result to be. For example a *p-value* of 0.05 means that if you sampled 20 times, you would see one set of samples where there is *statistical significance* even though there is no actual difference in the underlying *populations*. The less you know about how your samples were generated, the lower you should set your boundary.

.. toctree::
   :hidden:

   mann_whitney_u
   chi_square
