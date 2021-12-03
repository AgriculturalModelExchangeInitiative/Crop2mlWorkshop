Create Crop2ML ModelUnit
========================

Recall that a Crop2ML ModelUnit is composed of its specification (meta-information) represented in a xml file to which is associated an algorithm representing the relationship between the inputs and the outputs of the model.


Consider that we want to create two ModelUnits in the Energy Balance package : Net Radiation and Net radiation in equivalent evaporation.
Then in the next lines, the meta-information is provided with model equations in order to create two Crop2ML ModelUnits.

Let's go!

**Net radiation**
-----------------

- Model equations
  
.. literalinclude:: ../../examples/SQ_Energy_Balance/crop2ml/algo/pyx/netradiation.pyx
   :language: cython
   :lineno-start: 2


- Model meta-information
  
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


