:layout: tutorial-only-left

Next Steps
==========

You have reached the end of the tutorial. This section will briefly cover installing and running the various libraries outside of the tutorial.

Running via Docker
------------------

The complete tutorial environment is available as a `Docker <https://www.docker.com/>`_ container. The `Docker Engine <https://www.docker.com/get-started>`_ is available for Windows, Mac, and Linux.

Running fully locally
---------------------

To run the various libraries locally, it is recommended to install everything into a virtual environment, which separates all the Python libraries from anything else you have installed on your machine. If you have no preferences regarding how to manage your virtual environments, then `Poetry <https://python-poetry.org/>`_ is the recommended way to create and manage your virtual environments.

After installing Poetry, follow these steps to install all required dependencies:

.. sourcecode:: console

    poetry add polymatheia
    poetry add scipy
    poetry add seaborn

After that you can run ``python`` inside the virtual environment and all the required libraries will be available.

Running inside a local Jupyter Notebook Server
++++++++++++++++++++++++++++++++++++++++++++++

If you want to run a local Jupyter Notebook Server first run this command:

.. sourcecode:: console

    poetry add jupyter

Then run the following to start the server:

.. sourcecode:: console

    jupyter notebook

This will automatically load the Single-user Notebook page in your browser.
