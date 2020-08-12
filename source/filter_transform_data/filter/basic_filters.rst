Basic Filters
=============

The basic filters provided by Polymatheia allow you to compare a value in a record to a fixed value. We have already seen the simplest basic filter, the :code:`'true'` filter. The following basic filters are provided:

* :code:`('true',)`: Lets any record pass.
* :code:`('false',)`: Lets no record pass.
* :code:`('eq', a, b)`: Lets the record pass if the value of :code:`a` is equal to the value of :code:`b`.
* :code:`('neq', a, b)`: Lets the record pass if the value of :code:`a` is not equal to the value of :code:`b`.
* :code:`('gt', a, b)`: Lets the record pass if the value of :code:`a` is greater than the value of :code:`b`.
* :code:`('gte', a, b)`: Lets the record pass if the value of :code:`a` is greater than or equal to the value of :code:`b`.
* :code:`('lt', a, b)`: Lets the record pass if the value of :code:`a` is less than the value of :code:`b`.
* :code:`('lte', a, b)`: Lets the record pass if the value of :code:`a` is less than or equal to the value of :code:`b`.
* :code:`('contains', a, b)`: Lets the record pass if the value of :code:`a` is contains the value of :code:`b`.
* :code:`('exists', a)`: Lets the record pass if the value of :code:`a` is not :code:`None`.

Where the filter expression contains :code:`a` and :code:`b`, either of these can be one of:

* A dotted string: in this case the value to be compared is taken from the record using the dotted string to identify the value to compare.
* A list: the value to be compared is taken from the record using the list to identify the value to compare.
* Anything else: the value is compared as is.

We can now try out a few of the basic filters.

Filtering by type
-----------------

The first thing we will try out is filtering records so that only the image records are returned. Add a new cell at the bottom of the notebook and add the following code:

.. sourcecode:: python

    fltr = ('eq', ['type'], 'IMAGE')
    images = RecordsFilter(reader, fltr)
    count = 0
    for record in images:
        count = count + 1
        print(record.type)
    print(count)

If you look at the code, the only interesting change in the code is the definition of the :code:`fltr` variable, which here is defined as an equal filter. We use the list format to specify the field to fetch from the record for comparison, because if we just used the string notation, there would be no "." in the string, and it would not be recognised as a dotted path.

If you run the cell, you will see that now we only get 101 image records. We could also flip this around to show anything but the image records, by replacing the :code:`'eq'` with :code:`'neq'` in the filter. Try it out and see what the result looks like.

Filtering by completeness
-------------------------

Now let us try out the numerical comparison filters. Each Europeana record comes with a field "europeanaCompleteness", which specifies how complete that metadata record is. We can now use that to filter our records to high quality items. Add a new cell at the bottom of the notebook and add the following code:

.. sourcecode:: python

    fltr = ('gt', ['europeanaCompleteness'], 9)
    complete = RecordsFilter(reader, fltr)
    count = 0
    for record in complete:
        count = count + 1
    print(count)

The completeness value is in the range 1 to 10, so testing if the value is greater than 9 is essentially the same as testing for equality with 10. If you run the cell, you will see that there are 159 records with a europeanaCompleteness of 10.

We can now play with the comparison operator. First, let us say that we are happy with a value of 9 as well in our records. Change the :code:`'gt'` to :code:`'gte'` to allow values of 9 or 10 and re-run the cell. You will see that now there are 258 records.

We can do the opposite as well. By replacing :code:`'gte'` with :code:`'lt'` we can find those records that have a completeness value smaller than 9, which produces 751 records. This also validates that the filters are doing what we expected, as 751 records plus the 258 greater-than-or-equal records results in the correct total of 1009 records.

Filtering by language
---------------------

Finally we will look at filtering by language. Add the following code into a new cell at the bottom of the notebook:

.. sourcecode:: python

    fltr = ('contains', ['dcLanguage'], 'ger')
    german = RecordsFilter(reader, fltr)
    count = 0
    for record in german:
        count = count + 1
    print(count)

If you run the cell, you will see that a total of 103 records is returned. However, as we will see in a moment, when we move on to complex filters, these are not all the German language records and we need to do a bit more work to see all of them.

Sometimes at the filtering step we don't care what the value is, just that it is there. For that we can use the :code:`'exists'` filter. Add and run a new cell with the following code:

.. sourcecode:: python

    images_with_language = RecordsFilter(reader, ('exists', ['dcLanguage']))
    count = 0
    for record in images_with_language:
        count = count + 1
    print(count)

You will see that it shows that 923 of the records have the dcLanguage attribute set.

The advantage of the :code:`'exists'` filter is that for any further processing it is guaranteed that the "dcLanguage" value exists, making further processing much simpler.
