Filtering by Set
================

OAI-PMH provides only one way of filtering on the server-side and that is the "Set". Sets are constructed by the archive administrators, by attaching one or more set specs (essentially unique identifiers) to each metadata record. Then, when fetching records, we can specify one set spec and it will return only those records that have been annotated with that spec.

The first step when using sets is always to fetch the list of all available sets, to see what options are available. You should by now be familiar (and hopefully comfortable) with the pattern for this. First, add the following line to the first cell in the notebook and then re-run the cell:

.. sourcecode:: python

    from polymatheia.data.reader import OAISetReader

Next, add a new cell to the end of the notebook and add the following code:

.. sourcecode:: python

    reader = OAISetReader('http://www.digizeitschriften.de/oai2/')
    for setSpec in reader:
        print(setSpec)

As you can see from the output, each set spec consists of a "setSpec", which is the unique identifier, and a "setName", which is a human-readable version. We use the human-readable version to decide which set to use and then we use the unique identifier for filtering. In this example we will use the "Europeana" set, which has the set spec "EU". To filter, add the following code to a new cell at the end of the notebook:

.. sourcecode:: python

    reader = OAIRecordReader('http://www.digizeitschriften.de/oai2/', max_records=10, metadata_prefix='mets', set_spec='EU')
    for record in reader:
        print(record.metadata['{http://www.loc.gov/METS/}mets'].mets_dmdSec[0].mets_mdWrap.mets_xmlData.mods_mods.mods_titleInfo.mods_title._text)

When you run this code, you are most likely going to get a ``KeyError``. This is because sometimes the ``mets_dmdSec`` is a single object and sometimes it is a list of objects. To make the code work we need to distinguish these two cases. The way to do that in code is the :code:`if` statement. Update the cell so that it looks like this:

.. sourcecode:: python

    reader = OAIRecordReader('http://www.digizeitschriften.de/oai2/', max_records=10, metadata_prefix='mets', set_spec='EU')
    for record in reader:
        if isinstance(record.metadata['{http://www.loc.gov/METS/}mets'].mets_dmdSec, list):
            print(record.metadata['{http://www.loc.gov/METS/}mets'].mets_dmdSec[0].mets_mdWrap.mets_xmlData.mods_mods.mods_titleInfo.mods_title._text)
        else:
            print(record.metadata['{http://www.loc.gov/METS/}mets'].mets_dmdSec.mets_mdWrap.mets_xmlData.mods_mods.mods_titleInfo.mods_title._text)

When you run the cell, you will see that now your code outputs ten titles.

The polymatheia library provides an alternative function for getting values from a record. Add a new cell to the end of the notebook with this code:

.. sourcecode:: python

    reader = OAIRecordReader('http://www.digizeitschriften.de/oai2/', max_records=10, metadata_prefix='mets', set_spec='EU')
    for record in reader:
        print(record.get(['metadata', '{http://www.loc.gov/METS/}mets', 'mets_dmdSec', 'mets_mdWrap', 'mets_xmlData', 'mods_mods', 'mods_titleInfo', 'mods_title', '_text']))

Each record comes with a :code:`get` function, which we can either pass a path as a single dotted string, or if, as in this case, one of the path elements contains a full-stop, a list of path elements. The :code:`get` function does one thing differently to just using the dot-notation. If a path element identifies a list (such as the ``'mets_dmdSec'`` element) and the next element is not a list index (``'mets_mdWrap``), then the :code:`get` function will apply the remainder of the path to each element in the list and return a list of values. If you run this cell, you will see that you now get 9 lists of titles and one single title.

Which one of the two approaches you use depends on the specific scenario and whether you need to control whether a certain element is a list value or not.

As OAI-PMH is not really meant for repeatedly fetching small structures, but rather at fetching everything and then working locally, the next step is to look at how to store things locally.
