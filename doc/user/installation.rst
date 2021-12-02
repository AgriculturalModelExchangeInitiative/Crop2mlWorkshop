CropMStudio installation
========================

.. note::
   
   **Questions welcome!**

   This workshop is intended to help teach scientists how to use the Crop2ML package to manage crop model components. Part of that is answering your questions. 
   Please let us know if you have any questions or difficulties by opening an issue on the Crop2MLWorkshop materials `Github repository page <https://github.com/AgriculturalModelExchangeInitiative/Crop2mlWorkshop/issues/new`_. 
   Chances are good that if you have a question/problem, someone else is having the same question/problem. By reporting them as public issues, you are making it easier for us to help you and helping others to find answers in the future as there will be a searchable record of the problem and (hopefully) a solution.

   Once you are satisfied that your question/bug has been answered/solved, please close the issue or let us know that we may do so. 

.. _setup:
Setup
#####

There are three methods to run them, MyBinder, local install with or without Docker container, each of which is described below. We recommend using the MyBinder method as it does not require any local installation, but if you have difficulty opening the MyBinder instance, one of the other methods may be preferable.

1. Reguardless of the installation method, you will need a browser to access the notebook that lauch CropMStudio. MyBinder fully supports Mozilla Firefox, Google Chrome, and Safari. It may work with Microsoft Edge (or Internet Explorer), but these are not guaranteed. If you have trouble accessing the notebooks, we recommend downloading one of those MyBinder fully supports for this workshop.

MyBinder
========

MyBinder is a free public service that allows users to run Jupyter notebooks on remote compute resources via BinderHub. This method is the most straight forward as it does not require you to install anything on your machine other than a browser. 

#. Open `this link <https://mybinder.org/v2/gh/AgriculturalModelExchangeInitiative/Pycrop2ml_ui.git/HEAD?urlpath=lab>`_ or click the ``launch binder`` button in the README for the `Crop2MLWorkshop repository <https://github.com/AgriculturalModelExchangeInitiative/Crop2mlWorkshop>`_.
#. Wait for the binder instance to launch. This can take update a few minutes if the repository has been updated recently. When the instance is running, you should see a file browser like below. So, it is useful to launch at least once before the workshop

.. image:: images/binder_launch.png

.. note::

   Changes you make in your environment are only present on the specific instance that you are interacting with and will disappear when the instance shutdowns. 
   If you want to keep any changes you make, you will need to download your results. You can then upload it to future instances.

Local Install
=============

This setup method is the most involved, but once it is complete, you will have a local conda environment with yggdrasil installed that can be used in the future.

.. note::

   One Windows, commands below should be executed from a conda command prompt which should be available in your start menu after installing miniconda.

     
Docker Container
================

Docker containers allow developer to package the entire stack (operating system, dependencies, scripts, data) required to run projects in a contained environment. In this case, we are using the container to run the Jupyter notebooks so you don't have to install the dependencies on your machine which can encounter issues on untested releases and/or combinations of operating systems and/or dependencies.

#. **Download and install docker** from `here <https://docs.docker.com/get-docker/>`_.
#. **Sign-up for DockerHub** `here <https://hub.docker.com/>`_, start docker, and sign-in using your docker hub credentials (either via the desktop app or the `command line <https://docs.docker.com/engine/reference/commandline/login/>`_).
#. **Pull the hackathon image** from `docker hub <https://hub.docker.com/r/langmm/hackathon2021>`_::

     docker pull langmm/hackathon2021:0.0.8
     
#. **Create a work directory** that the hackathon container will be used to store updates to the notebooks and compilation products. This can be any directory that you have write access to.
#. **Start a container** from the hackathon image by running the command below, replacing ``<some directory name>`` with the full path to the directory you wish the image to use::

       docker run -it --rm -p 8888:8888 -e NB_UID=$(id -u) --user root -v <some directory name>:/tmp langmm/crop2mlworkshop:0.0.8

   ..
      * Running the `langmm/hackathon2021` from the docker desktop app by clicking the run button shown below

	.. image:: images/binder_launch.png

	entering the following in the `Optional Settings` fields:
	  * `Local Host` under `Ports`: `8888`
	  * `Host Path` under `Volumes`: The full path to the directory you created in the previous step
	  * `Container Path` under `Volumes`: `/tmp`


#. **Open the browser** by going to http://localhost:8888/tree in your browser. You should see a file browser like the one below

