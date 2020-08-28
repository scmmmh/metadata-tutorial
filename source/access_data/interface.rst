:iframe-src: /notebooks/Welcome.ipynb

Interface
=========

To get this far in the tutorial, you have already used some parts of the interface, so this will introduce you to the remaining elements and in particular the Jupyter notebook interface that you will use for writing your code.

The interface as a whole is split into two main sections. On the left is the tutorial text that will guide you through the tutorial itself. On the right you have the Jupyter notebook in which you will write and then run your code.

Tutorial Text
-------------

To get back to the start of the tutorial, you can always click on the "Metadata Workshop" or "Home" links. Next to the "Home" link, you can see the list of blocks that make up the tutorial's main structure.

Below the block list and at the bottom of each tutorial page are the navigation elements that allow you to move within a block. You can use the "Next" and "Previous" links to move through the tutorial page-by-page. If you wish to jump to another page within the block, click on the link in the middle of the navigation bar. This will always be the title of the current page and a little structure icon. Clicking on this opens an overlay that shows you all the pages within the current block and you can navigate to a page by clicking on it.

Jupyter Notebook
----------------

On the right you see the Jupyter notebook for the current tutorial page or pages. At various points in the tutorial as you move between pages, the Jupyter notebook will change. However, any changes you have made will automatically be saved and will still be there when you come back.

Each Jupyter notebook consists of a list of cells. Each cell contains either code or text. To add another cell to the Jupyter notebook, you can either click on the plus icon in the toolbar or double-click below any cell. You can then use the dropdown in the toolbar to specify whether the cell should be a code cell or a text cell.

To delete a cell, simply click on the "cut" icon in the toolbar (the small scissors) or select the cell and then press the "d" key twice.

Code cells
++++++++++

When you add a cell, it is always a code cell. A code cell always consists of one or more lines of code to be run and the output of running the code below.

The Jupyter notebook on the right initially contains a single code cell. Into that type the following code:

.. sourcecode:: python

    hello = 'Metadata rule the world!'
    hello

Then press ``Ctrl + Enter`` on your keyboard to run the code in the cell (you can also click on the "Run" button in the toolbar). You will see that in the output area below the code it will say :code:`'Metadata rule the world!'`.

Because this is a very simple piece of code, it runs very quickly. When you have code that takes longer to run, you can see that it is still running by looking at the square brackets ``[ ]`` next to your code. If the square brackets are empty, then the cell has not yet been run. If they contain a number, then that indicates that the cell has already been run. Finally, if the square brackets contain an asterisk "*", then that means that the cell is currently running.

Try out the following code in a new cell:

.. sourcecode:: python

    from time import sleep

    sleep(10)

When you run the cell, it will sleep (pause) for 10 seconds and then complete. Watch the square brackets to see them change to indicate progress.

Text cells
++++++++++

Text cells are mainly there for adding notes to your code. To get a new text cell, first add a cell, then, in the toolbar dropdown that says "Code", select "Markdown". That will convert the cell to a text cell and you can then simply type whatever you want to write down. If you want to format the text, you can use `Markdown`_ to do so.

Try it out now by adding a cell to the notebook, switching that to a text cell, and then adding a quick note.

When you create a new text cell, then it is in editing mode. If you want to switch it to display mode, press ``Ctrl + Enter`` on your keyboard. To switch a text cell from display to edit mode, double-click on the cell.

.. _`Markdown`: https://daringfireball.net/projects/markdown/syntax
