Edit Crop2ML ModelComposite
===========================

You can edit a ModelComposite by changing its meta-information or removing some links or adding other links.

How
---

To edit a Crop2ML ModelComposite in CropMStudio:

1. On the home interface click on "Model Edition"
2. Select the package that contains this model. The list of all ModelUnits and ModelComposite appear
3. Select the ModelComposite.
4. Edit what part you want.

Exercise:
---------

Consider the **PriestlyTaylor** model unit. Based on the meta-information below, 
create the Crop2ML ModelUnit and link it with the two others ModelUnits of the ModelComposite.

 - Model equations in CyML
  
.. literalinclude:: ../../examples/SQ_Energy_Balance/crop2ml/algo/pyx/priestlytaylor.pyx
   :language: cython
   :lineno-start: 1

- Model meta-information

.. csv-table:: Parameters meta-information
   :header: name, description, default, min, max, unit
   :stub-columns: 1

   psychrometricConstant,psychrometric Constant,0.66,0.0,1.0,""
   Alpha,Priestley-Taylor evapotranspiration proportionality constant,1.5,0.0,100.0,""

.. csv-table:: Variables meta-information
   :header: name, description, default, min, max, unit
   :stub-columns: 1

   netRadiationEquivalentEvaporation,net Radiation in Equivalent Evaporation,638.142,0.0,5000.0,"g*m-2*d-1"
   hslope,the slope of saturated vapor pressure temperature curve at a given temperature,7.2,-30.0,45.0,"hPa*degC-1"
   evapoTranspirationPriestlyTaylor,evapoTranspiration of Priestly Taylor,"",0.0,10000.0,"g*m-2*d-1"
