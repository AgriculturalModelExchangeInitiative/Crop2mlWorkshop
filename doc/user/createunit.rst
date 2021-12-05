Create Crop2ML ModelUnit
========================

Recall that a Crop2ML ModelUnit is composed of its specification (meta-information) represented in a xml file to which is associated an algorithm representing the relationship between the inputs and the outputs of the model.


Consider that you would like to create two simple ModelUnits in the Energy Balance package : Net Radiation and Net radiation in equivalent evaporation.
Then in the next lines, the meta-information is provided with model equations in order to create two Crop2ML ModelUnits.

Let's go!
* On the home interface click on "Model Creation"
* Select *Model Unit*
* Then fill the different tables  with the information related to the ModelUnit.
  * General information (name, id, version, ...)
  * Declaration of inputs and outputs (click on Add to create a new row for a new input or output)
  * Select initialisation if needed 
  * A Parametersets section will appear if the ModelUnit contains parameters. In this case:
    * Create a Parameterset by filling its name and description
    * A table of the ModelUnit parameters will be opened. Then, set the parameters for unit tests. 
    * Other Parameterset can be created.
  * Finally, Testsets section appears.
    * Create a Testset by clicking on Create in Testset Line and by filling its name and description. Associate a Parameterset by selecting its name.
    * Create one or several tests in this Testset. To create a Test, select Create in Test line. Then, a table of the ModelUnit inputs and outputs will be opened. Then, set the inputs and the expected values of the outputs for unit tests. 
    * Several Testset can be created.
  

**Net radiation**
-----------------

- Model equations
  
.. literalinclude:: ../../examples/SQ_Energy_Balance/crop2ml/algo/pyx/netradiation.pyx
   :language: cython
   :lineno-start: 2


.. math::
    Nsr = (1.0 - albedoCoefficient) * solarRadiation
    clearSkySolarRadiation = (0.75 + 2^(10.0, -5) * elevation) * extraSolarRadiation
    averageT = ((maxTair + 273.16)^4 + (minTair + 273.16)^4) / 2.0
    surfaceEmissivity = (0.34 - 0.14 * \\sqrt{\\frac{vaporPressure / 10.0}})
    cloudCoverFactor = (1.35 * (solarRadiation / clearSkySolarRadiation) - 0.35)
    Nolr = stefanBoltzman * averageT * surfaceEmissivity * cloudCoverFactor
    netRadiation= Nsr - Nolr
    netOutGoingLongWaveRadiation = Nolr


- Model meta-information

.. csv-table:: Parameters meta-information
   :header: name, description, default, min, max, unit
   :stub-columns: 1

   albedoCoefficient,albedo Coefficient,0.23,0.0,1.0,""
   stefanBoltzman,stefan Boltzman constant,4.903E-09,0.0,1.0,""
   elevation,elevation,0,-5000,10000,m


  
.. code-block:: xml

    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE ModelUnit PUBLIC " " "https://raw.githubusercontent.com/AgriculturalModelExchangeInitiative/crop2ml/master/ModelUnit.dtd">
    <ModelUnit modelid="SQ.EnergyBalancetest.NetRadiation" name="NetRadiation" timestep="1" version="1.0">
        <Description>
            <Title>NetRadiation Model</Title>
            <Authors>Pierre Martre</Authors>
            <Institution>INRA Montpellier</Institution>
            <Reference>Modelling energy balance in the wheat crop model SiriusQuality2:
                Evapotranspiration and canopy and soil temperature calculations</Reference>
            <Abstract>Calculate Net Radiation and net out going long wave radiation </Abstract>
        </Description>
        <Inputs>
            <Input name="minTair" description="minimum air temperature" variablecategory="auxiliary" datatype="DOUBLE" min="-30" max="45" default="0.7" unit="°C" uri="http://www1.clermont.inra.fr/siriusquality/?page_id=547" inputtype = "variable"/>
            <Input name="maxTair" description="maximum air Temperature" variablecategory="auxiliary"  datatype="DOUBLE" min="-30" max="45" default="7.2" unit="°C" uri="http://www1.clermont.inra.fr/siriusquality/?page_id=547" inputtype = "variable"/>
            <Input name="albedoCoefficient" description="albedo Coefficient" parametercategory="constant" datatype="DOUBLE" default="0.23" min="0" max="1" unit="" uri="http://www1.clermont.inra.fr/siriusquality/?page_id=547" inputtype="parameter"/>
            <Input name="stefanBoltzman" description="stefan Boltzman constant" parametercategory="constant" datatype="DOUBLE" default="4.903E-09" min="0" max="1" unit="" uri="http://www1.clermont.inra.fr/siriusquality/?page_id=547" inputtype="parameter"/>
            <Input name="elevation" description="elevation" parametercategory="constant"  datatype="DOUBLE" default="0" min="-500" max="10000" unit="m" uri="http://www1.clermont.inra.fr/siriusquality/?page_id=547" inputtype="parameter"/>
            <Input name="solarRadiation" description="solar Radiation" variablecategory="auxiliary" datatype="DOUBLE" default="3" min="0" max="1000" unit="MJ m-2 d-1" uri="http://www1.clermont.inra.fr/siriusquality/?page_id=547" inputtype="variable"/>
            <Input name="vaporPressure" description="vapor Pressure" variablecategory="auxiliary" datatype="DOUBLE" default="6.1" min="0" max="1000" unit="hPa" uri="http://www1.clermont.inra.fr/siriusquality/?page_id=547" inputtype="variable"/>
            <Input name="extraSolarRadiation" description="extra Solar Radiation" variablecategory="auxiliary" datatype="DOUBLE" default="11.7" min="0" max="1000" unit="MJ m2 d-1" uri="http://www1.clermont.inra.fr/siriusquality/?page_id=547" inputtype="variable"/>
        </Inputs>
        <Outputs>
            <Output name="netRadiation" description=" net radiation " variablecategory="auxiliary" datatype="DOUBLE" min="0" max="5000"  unit="MJ m-2 d-1" uri="http://www1.clermont.inra.fr/siriusquality/?page_id=547"/>
            <Output name="netOutGoingLongWaveRadiation" description="net OutGoing Long Wave Radiation " variablecategory="auxiliary" datatype="DOUBLE" min="0" max="5000"  unit="g m-2 d-1" uri="http://www1.clermont.inra.fr/siriusquality/?page_id=547"/>
        </Outputs>
        <Algorithm  language="Cyml" platform="" filename="algo/pyx/netradiation.pyx" />
        <Parametersets>
            <Parameterset name="set1" description="some values in there" >
                <Param name="elevation">0</Param>
            </Parameterset>
        </Parametersets>
        <Testsets>
            <Testset name="first" parameterset = "set1" description="some values in there" >
                <Test name ="test1">
                    <InputValue name="solarRadiation">3</InputValue>
                    <InputValue name="vaporPressure">6.1</InputValue>
                    <OutputValue name="netRadiation" precision ="3">1.566</OutputValue>
                    <OutputValue name="netOutGoingLongWaveRadiation" precision ="3">0.744</OutputValue>
                </Test>
            </Testset>
        </Testsets>
    </ModelUnit>
.. 



**Net radiation  in equivalent evaporation**
--------------------------------------------

.. literalinclude:: ../../examples/SQ_Energy_Balance/crop2ml/algo/pyx/netradiationequivalentevaporation.pyx
   :language: cython


Look at the process of Crop2ML ModelUnit Creation through this video:

.. raw:: html
    <video controls src="../videos/create_model_unit/yoga.mp4"></video> 