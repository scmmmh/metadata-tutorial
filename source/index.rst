:layout: tutorial-iframe
:iframe-src: /tutorial/_static/blank.html
:app-menu-download: true
:app-menu-jupyterhub: true

Welcome to the DHd-AG-ZZ Metadata Workshop
==========================================

This tutorial was developed for the DHd Working Group on Newspapers and Periodicals' Metadata Workshop 2020 and is also available as a :download:`PDF <_static/metadataworkshop.pdf>`.

It will introduce you to the basics of loading metadata, filtering out unwanted metadata, transforming the metadata into the required structure, and then analysing and visualising the final metadata. You will also be introduced to the (very) basics of programming with Python.

The tutorial does not have any pre-requisites, except that you must be prepared to get your hands a little bit dirty with a bit of Python code. The tutorial makes heavy use of the `Polymatheia`_ library to hide some of the complexity involved in the load, filter, transform stages. It then uses the `Pandas`_ and `Seaborn`_ libraries for the data analysis and visualisation steps.

.. _`Polymatheia`: https://github.com/scmmmh/polymatheia
.. _`Pandas`: https://pandas.pydata.org/
.. _`Seaborn`: https://seaborn.pydata.org/

.. toctree::
   :maxdepth: 2
   :includehidden:
   :titlesonly:

   Load <access_data/index>
   Filter & Transform <filter_transform_data/index>
   Analyse & Visualise <analyse_visualise_data/index>
   next/index
