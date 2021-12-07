Create Crop2ML ModelUnit
========================

Remind that a Crop2ML ModelUnit is composed of its specification (meta-information) represented in a xml file to which is associated an algorithm representing the relationship between the inputs and the outputs of the model.

How
---

To create a Crop2ML ModelUnit in CropMStudio:

1. On the home interface click on "Model Creation"
2. Select *Model Unit*
3. Then fill the different tables  with the information related to the ModelUnit.
  * General information (name, id, version, ...)
  * Declaration of inputs and outputs (click on Add to create a new row for a new input or output)
  * Select initialisation if needed 
  * A Parametersets section will appear if the ModelUnit contains parameters. In this case:
    + Create a Parameterset by filling its name and description
    + A table of the ModelUnit parameters will be opened. Then, set the parameters for unit tests. 
    + Other Parameterset can be created.
  * Finally, Testsets section appears.
    + Create a Testset by clicking on Create in Testset Line and by filling its name and description. Associate a Parameterset by selecting its name.
    + Create one or several tests in this Testset. To create a Test, select Create in Test line. Then, a table of the ModelUnit inputs and outputs will be opened. Then, set the inputs and the expected values of the outputs for unit tests. 
    + Several Testset can be created.

Exercise:
---------

Consider that you would like to create two simple ModelUnits in the Energy Balance package : Net Radiation and Net radiation in equivalent evaporation. Then in the next lines, the meta-information is provided with model equations in order to create two Crop2ML ModelUnits.


**Net radiation**

- Model equations in CyML
  
.. literalinclude:: ../../examples/SQ_Energy_Balance/crop2ml/algo/pyx/netradiation.pyx
   :language: cython
   :emphasize-lines: 1-8
   :lineno-start: 1

- Model meta-information

.. csv-table:: Parameters meta-information
   :header: name, description, default, min, max, unit
   :stub-columns: 1

   albedoCoefficient,albedo Coefficient,0.23,0.0,1.0,""
   stefanBoltzman,stefan Boltzman constant,4.903E-09,0.0,1.0,""
   elevation,elevation,0,-5000,10000,m

.. csv-table:: Variables meta-information
   :header: name, description, default, min, max, unit
   :stub-columns: 1

   minTair,minimum air temperature,0.7,-30,45.0,"degC"
   maxTair,maximum air Temperature,7.2,-30.0,45.0,"degC"
   solarRadiation,solar radiation,3,0.0,10000.0,"MJ*m-2*d-1"
   vaporPressure,vapor Pressure,6.1,0.0,10000.0,"hPa"
   extraSolarRadiation,extra Solar Radiation,11.7,0.0,1000.0,"m"
   netRadiation, net Radiation,"",0.0,5000.0, "MJ*m-2*d-1"
   netOutGoingLongWaveRadiation,net OutGoing Long Wave Radiation,"",0.0,5000.0,"g*m-2*d-1"



**Net radiation in equivalent evaporation**

- Model equations in CyML
  
.. literalinclude:: ../../examples/SQ_Energy_Balance/crop2ml/algo/pyx/netradiationequivalentevaporation.pyx
   :language: cython

- Model meta-information

.. csv-table:: Parameters meta-information
   :header: name, description, default, min, max, unit
   :stub-columns: 1

   lambdaV,latent heat of vaporization of water,2.454,0.0,10.0,"MJ*kg-1"

.. csv-table:: Variables meta-information
   :header: name, description, default, min, max, unit
   :stub-columns: 1

   netRadiation,net Radiation,1.566,0.0,5000.0,"MJ*m-2*d-1"
   netRadiationEquivalentEvaporation,net Radiation in Equivalent Evaporation,"",0.0,5000.0,"g*m-2*d-1"


Look at the process of Crop2ML ModelUnit Creation through this video:

.. raw:: html
    <video controls src="../_static/create_model_unit.mp4"></video> 
