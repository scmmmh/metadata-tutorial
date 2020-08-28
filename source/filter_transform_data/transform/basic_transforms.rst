Basic Transformations
=====================

The basic transformations are all designed for taking one or more values from the source record and converting those values into a single value in the output record. Polymatheia supports the following basic transformations:

* :code:`('copy', target, source)`: copy the value identified by the dotted path ``source`` to the location specified by the dotted path ``target``.
* :code:`('static', target, value)`: set the static ``value`` at the location specified by the dotted path ``target``.
* :code:`('fill', target, value)`: set the static ``value`` at the location specified by the dotted path ``target`` **IF** there is no pre-existing value at the dotted path ``target`` or if that value is :code:`None`.
* :code:`('join', target, joiner, source1, source2, ...)`: join together the values identified by the dotted paths ``source1``, ``source2``, ... using the string ``joiner`` and set it at the location specified by the dotted path ``target``.
* :code:`('custom', target, function)`: call the function ``function`` with the record as the parameter and store the returned value at the location specified by the dotted path ``target``.

Single value transformations
----------------------------

The most commonly used transformation is :code:`'copy'`. Add a new cell with the following code:

.. sourcecode:: python

    mapping = ('copy', 'lang', 'dcLanguage[0]')
    transformed = RecordsTransform(reader, mapping)
    for record in transformed:
        print(record)

As you can see, the basic pattern is the same we saw when filtering records. The transformation :code:`mapping` is specified as a tuple in line \#1. Here we specify a transformation that will extract the language specified on the record. Because the "dcLanguage" field is always a list, we use the :code:`[0]` subscript to fetch the first value in the list. The result is stored under the key "lang". Then in the next line (\#2) we create a new :code:`RecordsTransform` with the :code:`reader` providing the source data and the :code:`mapping` to apply.

When you run the code, you will see that it produces a long list of outputs that look like this (the language values will vary):

.. sourcecode:: json

    {
        "lang": "de"
    }

Next, let us look at the :code:`'static'` transformation. Add a new cell with the following code:

.. sourcecode:: python

    mapping = ('static', 'source', 'europeana')
    transformed = RecordsTransform(reader, mapping)
    for record in transformed:
        print(record)

If you run the code, you will see that, as promised by the name of the transformation, it simply sets the static value. At first look there may not seem to be much point to this, but it can often be useful to set specific static data that indicates either where the data came from or how it has been processed. In particular if you later merge the data with other data, this static value can then be used to distinguish things in the analysis.

We will skip the :code:`'fill'` transformation for the moment. When used on its own, it works exactly like the :code:`'static'` transformation. Only when used together with another transformation can it be used to fill in a default value.

Multiple value transformations
------------------------------

Polymatheia actually supports a range of multi-value transformations, but here we will only look at one: :code:`'join'`. Create a new cell and add the following code:

.. sourcecode:: python

    filtered = RecordsFilter(reader, ('and', ('exists', ['edmPlaceLatitude']), ('exists', ['edmPlaceLongitude'])))
    mapping = ('join', 'lat_lon', ',', 'edmPlaceLatitude[0]', 'edmPlaceLongitude[0]')
    transformed = RecordsTransform(filtered, mapping)
    for record in transformed:
        print(record)

Here you can see a pattern that you will frequently see in your own code. First, we apply a filter to the data-set, then we transform those records that pass through the filter. Here the filter is simply used to ensure we transform only those records that have co-ordinates.

In the transform, we take the first "edmPlaceLatitude" value and the first "edmPlaceLongitude" value and combine them using a ",", storing the result in a field called "lat_lon". We may need a transformation such as this one because we are planning to plot the data on a map and that requires the co-ordinates to be in this format. Run the cell to see how the data is transformed.

Custom transformations
----------------------

The final transformation we will look at, very briefly, is the :code:`'custom'` transformation. The :code:`'custom'` transformation allows us to apply our own transformation function to each record. The function is given the record and it is expected that it returns a single value, which is stored as the result. Create a new cell and add the following code:

.. sourcecode:: python

    mapping = ('custom', 'title_tokens', lambda record: len(record.title[0].split()))
    transformed = RecordsTransform(reader, mapping)
    for record in transformed:
        print(record)

If you run it, you will see that this outputs the number of white-space split tokens in the title. The important bit of code here is this:

.. sourcecode:: python

    lambda record: len(record.title[0].split())

The :code:`lambda` defines what is known as a "lambda function", which is basically a very simple function that can be defined in-line, as is the case here. After the :code:`lambda` keyword, the next element(s) are the parameters to the lambda function. Because the :code:`'custom'` transform calls the lambda function with a single parameter, we only define a single parameter here (:code:`record`). The ":" indicates that what follows is the function's body code, which is run every time the function is called. In this case we first get the first title value :code:`record.title[0]` and then :code:`split()` that. By default the :code:`split()` function splits on white-space, which is exactly what we want here. The :code:`split()` returns a list of split tokens, so we then pass that to the :code:`len()` function, which counts the number of tokens and returns that as a value.

Run the code and you will see that the result contains the number of white-space-split tokens for each title.

The function passed to the :code:`'custom'` transform does not have to be a lambda function, it can also be a full function, but looking at writing those is outside the scope for this tutorial.
