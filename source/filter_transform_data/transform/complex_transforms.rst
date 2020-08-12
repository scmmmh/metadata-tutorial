Complex Transformations
=======================

The basic transformations are useful, but to actually construct a more complete transformed record, we need to apply multiple transformations to the same record, and possibly further transform the result.

Parallel transformation
-----------------------

First we will look at the :code:`'parallel'` transformation, which allows us to apply multiple transformations to the same record and combine their outputs into a single resulting record. Create a new cell and add the following code:

.. sourcecode:: python

    filtered = RecordsFilter(reader, ('and', ('exists', ['edmPlaceLatitude']), ('exists', ['edmPlaceLongitude'])))
    mapping = ('parallel', ('copy', 'id', 'id'),
                           ('copy', 'lang', 'dcLanguage[0]'),
                           ('join', 'lat_lon', ',', 'edmPlaceLatitude[0]', 'edmPlaceLongitude[0]'),
                           ('custom', 'title_tokens', lambda record: len(record.title[0].split())))
    transformed = RecordsTransform(filtered, mapping)
    for record in transformed:
        print(record)

As you can see, the :code:`'parallel'` transformation contains four nested basic transformations and if you run the code, you will see that each result record now has four values.

Sequential transformation
-------------------------

If you go back to the output of the basic :code:`('copy', 'lang', 'dcLanguage[0]')` transform, you will see that some of the values are :code:`null`. We briefly touched on the :code:`'fill'` transformation as a way of filling those empty values, but that needs to be run in sequence after the initial :code:`'copy'` transformation. Create a new cell and add the following code:

.. sourcecode:: python

    filtered = RecordsFilter(reader, ('and', ('exists', ['edmPlaceLatitude']), ('exists', ['edmPlaceLongitude'])))
    mapping = ('sequence', ('copy', 'lang', 'dcLanguage[0]'),
                           ('fill', 'lang', 'NA'))
    transformed = RecordsTransform(filtered, mapping)
    for record in transformed:
        print(record)

You can see that the :code:`'sequence'` filter is defined like the :code:`'parallel'` filters. The difference is that the output of the first transformation is passed as the input to the second transformation (and so on, if you have more transformations in sequence). Here we use the value :code:`'NA'` as the default value to use where there is no :code:`'lang'` value.

Complex transformations
-----------------------

In practice most transformations will combine :code:`'parallel'` and :code:`'sequence'` transformations. We can combine the last two examples into a complete example:

.. sourcecode:: python

    filtered = RecordsFilter(reader, ('and', ('exists', ['edmPlaceLatitude']), ('exists', ['edmPlaceLongitude'])))
    mapping = ('parallel', ('copy', 'id', 'id'),
                           ('sequence', ('copy', 'lang', 'dcLanguage[0]'),
                                        ('fill', 'lang', 'NA')),
                           ('join', 'lat_lon', ',', 'edmPlaceLatitude[0]', 'edmPlaceLongitude[0]'),
                           ('custom', 'title_tokens', lambda record: len(record.title[0].split())))
    transformed = RecordsTransform(filtered, mapping)
    for record in transformed:
        print(record)

Here you can see that the :code:`'sequence'` transformation is nested inside the :code:`'parallel'` transformation. If you run the cell, you will see that each record now contains four values and that all the :code:`null` values have been replaced with :code:`'NA'`.
