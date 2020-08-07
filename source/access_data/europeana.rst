Loading data from Europeana
===========================

We will now look at a second data-source: `Europeana`_. Europeana comes with its own metadata schema and a custom API (application programming interface), as we will see in a moment. In order to use the API you need to have an API Key, which you need to apply for `here <https://pro.europeana.eu/page/get-api>`_ before we continue.

.. _`Europeana`: https://www.europeana.eu

When you have your key, we can start with acessing the Europeana API. First, we need to import the :code:`EuropeanaSearchReader` in the first cell, by adding the following code and then re-running the cell:

.. sourcecode:: python

    from polymatheia.data.reader import EuropeanaSearchReader

Next, add a cell at the end of the notebook and add the following code:

.. sourcecode:: python

    EUROPEANA_API_KEY = ''
    reader = EuropeanaSearchReader(EUROPEANA_API_KEY, 'Python', max_records=1)
    for record in reader:
        print(record)

Copy your Europeana API Key between the :code:`''` string markers. Then run the cell. If everything works, you will see a single record output. We don't have time to go through all the fields in detail here, but you can find a description of all the fields in the `Europeana Search API documentation <https://pro.europeana.eu/page/search#result-fields-edm>`_.

Creating a new :code:`EuropeanaSearchReader` always requires at least two parameters. The first is the Europeana API key and the second is the search query. In our first example we simply search for the string "Python". If you want, you can try replacing that with a different value and seeing what the results are like.

We can interact with a Europeana record in the same way as with an OAI-PMH one, using dot-notation. Update the code in the cell to fetch 10 records and output only the country value:

.. sourcecode:: python

    EUROPEANA_API_KEY = ''
    reader = EuropeanaSearchReader(EUROPEANA_API_KEY, 'Python', max_records=10)
    for record in reader:
        print(record.country)

Complex Queries
---------------

The full documentation of the Europeana query language can be found `here <https://pro.europeana.eu/page/search#basic-search>`_. In this tutorial we will just look at some of the basics. First, add a new cell with the following content:

.. sourcecode:: python

    reader = EuropeanaSearchReader(EUROPEANA_API_KEY, '"Karl Gutzkow"', max_records=10)
    for record in reader:
        print(record.title)

Using the double quotes ensures that the results contain the text as it is. If you want to allow for a bit more flexibility, you can use the following code:

.. sourcecode:: python

    reader = EuropeanaSearchReader(EUROPEANA_API_KEY, 'Karl AND Gutzkow', max_records=10)
    for record in reader:
        print(record.title)

By default the search will run across all fields. To reduce the filter to a single field, specify it in the query:

.. sourcecode:: python

    reader = EuropeanaSearchReader(EUROPEANA_API_KEY, 'title:Karl AND title:Gutzkow', max_records=10)
    for record in reader:
        print(record.title)

We cannot cover all the available fields here, but they can be found `here <https://pro.europeana.eu/page/search#result-fields-edm>`_.

Result Profiles
---------------

The Europeana Search API can provide different `levels of detail <https://pro.europeana.eu/page/search#profiles>`_ in the results. By default it provides the "standard" result profile and for determining what query to use to find the data-set one is interested in, it is ideal. However, when downloading the data for further processing, the "rich" profile is generally better, as it provides the maximum level of detail:

.. sourcecode:: python

    reader = EuropeanaSearchReader(EUROPEANA_API_KEY, 'title:Karl AND title:Gutzkow', profile='rich', max_records=1)
    for record in reader:
        print(record)

When you run the cell, you will see that it now contains more metadata.

Reusability
-----------

All records in the Europeana archive are provided with rights information, detailing what `use is possible <https://pro.europeana.eu/page/search#reusability>`_. To restrict the results to, for example, those where any kind of re-use is possible, we use the :code:`reusability` parameter in a new cell:

.. sourcecode:: python

    reader = EuropeanaSearchReader(EUROPEANA_API_KEY, 'title:Karl AND title:Gutzkow', reusability='open', max_records=1)
    for record in reader:
        print(record)

Runnint this code will only return those records that are freely re-usable. This includes public domain works, and CreativeCommons Attribution and Attribution-ShareAlike works. If you want to narrow it down more specifically, you need to filter in the query:

.. sourcecode:: python

    reader = EuropeanaSearchReader(EUROPEANA_API_KEY, 'title:Karl AND title:Gutzkow AND RIGHTS:"http://creativecommons.org/publicdomain/mark/1.0/"', reusability='open', max_records=1)
    for record in reader:
        print(record)
