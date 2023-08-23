Fetching Records
================

Fetching the actual records follows the same pattern as fetching the metadata formats. First, we need to import the reader class. Add the following into the first cell of the notebook and then re-run that cell:

.. sourcecode:: python

    from polymatheia.data.reader import OAIRecordReader

Next, in a new cell at the bottom of the notebook add the following code:

.. sourcecode:: python

    reader = OAIRecordReader('http://www.digizeitschriften.de/oai2/', max_records=1)
    for record in reader:
        print(record)

* Line #1 creates a new :code:`OAIRecordReader`, again passing the OAI-PMH endpoint URL as the first parameter. By default the :code:`OAIRecordReader` loads all records from the OAI-PMH server, which can be many thousand. We thus provide a second parameter :code:`max_records=1`, which tells the :code:`OAIRecordReader` to return at most 1 records.
* Line #2 sets up a for loop to loop over all records provided by the :code:`OAIRecordReader`. In this case, this will only be one record, but you can change that parameter in line #1 to return multiple records.
* Line #3 prints the record. In practice this is where we would do more complex processing of each record.

By default the :code:`OAIRecordReader` fetches the data in "oai_dc" format, which looks like this (but will be a bit different, depending on which record is returned):

.. sourcecode:: json

    {
      "header": {
        "identifier": {
          "_text": "oai:www.digizeitschriften.de:PPN720885019_3_0114"
        },
        "datestamp": {
          "_text": "2020-06-30T08:31:20Z"
        },
        "setSpec": {
        }
      },
      "metadata": {
        "{http://www.openarchives.org/OAI/2.0/oai_dc/}dc": {
          "_attrib": {
            "xsi_schemaLocation": "http://www.openarchives.org/OAI/2.0/oai_dc/ http://www.openarchives.org/OAI/2.0/oai_dc.xsd"
          },
          "dc_title": {
            "_text": "Bl\u00e4tter f\u00fcr w\u00fcrttembergische Kirchengeschichte 114"
          },
          "dc_subject": [
            {
              "_text": "200.religion"
            },
            {
              "_text": "PeriodicalVolume"
            }
          ],
          "dc_language": {
            "_text": "ger"
          },
          "dc_publisher": {
            "_text": "Scheufele"
          },
          "dc_date": {
            "_text": "2014"
          },
          "dc_type": {
            "_text": "Text"
          },
          "dc_format": [
            {
              "_text": "image/jpeg"
            },
            {
              "_text": "application/pdf"
            }
          ],
          "dc_identifier": [
            {
              "_text": "http://resolver.sub.uni-goettingen.de/purl?PPN720885019_3_0114"
            },
            {
              "_text": "DigiZeit PPN720885019_3_0114"
            }
          ],
          "dc_source": {
            "_text": "Scheufele: Bl\u00e4tter f\u00fcr w\u00fcrttembergische Kirchengeschichte. Stuttgart 2014"
          },
          "dc_rights": [
            {
              "_text": "DigiZeitschriften Abo"
            },
            {
              "_text": "VereinWKG"
            },
            {
              "_text": "Religion"
            }
          ]
        }
      }
    }

To switch to using METS/MODS, we add an extra parameter to when we create the new :code:`OAIRecordReader`, specifying the :code:`metadata_prefix` of the format you want to use. You can use any of the prefixes that the :code:`OAIMetadataReader` returns. Update the cell to look like this and then re-run it:

.. sourcecode:: python

    reader = OAIRecordReader('http://www.digizeitschriften.de/oai2/', max_records=1, metadata_prefix='mets')
    for record in reader:
        print(record)

The METS/MODS output is too large to be included here, but you can see that it follows the same basic structure as for the "oai_dc" metadata.

As with the :code:`OAIMetadataReader`, you can navigate the records using "dot-notation". We can start by limiting our output to the "metadata" key of the record:

.. sourcecode:: python

    reader = OAIRecordReader('http://www.digizeitschriften.de/oai2/', max_records=1, metadata_prefix='mets')
    for record in reader:
        print(record.metadata)

If you look at the output, you will see that the first key is "{http://www.loc.gov/METS/}mets". Because this includes a ".", we cannot use dot-notation on its own to access it. Instead we need to use square-bracket notation, so update the code to look like this and then re-run the cell:

.. sourcecode:: python

    reader = OAIRecordReader('http://www.digizeitschriften.de/oai2/', max_records=1, metadata_prefix='mets')
    for record in reader:
        print(record.metadata['{http://www.loc.gov/METS/}mets'].mets_dmdSec)

Looking at the output here, we can see that it starts with a square bracket "[". This means that the "mets_dmdSec" element is a list. To access a specific element within the list we again use the square-bracket notation. The difference is that now we simply put the index of the element we wish to access between the square brackets:

.. sourcecode:: python

    reader = OAIRecordReader('http://www.digizeitschriften.de/oai2/', max_records=1, metadata_prefix='mets')
    for record in reader:
        print(record.metadata['{http://www.loc.gov/METS/}mets'].mets_dmdSec[0])

We are now digging deep into the METS/MODS metadata, so let's update the code a bit more to pick out the title. You can either update the cell or add a new cell, if you want to be able to compare the dot-notation path with the original metadata:

.. sourcecode:: python

    reader = OAIRecordReader('http://www.digizeitschriften.de/oai2/', max_records=1, metadata_prefix='mets')
    for record in reader:
        print(record.metadata['{http://www.loc.gov/METS/}mets'].mets_dmdSec[0].mets_mdWrap.mets_xmlData.mods_mods.mods_titleInfo.mods_title._text)

We can now increase the number of records to show, by increasing the :code:`max_records` parameter:

.. sourcecode:: python

    reader = OAIRecordReader('http://www.digizeitschriften.de/oai2/', max_records=10, metadata_prefix='mets')
    for record in reader:
        print(record.metadata['{http://www.loc.gov/METS/}mets'].mets_dmdSec[0].mets_mdWrap.mets_xmlData.mods_mods.mods_titleInfo.mods_title._text)

If we remove the :code:`max_records` parameter, then the code would print out the titles of all records provided by the archive (which in this case would be about 1 million records).

As most archives provide large numbers of records, in the ideal case we would fetch only a sub-set. While OAI-PMH does not provide fine-grained filtering methods, it does allow requesting sub-sets of the data and the next step is to look using those.
