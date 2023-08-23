Next Steps
==========

You have reached the end of the tutorial. This section will briefly cover installing and running the various libraries outside of the tutorial, so that you can use what you have learned here in a full research setting. You can also download a :download:`PDF <../metadatatutorial.pdf>` version of the tutorial text.

Running via Docker
------------------

The complete tutorial environment is available as a `Docker <https://www.docker.com/>`_ container. First install the `Docker Engine <https://www.docker.com/get-started>`_, which is available for Windows, Mac, and Linux. Then run the following command to start the container:

.. sourcecode::

    docker run --rm -p 127.0.0.1:8888:8888 --volume metadata-tutorial:/home/ou/MetadataTutorial-3: scmmmh/metadatatutorial:latest

This will automatically download the required image and start the container. After running the command, when the container has been started, a URL to load the tutorial in the browser will be shown. Copy and paste that into the browser to access the tutorial.

To stop the docker container, press :code:`Ctrl+C`.

Running fully locally
---------------------

To run the various libraries locally, it is recommended to install everything into a virtual environment, which separates all the Python libraries from anything else you have installed on your machine. If you have no preferences regarding how to manage your virtual environments, then `Poetry <https://python-poetry.org/>`_ is a good way to create and manage your virtual environments.

After installing Poetry, follow these steps to install all required dependencies:

.. sourcecode:: console

    poetry add polymatheia
    poetry add scipy
    poetry add seaborn

After that you can run ``python`` inside the virtual environment and all the required libraries will be available.

Running inside a local Jupyter Notebook Server
++++++++++++++++++++++++++++++++++++++++++++++

If you want to run a local Jupyter Notebook Server, run the following additional installation command:

.. sourcecode:: console

    poetry add jupyter

Then run the following to start the server:

.. sourcecode:: console

    jupyter notebook

This will automatically load the Single-user Notebook page in your browser and you can then create your own notebooks in which to run the tutorial's code.
