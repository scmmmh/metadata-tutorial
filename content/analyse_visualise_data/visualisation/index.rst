Visualisation
=============

At this point open and use the {file}`Visualisation.ipynb` notebook.

Visualisations are a useful method for making information and results more accessible. However, it is important to note that visualisations are also **always** reductions, simplifications, and distortions of the underlying data and should only be used as illustration, not as proof of anything.

To get started, add the following code into the notebook and run it:

.. sourcecode:: python

    import seaborn
    from polymatheia.data.reader import JSONReader
    from polymatheia.data.writer import PandasDFWriter
    from polymatheia.filter import RecordsFilter
    from polymatheia.transform import RecordsTransform

    def map_language(record):
        if record.lang == 'ger' or record.lang == 'deu' or record.lang == 'Deutsch':
            return 'de'
        elif record.lang == 'hun':
            return 'hu'
        elif record.lang == 'swe':
            return 'sv'
        elif record.lang == 'pol':
            return 'pl'
        elif record.lang == 'fre':
            return 'fr'
        elif record.lang == 'cat':
            return 'ca'
        elif record.lang == 'lat':
            return 'la'
        elif record.lang == 'ita':
            return 'it'
        return record.lang

    reader = JSONReader('europeana_test')
    mapping = ('parallel', ('copy', 'id', 'id'),
                           ('sequence', ('copy', 'lang', 'dcLanguage[0]'), ('custom', 'lang', map_language)),
                           ('custom', 'title_tokens', lambda record: len(record.title[0].split())),
                           ('copy', 'completeness', 'europeanaCompleteness'),
                           ('copy', 'type', 'type'))
    transformed = RecordsTransform(reader, mapping)
    fltr = ('and', ('exists', ['lang']),
                   ('neq', ['lang'], 'mul'),
                   ('neq', ['lang'], 'zxx'),
                   ('neq', ['lang'], 'und'),
                   ('neq', ['lang'], 'la'),
                   ('neq', ['lang'], 'sv'),
                   ('neq', ['lang'], 'es'),
                   ('neq', ['lang'], 'da'),
                   ('neq', ['lang'], 'nl'),
                   ('neq', ['lang'], 'ca'),
                   ('neq', ['lang'], 'it'),
                   ('neq', ['lang'], 'et'),
                   ('neq', ['lang'], 'en'),
                   ('lt', ['title_tokens'], 30))
    filtered = RecordsFilter(transformed, fltr)
    df = PandasDFWriter().write(filtered)

With our data now in place, we will look at visualising :doc:`numeric_data` and :doc:`categorical_data`.
